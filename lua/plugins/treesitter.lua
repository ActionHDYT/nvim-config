return {
  -- nvim-treesitter is archived as of April 2026.
  -- nvim 0.12 handles highlighting and indentation natively.
  -- This plugin is kept only for :TSInstall <lang> and :TSUpdate.
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main", -- Crucial for compatibility with Neovim 0.12
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      -- OPTIMIZATION: Disable default ftplugin mapping overrides
      -- so they don't hijack your custom textobject hotkeys (e.g., in Python or Rust).
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to find the target textobject
        },
      })

      -- NOTE: on the `main` branch, textobjects no longer auto-generate keymaps
      -- from a `keymaps` table. They must be bound manually like this.
      local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject

      local function map(lhs, query)
        vim.keymap.set({ "x", "o" }, lhs, function()
          select_textobject(query, "textobjects")
        end)
      end

      map("af", "@function.outer")
      map("if", "@function.inner")
      map("ac", "@class.outer")
      map("ic", "@class.inner")
      map("ai", "@conditional.outer")
      map("ii", "@conditional.inner")
      map("aa", "@parameter.outer")
      map("ia", "@parameter.inner")
    end,
  },
}
