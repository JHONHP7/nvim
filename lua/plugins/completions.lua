return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Controle unificado
			vim.g.cmp_enabled = true

			cmp.setup({
				enabled = function()
					return vim.g.cmp_enabled
				end,
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})

			-- Atalho Unificado: <leader>tc alterna cmp e Copilot juntos
			vim.keymap.set("n", "<leader>tc", function()
				vim.g.cmp_enabled = not vim.g.cmp_enabled

				if vim.g.cmp_enabled then
					vim.cmd("silent! Copilot enable")
					vim.notify("Assistentes ATIVADOS (CMP + Copilot)", vim.log.levels.INFO)
				else
					vim.cmd("silent! Copilot disable")
					vim.notify("Modo Foco: DESATIVADOS (CMP + Copilot)", vim.log.levels.WARN)
				end
			end, { desc = "Toggle CMP e Copilot juntos" })
		end,
	},
}
