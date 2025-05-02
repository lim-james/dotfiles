local fterm = require('FTerm')

fterm.setup({
    border = 'single',
    dimensions  = {
        height = 0.8,
        width = 0.6,
    },
})

local pytest = fterm:new({
    cmd = 'pytest',
    dimensions = {
        height = 0.9,
        width = 0.6,
    },
    auto_close = false,
})

local lazygit = fterm:new({
    cmd = 'lazygit',
    dimensions = {
        height = 1,
        width = 1,
    },
})

vim.keymap.set('n', '<leader>jj', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('n', '<leader>jg', function() 
    lazygit:toggle()
end)
-- vim.keymap.set('n', '<C-j>p', function() 
--     pytest:toggle()
-- end)
vim.keymap.set('t', '<leader><Esc>', '<CMD>lua require("FTerm").close()<CR>')
