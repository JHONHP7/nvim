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

    -- Configuração Java/Spring Boot
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

    -- Abre/fecha UI automaticamente
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- Atalhos
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
