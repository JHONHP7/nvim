return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		-- Configuração do Adaptador CodeLLDB (instalado pelo Mason)
		local mason_registry = require("mason-registry")
		local codelldb_pkg = mason_registry.get_package("codelldb")
		local extension_path = codelldb_pkg:get_install_path() .. "/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
			},
		}

		-- Configurações para depuração de C e C++
		local cpp_config = {
			{
				name = "Launch Executável",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Caminho do executável: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}

		dap.configurations.cpp = cpp_config
		dap.configurations.c = cpp_config

		-- Configura o Java/Spring Boot já existente
		dap.configurations.java = {
			{
				type = "java",
				request = "launch",
				name = "Debug Spring Boot",
			},
			{
				type = "java",
				request = "attach",
				name = "Attach to Spring Boot (porta 5005)",
				hostName = "localhost",
				port = 5005,
			},
		}

		-- Abre/fecha interface do DAP automaticamente
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Atalhos existentes do seu DAP
		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue / Start Debug" })
		vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<Leader>dO", dap.step_out, { desc = "Step Out" })
		vim.keymap.set("n", "<Leader>dx", dap.terminate, { desc = "Terminate Debug" })
		vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle Debug UI" })
		vim.keymap.set("n", "<Leader>da", function()
			dap.configurations.java = {
				{
					type = "java",
					request = "attach",
					name = "Attach to process",
					hostName = "localhost",
					port = 5005,
				},
			}
			dap.continue()
		end, { desc = "Attach to Java process (5005)" })
	end,
}
