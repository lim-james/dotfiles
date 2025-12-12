return {
  -- LSP core
  {
    'neovim/nvim-lspconfig',
    event = "BufReadPre",
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

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
          })
        end,
      })

      -- Keymaps
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP Go to Definition' })
      vim.keymap.set('n', 'K',  vim.lsp.buf.hover,      { desc = 'LSP Hover' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP Code Action' })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,      { desc = 'LSP Rename' })
      vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({
          async = false,
          timeout_ms = 2000,
          filter = function(client) return client.name == "null-ls" end,
        })
      end, { desc = 'Format buffer (prefer null-ls)' })

      -- Diagnostics display
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
          local diags = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
          if #diags > 0 then
            -- pick the most severe diagnostic for the current line
            table.sort(diags, function(a, b)
              return a.severity < b.severity
            end)
            vim.g.current_diag = diags[1].message
          else
            vim.g.current_diag = ''
          end
        end,
      })
    end
  },

  -- Mason (tool installer)
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'MasonInstallAll' },
    config = true,
  },

  -- Mason LSP bindings
  {
    'williamboman/mason-lspconfig.nvim',
    event = "BufReadPre",
  },

  -- Completion (COQ)
  {
    'ms-jpq/coq.nvim',
    branch = 'coq',
    event = "InsertEnter",
    dependencies = { 'ms-jpq/coq.artifacts', 'ms-jpq/coq.thirdparty' },
  },
  { 'ms-jpq/coq.artifacts', branch = 'artifacts', lazy = true },
  { 'ms-jpq/coq.thirdparty', branch = '3p', lazy = true },

  -- ===== none-ls + mason-null-ls =====
  {
    'nvimtools/none-ls.nvim',
    event = "BufReadPre",
    dependencies = {
      'williamboman/mason.nvim',
      'jay-babu/mason-null-ls.nvim',
    },
    config = function()
      require("mason").setup()
      require("mason-null-ls").setup({
        ensure_installed = { "checkstyle", "clangd" },
        automatic_installation = true,
      })

      local null_ls = require("null-ls")

      local cfg_path = vim.fn.expand("config/checkstyle/google_checks.xml")
      local has_cfg = vim.fn.filereadable(cfg_path) == 1

      local checkstyle_builtin = null_ls.builtins.diagnostics.checkstyle
      if has_cfg then
        checkstyle_builtin = checkstyle_builtin.with({
          extra_args = { "-c", cfg_path },
        })
      end

      null_ls.setup({
        sources = {
          checkstyle_builtin,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                if vim.bo[bufnr].filetype == "java" then
                  vim.lsp.buf.format({
                    async = false,
                    timeout_ms = 2000,
                    filter = function(c) return c.name == "null-ls" end,
                  })
                end
              end,
            })
          end
        end,
      })
    end,
  },
}

