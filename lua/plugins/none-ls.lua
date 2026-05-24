return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Formatadores
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.google_java_format,

        -- Linters
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.stylelint,    -- CSS/SCSS
        null_ls.builtins.diagnostics.hadolint,     -- Dockerfile

        -- Code actions
        null_ls.builtins.code_actions.eslint_d,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
