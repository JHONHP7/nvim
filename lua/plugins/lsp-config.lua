return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason")
      local lombok_path = vim.fn.expand("$HOME/.config/nvim/lombok/lombok.jar")
      local launcher = vim.fn.glob(mason_path .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")

      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.config("html", { capabilities = capabilities })
      vim.lsp.config("lua_ls", { capabilities = capabilities })
      vim.lsp.config("dockerls", { capabilities = capabilities })
      vim.lsp.config("cssls", { capabilities = capabilities })
      vim.lsp.config("jsonls", { capabilities = capabilities })
      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/spring-boot-project.json"] = "application*.yml",
            },
          },
        },
      })
      vim.lsp.config("jdtls", {
        capabilities = capabilities,
        cmd = {
          "java",
          "-javaagent:" .. lombok_path,
          "-jar", launcher,
          "-configuration", mason_path .. "/packages/jdtls/config_linux",
          "-data", vim.fn.expand("$HOME/.local/share/nvim/jdtls-workspace"),
        },
        settings = {
          java = {
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            format = { enabled = true },
          },
        },
      })

      vim.lsp.enable({
        "ts_ls", "html", "lua_ls",
        "dockerls", "cssls",
        "jsonls", "yamlls", "jdtls",
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
    end,
  },
}
