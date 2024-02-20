local logo = [[  ____                                 ____               
 / ___|   ___    __ _  _ __  ___  ___ |  _ \   ___ __   __
 \___ \  / _ \  / _` || '__|/ _ \/ __|| | | | / _ \\ \ / /
  ___) || (_) || (_| || |  |  __/\__ \| |_| ||  __/ \ V / 
 |____/  \___/  \__,_||_|   \___||___/|____/  \___|  \_/  
                                                          

]]
return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      config = {
        header = vim.split(string.rep("\n", 2) .. logo, "\n"),
        shortcut = {
          { desc = "[ Github]", group = "DashboardShortCut" },
          { desc = "[@soaresdev]", group = "DashboardShortCut" },
        },
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
