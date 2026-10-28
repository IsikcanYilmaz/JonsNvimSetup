require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map('n', '<leader>g', '<cmd>Grepper -tool grep<CR>') -- leader g to invoke grepper with grep tool
map('n', ';', '<cmd>FZF<CR>') -- ; to invoke FZF

map('n', '<leader>do', '<cmd>DiffviewOpen<CR>', { desc = "Diffview open" })
map('n', '<leader>dc', '<cmd>DiffviewClose<CR>', { desc = "Diffview close" })
map('n', '<leader>dh', '<cmd>DiffviewFileHistory %<CR>', { desc = "Diffview file history" })
map('n', '<leader>dm', '<cmd>DiffviewOpen main...HEAD<CR>', { desc = "Diffview branch vs main" })

vim.api.nvim_set_keymap('i', '<C-BS>', '<C-W>', {noremap = true}) -- CTRL BKSPACE to delete word
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true})
