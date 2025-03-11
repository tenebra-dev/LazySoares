return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },
      format_on_save = function(bufnr)
        -- Verifique as variáveis global e buffer-local
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end,
    })

    -- Keymap para formatar manualmente
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })

    -- Cria comandos para habilitar/desabilitar formatação
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! vai desabilitar apenas para o buffer atual
        vim.b.disable_autoformat = true
        vim.notify("Format-on-save disabled for current buffer", vim.log.levels.INFO)
      else
        vim.g.disable_autoformat = true
        vim.notify("Format-on-save disabled globally", vim.log.levels.INFO)
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
      vim.notify("Format-on-save enabled", vim.log.levels.INFO)
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    -- Keymaps para habilitar/desabilitar formatação
    vim.keymap.set("n", "<leader>mf", function()
      if vim.g.disable_autoformat then
        vim.g.disable_autoformat = false
        vim.notify("Format-on-save enabled globally", vim.log.levels.INFO)
      else
        vim.g.disable_autoformat = true
        vim.notify("Format-on-save disabled globally", vim.log.levels.INFO)
      end
    end, { desc = "Toggle format-on-save globally" })

    vim.keymap.set("n", "<leader>mF", function()
      local bufnr = vim.api.nvim_get_current_buf()
      if vim.b[bufnr].disable_autoformat then
        vim.b[bufnr].disable_autoformat = false
        vim.notify("Format-on-save enabled for current buffer", vim.log.levels.INFO)
      else
        vim.b[bufnr].disable_autoformat = true
        vim.notify("Format-on-save disabled for current buffer", vim.log.levels.INFO)
      end
    end, { desc = "Toggle format-on-save for current buffer" })
  end,
}
