vim.cmd [[
    call plug#begin()

    Plug 'rebelot/kanagawa.nvim'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
    Plug 'neovim/nvim-lspconfig'

    Plug 'nvim-lualine/lualine.nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'ms-jpq/coq.nvim', { 'branch': 'coq' }
    Plug 'ms-jpq/coq.artifacts', { 'branch': 'artifacts' },
    Plug 'ms-jpq/coq.thirdparty', { 'branch': '3p' }

    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'

    Plug 'numToStr/FTerm.nvim'

    Plug 'folke/zen-mode.nvim'

    Plug 'nvim-lua/plenary.nvim' 
    Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }

    Plug 'wurli/visimatch.nvim'

    Plug 'christoomey/vim-tmux-navigator'
    Plug 'folke/flash.nvim'

    call plug#end()
]]

vim.opt.syntax = 'on'
vim.opt.termguicolors = true

vim.opt.compatible = false
vim.opt.showmatch = true
vim.opt.ignorecase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.cmd('filetype plugin indent on')

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.colorcolumn = '80,100'
vim.opt.signcolumn = 'yes'
vim.opt.clipboard = "unnamedplus"

vim.opt.cursorline = true
vim.opt.ttyfast = true
vim.opt.swapfile = false

vim.cmd('colorscheme kanagawa-dragon')

vim.g.mapleader = ' '
vim.keymap.set('n', '<SPACE>', '<NOP>')

require('plugins.telescope')
require('plugins.lsp')
require('plugins.treesitter')
require('plugins.lualine')
require('plugins.fterm')
require('plugins.zen')
require('plugins.harpoon')
require('plugins.vim-tmux')
require('plugins.flash')
require('visimatch').setup()

