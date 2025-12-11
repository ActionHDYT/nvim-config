vim.keymap.set("n", "p", [["+p<esc>:%s/\r$//g<CR>]], { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })

vim.keymap.set("n", "<leader>tv", ":vsplit<cr>:term<Cr>:startinsert<Cr>", { desc = "[T]erminal Split [V]ertical" })
vim.keymap.set("n", "<leader>th", ":split<cr>:term<Cr>:startinsert<Cr>", { desc = "[T]erminal Split [H]orizontal" })

local function toggle_split_orientation()
  local current_win = vim.api.nvim_get_current_win()
  local current_width = vim.api.nvim_win_get_width(current_win)
  local current_height = vim.api.nvim_win_get_height(current_win)

  if current_width > current_height then
    -- Switch to horizontal split
    vim.cmd("wincmd K")
  else
    -- Switch to vertical split
    vim.cmd("wincmd H")
  end
end

-- Map the function to a hotkey (e.g., <leader>ts)
vim.keymap.set("n", "<leader>ts", toggle_split_orientation, { noremap = true, silent = true })

vim.keymap.set("n", "<A-j>", ":res +3<Cr>", { desc = "Decrease Window height" })
vim.keymap.set("n", "<A-k>", ":res -3<Cr>", { desc = "Increase Window height" })
vim.keymap.set("n", "<A-h>", ":vert res -5<Cr>", { desc = "Decrease Window width" })
vim.keymap.set("n", "<A-l>", ":vert res +5<Cr>", { desc = "Increase Window width" })

vim.keymap.set({ "n", "v" }, "<C-\\>", "gcc", { remap = true, desc = "toggle comment" })
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.setloclist()
end, { desc = "toggle error list" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })
vim.keymap.set({ "n", "i", "v", "o" }, "<C-s>", "<Cmd>w<Cr>", { remap = false })
vim.keymap.set("n", "<leader>v", "<C-v>", { desc = "Enter visual block mode" })
vim.keymap.set("n", "<leader>q", ":q<Cr>", { desc = "Exit current window" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>+",
  "<cmd>lua require('telescope.builtin').live_grep({default_text = vim.fn.expand('<cword>')})<CR>",
  { noremap = true, silent = true }
)
