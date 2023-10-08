return {
  {
    "andrewferrier/debugprint.nvim",
    config = function()
      require("debugprint").setup({
        display_counter = false,
        print_tag = "🚀 ",
      })
    end,
    version = "*",
  },
}
