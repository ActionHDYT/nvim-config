return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({})

      -- vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "[G]it Preview [H]unk" })
    end,
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",        -- Ties both plugins together
      "nvim-telescope/telescope.nvim", -- Optional: for filtering refs
    },
    config = function()
      require("neogit").setup({
        graph_style = "ascii",
        integrations = {
          -- Replaces Neogit's default diff splits with Diffview's elegant layouts
          diffview = true, 
        },
      })
    end,
    keys = {
      { "<leader>ng", "<cmd>Neogit<cr>", desc = "Open Native Neogit Status" },
    }
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Repository Diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Compare Current File to Past Versions" },
    }
  }
}
