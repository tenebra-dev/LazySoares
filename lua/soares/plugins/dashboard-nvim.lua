return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local logo = [[




  ▗       ▌        ▌    
  ▜▘█▌▛▌█▌▛▌▛▘▀▌  ▛▌█▌▌▌
  ▐▖▙▖▌▌▙▖▙▌▌ █▌▗ ▙▌▙▖▚▘
    ]]

    logo = string.rep("\n", 5) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "Telescope find_files", desc = " Find file", key = "f" },
          { action = "Telescope live_grep", desc = " Find text", key = "g" },
          { action = "qa", desc = " Quit", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 35 - #button.desc)
      button.key_format = "  %s"
    end

    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
