-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- exit terminal mode
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\><C-n>', { noremap = true, silent = true })

