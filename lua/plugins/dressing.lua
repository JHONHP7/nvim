return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      enabled = true,
      default_prompt = "Input:",
      title_pos = "left",
      insert_only = true, -- Garante que abra direto em modo de inserção
      start_in_insert = true,
      border = "rounded",
      relative = "cursor", -- Abre a caixinha bem em cima de onde o cursor está
      prefer_width = 40,
    },
    select = {
      enabled = true,
      backend = { "telescope", "builtin" },
    },
  },
}
