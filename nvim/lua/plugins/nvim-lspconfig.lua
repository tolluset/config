return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        rust_analyzer = {
          enabled = false,
        },
        tailwindcss = {
          filetypes_exclude = { "markdown" },
          filetypes_include = { "tsx", "jsx", "typescript", "javascript" },
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          local tw = LazyVim.lsp.get_raw_config("tailwindcss")
          opts.filetypes = opts.filetypes or {}

          vim.list_extend(opts.filetypes, tw.default_config.filetypes)

          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          opts.settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
            },
          }

          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
  },
}
