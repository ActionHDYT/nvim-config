vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

    if filetype == "lazygit" then
      vim.api.nvim_buf_set_keymap(bufnr, "t", "<Esc>", "<Esc>", {
        noremap = true,
        silent = true,
        nowait = true,
      })
    end
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  callback = function()
    vim.cmd("checktime")
  end,
})
