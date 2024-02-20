return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = true,
  priority = 1000,
  require("catppuccin").setup({
    integrations = {
      cmp = true,
      nvimtree = true,
      gitsigns = true,
      treesitter = true,
    },
  }),
  config = function() end,
}
