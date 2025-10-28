return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Disable all auto-starting servers
      opts.inlay_hints = {
        enabled = false, -- Disable by default
      }
      opts.codelens = {
        enabled = false, -- Disable by default
      }
      opts.diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      }
      opts.servers = opts.servers or {}

      -- Configure servers
      local servers = {
        -- Disable all default servers by setting them to false
        lua_ls = false,
        ts_ls = false,
        tsserver = false,
        tailwindcss = {
          autostart = true,
          filetypes = {
            "typescriptreact",
            -- "javascriptreact",
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "tailwind.config.js",
              "tailwind.config.ts",
              "tailwind.config.cjs",
              "package.json"
            )(fname)
          end,
          settings = {
            tailwindCSS = {
              includeLanguages = {
                typescriptreact = "typescriptreact",
              },
              files = {
                exclude = {
                  "**/node_modules/**/*",
                  "**/.git/**/*",
                  "**/dist/**/*",
                  "**/build/**/*",
                  "**/.next/**/*",
                  "**/.nuxt/**/*",
                  "**/coverage/**/*",
                  "**/tmp/**/*",
                  "**/.temp/**/*",
                  "**/storybook-static/**/*",
                  "**/.storybook/**/*",
                },
              },
              experimental = {
                classRegex = {
                  "tw`([^`]*)",
                  'tw="([^"]*)',
                  "tw={'([^'}]*)",
                  'tw={"([^"]*)',
                  "tw\\(.*?\\)`([^`]*)",
                  { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "classnames\\(([^)]*)\\)", "'([^']*)'" },
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  "class:\\s*?[\"'`]([^\"'`]*).*?[\"'`]",
                },
              },
              validate = false,
              lint = {
                cssConflict = "error",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
              },
              showPixelEquivalents = false,
              rootFontSize = 16,
            },
          },
        },
        biome = {
          autostart = true,
        },
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
      }

      -- Merge server configs
      for server, config in pairs(servers) do
        opts.servers[server] = config
      end

      -- Only allow vtsls, tailwindcss, biome to auto-start, block all other servers
      opts.setup = opts.setup or {}
      opts.setup["*"] = function(server, _)
        return server ~= "vtsls" and server ~= "tailwindcss" and server ~= "biome" -- Block all servers except vtsls, tailwindcss, and biome
      end

      return opts
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
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {}, -- Don't auto-install anything
      automatic_installation = false,
    },
  },
}
