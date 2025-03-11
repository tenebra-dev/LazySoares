return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("mason").setup()
    require("mason-lspconfig").setup()
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
      capabilities = capabilities,
    })
    lspconfig.csharp_ls.setup({
      capabilities = capabilities,
    })
  end,
}
