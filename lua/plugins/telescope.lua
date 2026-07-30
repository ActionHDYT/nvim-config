return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-l>"] = actions.select_vertical,
            }
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      telescope.load_extension("ui-select")
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Find in help" })
      vim.keymap.set("n", "gr", builtin.lsp_references, {})
    end,
  },
}
