return {
  -- nvim-treesitter is archived as of April 2026.
  -- nvim 0.12 handles highlighting and indentation natively.
  -- This plugin is kept only for :TSInstall <lang> and :TSUpdate.
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf, lang)
          end
        end,
      })
    end,
}
