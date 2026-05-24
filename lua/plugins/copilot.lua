return {
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<M-[>", "<Plug>(copilot-prev)")
      vim.keymap.set("i", "<M-e>", "<Plug>(copilot-dismiss)")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("CopilotChat").setup({
        window = {
          layout = "vertical",
          width = 0.4,
        },
      })

      vim.keymap.set("n", "<leader>cc", ":CopilotChat<CR>", { desc = "Copilot Chat" })
      vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Copilot Explain" })
      vim.keymap.set("v", "<leader>cr", ":CopilotChatReview<CR>", { desc = "Copilot Review" })
      vim.keymap.set("v", "<leader>cf", ":CopilotChatFix<CR>", { desc = "Copilot Fix" })
      vim.keymap.set("v", "<leader>ct", ":CopilotChatTests<CR>", { desc = "Copilot Tests" })
      vim.keymap.set("n", "<leader>cq", function()
        local input = vim.fn.input("Pergunta: ")
        if input ~= "" then
          require("CopilotChat").ask(input)
        end
      end, { desc = "Copilot Quick Ask" })
    end,
  },
}
