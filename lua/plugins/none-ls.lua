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
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.hadolint,

        null_ls.builtins.diagnostics.checkstyle.with({
          extra_args = {"-c", "google_checks.xml" }, -- ou "sun_checks.xml"
        }),
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
