vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.wo.number = true
vim.wo.relativenumber = true

-- Navegação entre panes (nativo)
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Toggle terminal horizontal com Ctrl+t
local terminal_buf = -1
local terminal_win = -1

vim.keymap.set("n", "<C-t>", function()
  if vim.api.nvim_win_is_valid(terminal_win) then
    vim.api.nvim_win_close(terminal_win, false)
    terminal_win = -1
  else
    vim.cmd("split")
    terminal_win = vim.api.nvim_get_current_win()
    if vim.api.nvim_buf_is_valid(terminal_buf) then
      vim.api.nvim_win_set_buf(terminal_win, terminal_buf)
    else
      vim.cmd("terminal")
      terminal_buf = vim.api.nvim_get_current_buf()
    end
    vim.cmd("resize 15")
    vim.cmd("startinsert")
  end
end, {})

vim.keymap.set("t", "<C-t>", function()
  if vim.api.nvim_win_is_valid(terminal_win) then
    vim.api.nvim_win_close(terminal_win, false)
    terminal_win = -1
  end
end, {})

-- Diagnósticos inline
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})
