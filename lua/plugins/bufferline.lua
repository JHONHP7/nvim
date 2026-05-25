return {

	"akinsho/bufferline.nvim",

	dependencies = { "nvim-tree/nvim-web-devicons" },

	version = "*",

	config = function()
		require("bufferline").setup({

			options = {

				mode = "buffers",

				separator_style = "slant",

				show_buffer_close_icons = true,

				show_close_icon = false,

				color_icons = true,
			},
		})

		-- Navegar entre abas

		vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", {})

		vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", {})

		-- Fechar aba atual

		vim.keymap.set("n", "<leader>x", ":bd<CR>", {})
	end,
}
