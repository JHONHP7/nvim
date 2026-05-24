return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    -- Plugins facilitadores para Python e TS/JS
    "mfussenegger/nvim-dap-python",
    "mxsdev/nvim-dap-vscode-js",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    -- --- 1. CONFIGURAÇÃO APENAS PARA PYTHON / DJANGO ---
    -- (Instale o 'debugpy' via :Mason)
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/"
    require("dap-python").setup(mason_path .. "debugpy/venv/bin/python")
    
    -- Configuração específica para Django
    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Django',
      program = '${workspaceFolder}/manage.py',
      args = { 'runserver', '--noreload' },
    })

    -- --- 2. CONFIGURAÇÃO PARA TYPESCRIPT / JAVASCRIPT / ANGULAR ---
    -- (Instale o 'js-debug-adapter' via :Mason)
    require("dap-vscode-js").setup({
      node_path = "node",
      debugger_path = mason_path .. "js-debug-adapter",
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })

    for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch File (Node)",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Debug Angular (Chrome)",
          url = "http://localhost:4200", -- Porta padrão do Angular
          webRoot = "${workspaceFolder}",
          cleanUp = "every-time",
        }
      }
    end

    -- --- 3. CONFIGURAÇÃO PARA JAVA / SPRING BOOT ---
    -- Nota: Java no Neovim funciona melhor integrado ao plugin 'mfussenegger/nvim-jdtls'.
    -- O jdtls injeta os adaptadores de debug automaticamente se você tiver o 'vscode-java-debug' instalado pelo Mason.
    dap.configurations.java = {
      {
        type = 'java',
        request = 'launch',
        name = "Debug Spring Boot Application",
        -- O jdtls geralmente descobre a classe principal sozinho, mas você pode forçar ou usar o padrão dele
      },
    }

    -- --- AUTOMATIZAÇÃO DA UI ---
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- --- ATALHOS DE TECLADO ---
    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "DAP Continue" })
    vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "DAP Step Into" })
    vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "DAP Step Over" })
    vim.keymap.set("n", "<Leader>dO", dap.step_out, { desc = "DAP Step Out" })
    vim.keymap.set("n", "<Leader>dx", dapui.close, { desc = "DAP Close UI" })
  end,
}
