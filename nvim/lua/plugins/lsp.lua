return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- LazyVimデフォルトはtrue、手動で無効化
      inlay_hints = { enabled = false },
      servers = {
        lua_ls = false,
        eslint = false,
        biome = { autostart = true },
      },
      setup = {
        -- vtsls, tailwindcss, biomeのみ自動起動を許可
        ["*"] = function(server, _)
          return server ~= "vtsls" and server ~= "tailwindcss" and server ~= "biome"
        end,
      },
    },
    keys = {
      { "<leader>xl", "<cmd>LspStart<cr>", desc = "Start LSP servers" },
      { "<leader>xL", "<cmd>LspStop<cr>", desc = "Stop all LSP" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    },
  },
}
