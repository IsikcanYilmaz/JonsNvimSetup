require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

-- HIGHLIGHT ON YANK
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
--

-- FOLD
o.foldlevel = 99
o.foldmethod = 'indent'
o.foldnestmax = 10

-- TABSTOP, SHIFTWIDTH
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- DIAGS
vim.diagnostic.enable(false);
