return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      ensure_installed = { "lua", "python", "markdown", "markdown_inline", "latex" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
