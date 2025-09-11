-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

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
