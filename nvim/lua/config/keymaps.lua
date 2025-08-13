-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps herelocal map = LazyVim.safe_keymap_set

local map = LazyVim.safe_keymap_set

map("n", "yp", ':let @+ = expand("%:.")<CR>', { desc = "Yank current file's path" })
map("n", "ypa", ':let @+ = expand("%")<CR>', { desc = "Yank current file's absolute path" })
map("n", "ypf", ':let @+ = expand("%:t:r")<CR>', { desc = "Yank current file's filename" })
map("n", "ypx", ':let @+ = expand("%:t")<CR>', { desc = "Yank current file's filename with ext" })

