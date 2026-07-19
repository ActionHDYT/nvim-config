vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[bufnr].filetype

    if filetype == "lazygit" then
      vim.keymap.set("t", "<Esc>", "<Esc>", {
        buffer = bufnr,
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

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})


vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = vim.api.nvim_create_augroup("NativeAutoSave", { clear = true }),
  pattern = "*",
  callback = function()
    -- Only save if the buffer has been modified, is modifiable, and isn't a special file type
    if vim.bo.modified and vim.bo.modifiable and vim.bo.buftype == "" then
        vim.cmd("silent! write") -- 'write' forces all formatting autocmds to run seamlessly
        vim.lsp.buf.format({async = false})
    end
  end,
})
