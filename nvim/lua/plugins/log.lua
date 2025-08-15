return {
  {
    "andrewferrier/debugprint.nvim",
    config = function()
      require("debugprint").setup({
        display_counter = false,
        print_tag = "🚀 ",
        filetypes = {
          ["js"] = {
            left = 'console.info("',
            right = '")',
            mid_var = '", ',
            right_var = ")",
          },

          ["javascript"] = {
            left = 'console.info("',
            right = '")',
            mid_var = '", ',
            right_var = ")",
          },

          ["javascriptreact"] = {
            left = 'console.info("',
            right = '")',
            mid_var = '", ',
            right_var = ")",
          },

          ["typescript"] = {
            left = 'console.info("',
            right = '")',
            mid_var = '", ',
            right_var = ")",
          },

          ["typescriptreact"] = {
            left = 'console.info("',
            right = '")',
            mid_var = '", ',
            right_var = ")",
          },
        },
      })
    end,
    version = "*",
  },
}
