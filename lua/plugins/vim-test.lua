return {
	"vim-test/vim-test",
	cmd = { "TestNearest", "TestFile", "TestSuite", "LastTest", "TestVisit" },
	keys = {
		{ "<leader>t", "<cmd>TestNearest<CR>", desc = "Test Nearest" },
		{ "<leader>T", "<cmd>TestFile<CR>", desc = "Test File" },
		{ "<leader>a", "<cmd>TestSuite<CR>", desc = "Test Suite" },
		{ "<leader>l", "<cmd>TestLast<CR>", desc = "Test Last" },
		{ "<leader>g", "<cmd>TestVisit<CR>", desc = "Test Visit" },
	},
	config = function()
		vim.cmd("let test#strategy = 'neovim'")
	end,
}
