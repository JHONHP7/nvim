return {
  "danilamihailov/beacon.nvim",
  event = "VeryLazy",
  config = function()
    require("beacon").setup({
      speed = 2,        -- velocidade da animação
      width = 40,       -- largura do flash
      fps = 60,
      min_jump = 10,    -- só pisca se pular mais de 10 linhas
      cursor_events = { "CursorMoved" },
      window_events = { "WinEnter", "FocusGained" },
    })
  end,
}
