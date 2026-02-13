-- console.info共通設定を全JS/TS filetypeに適用
local console_info = {
  left = 'console.info("',
  right = '")',
  mid_var = '", ',
  right_var = ")",
}

return {
  {
    "andrewferrier/debugprint.nvim",
    config = function()
      require("debugprint").setup({
        display_counter = false,
        print_tag = "🚀 ",
        filetypes = {
          ["js"] = console_info,
          ["javascript"] = console_info,
          ["javascriptreact"] = console_info,
          ["typescript"] = console_info,
          ["typescriptreact"] = console_info,
        },
      })
    end,
    version = "*",
  },
}
