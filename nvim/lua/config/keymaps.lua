-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map("n", "yp", ':let @+ = expand("%:.")<CR>', { desc = "Yank current file's path" })
map("n", "ypa", ':let @+ = expand("%")<CR>', { desc = "Yank current file's absolute path" })
map("n", "ypf", ':let @+ = expand("%:t:r")<CR>', { desc = "Yank current file's filename" })
map("n", "ypx", ':let @+ = expand("%:t")<CR>', { desc = "Yank current file's filename with ext" })

-- Swap find files keymaps: <leader><leader> for cwd, <leader>ff for root
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Find Files (cwd)" })
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ cwd = LazyVim.root() })
end, { desc = "Find Files (root)" })

