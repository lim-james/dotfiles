require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'markdown', 'markdown_inline', 'python' },
    sync_install = false,
    ignore_install = { '' },
    highlight = {
        enable = true,
        disable = { '' },
        additional_viim_regex_highlighting = true,
    },
    indent = { 
        enable = true, 
        disable = { '' },
    },
}

