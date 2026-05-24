return {
  "https://gitlab.com/schrieveslaach/sonarlint.nvim",
  ft = { "java", "javascript", "typescript" },
  config = function()
    local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason")
    local jar = mason_path .. "/packages/sonarlint-language-server/extension/analyzers/sonarjava.jar"

    if not vim.uv.fs_stat(jar) then
      return
    end

    require("sonarlint").setup({
      server = {
        cmd = {
          "sonarlint-language-server",
          "-stdio",
          "-analyzers",
          jar,
        },
      },
      filetypes = { "java", "javascript", "typescript" },
    })
  end,
}
