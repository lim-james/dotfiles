vim.g.coq_settings = {
    auto_start = 'shut-up',
    keymap = {
        jump_to_mark = '<C-m>'
    },
    display = {
        icons = {
            mode = 'none',
        }
    },
}

local lspconfig = require('lspconfig')
local coq = require('coq')

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
    function (server_name) 
        lspconfig[server_name].setup(coq.lsp_ensure_capabilities())
    end,
}
