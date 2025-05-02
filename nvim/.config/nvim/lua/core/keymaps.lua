local map = vim.keymap.set

-- Leader Key
vim.g.mapleader = ' '           -- Set leader key to space
vim.g.maplocalleader = ' '      -- Set localleader key to space
-- Prevent space from doing anything in Normal mode
map('n', '<SPACE>', '<NOP>', { silent = true })

