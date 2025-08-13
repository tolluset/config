-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Leader key setting
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 문字エンコーディング設定
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,cp932,euc-jp,sjis"

-- 多言語サポート
vim.opt.ambiwidth = "single"

-- LSP 최적화
-- vim.g.lsp_auto_start = false -- LSP 자동 시작 활성화
