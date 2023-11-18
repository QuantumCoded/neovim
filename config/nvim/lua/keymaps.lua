-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- exit terminal mode
vim.keymap.set('t', '<M-Esc>', '<C-Bslash><C-n>', { noremap = true, silent = true })

-- save current buffer
vim.keymap.set('n', '<leader>w', '<Cmd>w<CR>', { noremap = true, silent = true })

-- quit current buffer
vim.keymap.set('n', '<leader>q', '<Cmd>q<CR>', { noremap = true, silent = true })

-- force quit current buffer
vim.keymap.set('n', '<leader>Q', '<Cmd>q!<CR>', { noremap = true, silent = true })

-- no highlights
vim.keymap.set('n', '<leader>h', '<Cmd>noh<CR>', { noremap = true, silent = true })

