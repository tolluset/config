-- Tailwind와 Biome LSP 설정
return {
  -- Tailwind CSS LSP 활성화
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
          },
          settings = {
            tailwindCSS = {
              includeLanguages = {
                typescript = "javascript",
                typescriptreact = "javascript",
              },
              classAttributes = { "class", "className" },
            },
          },
        },
        -- Biome LSP 설정
        biome = {
          settings = {
            biome = {
              lspBin = "biome",
            },
          },
        },
      },
    },
  },
  
  -- Tailwind 자동완성 (가벼운 버전)
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "roobert/tailwindcss-colorizer-cmp.nvim",
  --   },
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.formatting = opts.formatting or {}
  --     opts.formatting.format = require("tailwindcss-colorizer-cmp").formatter
  --     return opts
  --   end,
  -- },
}