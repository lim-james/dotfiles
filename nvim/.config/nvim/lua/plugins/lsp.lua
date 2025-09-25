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
          -- Prefer none-ls for formatting if available
          filter = function(client) return client.name == "null-ls" end,
        })
      end, { desc = 'Format buffer (prefer none-ls)' })
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

  -- ===== none-ls + mason-null-ls (NEW) =====
  {
    'nvimtools/none-ls.nvim',
    event = "BufReadPre",
    dependencies = {
      'williamboman/mason.nvim',
      'jay-babu/mason-null-ls.nvim',
    },
    config = function()
      -- Ensure tools are installed via Mason
      require("mason").setup()
      require("mason-null-ls").setup({
        ensure_installed = { "google-java-format", "checkstyle" },
        automatic_installation = true,
      })

      local null_ls = require("null-ls")

      -- Resolve optional Checkstyle config if present
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
          -- Formatter: google-java-format
          null_ls.builtins.formatting.google_java_format.with({
            extra_args = { "--aosp" },
          }),
          -- Diagnostics: Checkstyle (uses your config if found)
          checkstyle_builtin,
        },
        on_attach = function(client, bufnr)
          -- Format-on-save for Java, preferring none-ls
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

