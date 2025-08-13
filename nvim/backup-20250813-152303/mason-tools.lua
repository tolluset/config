-- Mason에서 자동으로 설치할 LSP 서버와 도구들
return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "tailwindcss-language-server",
        "biome",
        "typescript-language-server",
        -- Formatters
        "prettier",
        -- Linters
        "eslint_d",
      },
    },
  },
}