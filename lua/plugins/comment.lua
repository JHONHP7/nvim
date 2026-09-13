return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	config = function()
		local ft = require("Comment.ft")

		-- C++
		ft.cpp = "//%s"

		-- Java: uma linha com //, múltiplas com javadoc
		ft.java = {
			linewise = "//%s",
			blockwise = "/**%s*/",
		}

		-- TypeScript
		ft.typescript = "//%s"
		ft.typescriptreact = "//%s"

		-- JavaScript
		ft.javascript = "//%s"
		ft.javascriptreact = "//%s"

		-- Python
		ft.python = "#%s"

		require("Comment").setup()
	end,
}
