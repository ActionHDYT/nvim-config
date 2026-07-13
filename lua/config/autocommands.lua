vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[bufnr].filetype

    if filetype == "lazygit" then
      vim.keymap.set("t", "<Esc>", "<Esc>", {
        buffer = bufnr,
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
