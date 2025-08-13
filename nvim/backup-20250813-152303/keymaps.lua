-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", "<leader>yp", ':let @+ = expand("%:.")<CR>', { desc = "Yank current files's path" })
map("n", "<leader>ypa", ':let @+ = expand("%")<CR>', { desc = "Yank current file's absolute path" })
map("n", "<leader>ypf", ':let @+ = expand("%:t")<CR>', { desc = "Yank current file's filename" })
map("n", "<leader>ypfx", ':let @+ = expand("%:t:r")<CR>', { desc = "Yank current file's filename no ext" })
