-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", "<leader>bma", ':let @+ = expand("%")<CR>', { desc = "Copy current file path to clipboard" })
map(
  "n",
  "<leader>bmap",
  ':let @+ = expand("%") | normal! "+p<CR>',
  { desc = "Copy and paste current file path to clipboard" }
)
map("n", "<leader>bm", ':let @+ = expand("%:t")<CR>', { desc = "Copy current file name to clipboard" })
map("n", "<leader>bmp", ':let @+ = expand("%:t") | normal! "+p<CR>', { desc = "Copy and paste current file name" })
