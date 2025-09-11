-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap(
	"n",
	"<C-d>",
	"<C-d>zz",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<C-u>",
	"<C-u>zz",
	{ noremap = true, silent = true }
)

----------------
--- Markdown ---
----------------

vim.api.nvim_set_keymap(
	"n",
	"<leader>cb",
	"o```<CR>```<Esc>kA",
	{ noremap = true, silent = true, desc = "Insert Markdown code block" }
)

---------------------
--- obsidian.nvim ---
---------------------

vim.api.nvim_set_keymap(
	"n",
	"<leader>oo",
	"<Esc>:ObsidianOpen<CR>",
	{ noremap = true, silent = true, desc = "Open in Obsidian App" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>on",
	"<Esc>:ObsidianNew ",
	{ noremap = true, silent = true, desc = "New note" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ot",
	"<Esc>:ObsidianToday<CR>",
	{ noremap = true, silent = true, desc = "New today note" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>of",
	"<Esc>:ObsidianFollowLink<CR>",
	{ noremap = true, silent = true, desc = "Go to note" }
)
