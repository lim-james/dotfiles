return {
  {
    'neovim/nvim-lspconfig',
    event = "VeryLazy", 
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'ms-jpq/coq.nvim',
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local coq_present, coq = pcall(require, "coq")
      if coq_present then
        capabilities = coq.lsp_ensure_capabilities(capabilities)
      else
        print("COQ not found, using default LSP capabilities.")
      end

      require("mason-lspconfig").setup_handlers {
        function (server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
          })
        end,
      }

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP Go to Definition' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP Hover' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP Code Action' })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP Rename' })
    end
  },

  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'MasonInstallAll' },
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = "VeryLazy",
  },

  {
    'ms-jpq/coq.nvim',
    branch = 'coq',
    event = "InsertEnter", 
    dependencies = { 'ms-jpq/coq.artifacts', 'ms-jpq/coq.thirdparty' },
  },
  { 'ms-jpq/coq.artifacts', branch = 'artifacts', lazy = true },
  { 'ms-jpq/coq.thirdparty', branch = '3p', lazy = true },
}
