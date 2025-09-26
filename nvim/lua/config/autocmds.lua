-- Restores the cursor after leaving Neovim
vim.api.nvim_create_autocmd("ExitPre", {
	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	command = "set guicursor=a:ver90",
	desc = "Set cursor back to beam when leaving Neovim.",
})

-- Disable package errors on Java
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "jdtls" then
			-- Override diagnostics handler only for jdtls
			client.handlers = client.handlers or {}
			client.handlers["textDocument/publishDiagnostics"] = function(
				err,
				result,
				ctx,
				config
			)
				if result and result.diagnostics then
					result.diagnostics = vim.tbl_filter(function(diagnostic)
						return not (
							diagnostic.message
							and diagnostic.message:match(
								"does not match the expected package"
							)
						)
					end, result.diagnostics)
				end
				vim.lsp.diagnostic.on_publish_diagnostics(
					err,
					result,
					ctx,
					config
				)
			end
		end
	end,
})

------------
-- Macros --
------------

-- C debug print
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

		vim.fn.setreg(
			"l",
			'yoprintf("'
				.. esc
				.. 'pa: %s\\n", '
				.. esc
				.. "p$a;"
				.. esc
				.. "0f%"
				.. esc
				.. "lv1c"
		)
	end,
})

-- C assert
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
		vim.fn.setreg(
			"k",
			"yoassert(" .. esc .. "pa != NULL" .. esc .. "A;" .. esc
		)
	end,
})

-- JS debug print
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript" },
	callback = function()
		local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
		vim.fn.setreg(
			"l",
			"yoconsole.log('" .. esc .. "pa:" .. esc .. "la, " .. esc .. "p"
		)
	end,
})

-- JS assert
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript" },
	callback = function()
		local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

		vim.fn.setreg(
			"k",
			"yoassert("
				.. esc
				.. "pa !== undefined, '"
				.. esc
				.. "pa must exist"
				.. esc
				.. ""
		)
	end,
})

-- Java debug print
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

		vim.fn.setreg(
			"l",
			'yoSystem.out.println("'
				.. esc
				.. "pa: "
				.. esc
				.. "la + "
				.. esc
				.. "p$a;"
				.. esc
		)
	end,
})


vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	callback = function(event)

    ------------
    --- html ---
    ------------
		vim.api.nvim_buf_set_keymap( event.buf, "n", "<leader>oc", "<Esc>:LivePreview close<CR>", { noremap = true, silent = true, desc = "Close LivePreview" })
		vim.api.nvim_buf_set_keymap( event.buf, "n", "<leader>os", "<Esc>:LivePreview start<CR>", { noremap = true, silent = true, desc = "Sync file in browser" })
		vim.api.nvim_buf_set_keymap( event.buf, "n", "<leader>of", "<Esc>:lua vim.ui.open(vim.fn.expand('%'))<CR>", { noremap = true, silent = true, desc = "Open file in browser" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(event)

    ---------------------
    --- obsidian.nvim ---
    ---------------------
    vim.api.nvim_set_keymap( "n", "<leader>oo", "<Esc>:ObsidianOpen<CR>", { noremap = true, silent = true, desc = "Open in Obsidian App" })
    vim.api.nvim_set_keymap( "n", "<leader>on", "<Esc>:ObsidianNew ", { noremap = true, silent = true, desc = "New note" })
    vim.api.nvim_set_keymap( "n", "<leader>ot", "<Esc>:ObsidianToday<CR>", { noremap = true, silent = true, desc = "New today note" })
    vim.api.nvim_set_keymap( "n", "<leader>of", "<Esc>:ObsidianFollowLink<CR>", { noremap = true, silent = true, desc = "Go to note" })

    ----------------
    --- markdown ---
    ----------------
    vim.api.nvim_set_keymap( "n", "<leader>cb", "o```<CR>```<Esc>kA", { noremap = true, silent = true, desc = "Insert Markdown code block" })
	end,
})

