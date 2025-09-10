-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

------------
-- Macros --
------------

-- C debug print
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

    vim.fn.setreg("l", 'yoprintf("' .. esc .. 'pa: %s\\n", ' .. esc .. "p$a;" .. esc .. "0f%" .. esc .. "lv1c")
  end,
})

-- C assert
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
    vim.fn.setreg("k", "yoassert(" .. esc .. "pa != NULL" .. esc .. "A;" .. esc)
  end,
})

-- JS debug print
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript" },
  callback = function()
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
    vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:" .. esc .. "la, " .. esc .. "p")
  end,
})

-- JS assert
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript" },
  callback = function()
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

    vim.fn.setreg("k", "yoassert(" .. esc .. "pa !== undefined, '" .. esc .. "pa must exist" .. esc .. "")
  end,
})
