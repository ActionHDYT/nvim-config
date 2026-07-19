return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({})
    vim.cmd.colorscheme("catppuccin")
  end,
  opts = {
    custom_highlights = function(colors) 
      return {
        DiffAdd = {bg = "#253b2a", fg = colors.green},
        DiffDelete = {bg = "#3c2529", fg = colors.red},
        DiffChange = {bg = "#1e2e3b", fg = colors.blue},
        DiffText = {bg = "#2c445b", fg = colors.yellow, bold = true},
      }
    end,
  },
}
