return {
  "tolluset/yankpath.nvim",
  config = function()
    require("yankpath").setup()
    
    -- 기존 y 키맵 제거해서 which-key에서 yankpath가 우선되게
    vim.keymap.del("n", "y", { silent = true })
    vim.keymap.del("v", "y", { silent = true })
  end,
}
