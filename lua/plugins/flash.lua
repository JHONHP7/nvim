return {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = function()
    require("flash").setup()

    vim.keymap.set({ "n", "x", "o" }, "<leader>f", function() require("flash").jump() end, { desc = "Flash Jump" })
    vim.keymap.set({ "n", "x", "o" }, "<leader>F", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
  end,
}
