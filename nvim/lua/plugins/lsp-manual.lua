return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Disable all auto-starting servers
      return {
        -- Add inlay_hints field to prevent errors
        inlay_hints = {
          enabled = false, -- Disable by default
        },
        -- Add codelens field to prevent errors
        codelens = {
          enabled = false, -- Disable by default
        },
        -- Add diagnostics field to prevent errors
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          severity_sort = true,
        },
        servers = {
          -- Disable all default servers by setting them to false
          lua_ls = false,
          ts_ls = false,
          tsserver = false,
          tailwindcss = {
            autostart = false, -- Auto start enabled!
          },
          biome = false,
          eslint = false,
          -- Only keep vtsls for auto start
          vtsls = {
            autostart = true, -- Auto start enabled!
            settings = {
              typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                inlayHints = {
                  enumMemberValues = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  variableTypes = { enabled = false },
                },
              },
            },
          },
        },
        -- Only allow vtsls and tailwindcss to auto-start, block all other servers
        setup = {
          ["*"] = function(server, _)
            -- return server ~= "vtsls" and server ~= "tailwindcss" -- Block all servers except vtsls and tailwindcss
            return server ~= "vtsls" -- Block all servers except vtsls and tailwindcss
          end,
        },
      }
    end,
    keys = {
      {
        "<leader>xl",
        function()
          -- Manually start vtsls
          require("lspconfig").vtsls.setup({
            autostart = true,
            settings = {
              typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                inlayHints = {
                  enumMemberValues = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  variableTypes = { enabled = false },
                },
              },
            },
          })

          -- vim.cmd("LspStart vtsls")

          -- Manually start biome
          require("lspconfig").biome.setup({
            autostart = true,
          })
          vim.cmd("LspStart biome")

          -- Manually start tailwindcss
          require("lspconfig").tailwindcss.setup({
            autostart = true,
          })
          vim.cmd("LspStart tailwindcss")

          vim.notify("Biome, TailwindCSS LSP started manually", vim.log.levels.INFO)
        end,
        desc = "Start TypeScript/Biome/TailwindCSS LSP",
      },
      { "<leader>xL", "<cmd>LspStop<cr>", desc = "Stop all LSP" },
    },
  },

  -- Disable Mason auto-install to prevent auto LSP setup
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {}, -- Don't auto-install anything
      automatic_installation = false,
    },
  },
}
