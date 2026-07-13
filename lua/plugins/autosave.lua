return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    -- enabled by default on startup
    enabled = true,
    -- only save if the buffer has been modified
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")
      if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
        return true
      end
      return false
    end,
    write_all_buffers = false,
    debounce_delay = 1000, -- ms after last change before saving
  },
  keys = {
    { "<leader><C-s>", "<cmd>ASToggle<cr>", desc = "Toggle Autosave" },
  },
}
