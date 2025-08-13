-- 최소한의 nvim 설정 테스트용
-- 사용법: nvim -u ~/.config/nvim/init-minimal.lua

-- lazy.nvim만 설치
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- 플러그인 없이 순수 nvim만
require("lazy").setup({
  -- 아무것도 설치하지 않음
}, {
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin", "netrwPlugin"
      },
    },
  },
})

print("=== Minimal Nvim Loaded ===")