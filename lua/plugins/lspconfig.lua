return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    -- mason-lspconfig v2: automatic_setup/handlers are removed.
    -- Use automatic_enable (default: true) + vim.lsp.config for per-server settings.
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright" },
        -- automatic_enable = true is the default; installed servers are enabled automatically.
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- Per-server config using the native vim.lsp.config API (0.11+).
      -- blink.cmp capabilities are merged in automatically when blink.cmp is loaded.
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config("pyright", {})
      vim.lsp.config("rust_analyzer", {})

      -- Explicitly enable servers (also covers any auto-installed servers not listed above).
      vim.lsp.enable({ "lua_ls", "pyright", "rust_analyzer" })

      -- LSP keymaps scoped to the buffer that the server attaches to.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(event)
          local buf = event.buf
          local opts = { buffer = buf }

          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "gR", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "[C]ode [A]ction" }))
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          vim.keymap.set("n", "<leader>s", ":Telescope lsp_document_symbols<Cr>", vim.tbl_extend("force", opts, { desc = "Document [S]ymbols" }))
          vim.keymap.set("n", "<leader>S", ":Telescope lsp_dynamic_workspace_symbols<Cr>", vim.tbl_extend("force", opts, { desc = "Workspace [S]ymbols" }))
        end,
      })
    end,
  },
}
