return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>gf",
      function()
        require("conform").format({ async = true })
      end,
      desc = "[G]it [F]ormat (manual)",
    },
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      desc = "[C]ode [F]ormat",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
    },
    -- Format on save
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback", -- fall back to LSP formatting if no formatter configured
    },
  },
}
