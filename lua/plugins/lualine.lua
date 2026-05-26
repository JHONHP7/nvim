return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
  },
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin-mocha",
      },
    })
  end,
}
