-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local hardmode = true
if hardmode then
  local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]
  vim.api.nvim_set_keymap("n", "<Up>", msg, { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Down>", msg, { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Left>", msg, { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Right>", msg, { noremap = true, silent = true })
end

vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
