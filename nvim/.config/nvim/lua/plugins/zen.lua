-- require("zen-mode").setup()

return { 
    'folke/zen-mode.nvim',
    keys = {
        { '<leader>z', '<CMD>ZenMode<CR>', desc = 'Zen Mode' },
    },
    opts = {
        window = {
            width = 100,
        },
    },
}
