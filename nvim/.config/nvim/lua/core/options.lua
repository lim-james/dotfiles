local opt = vim.opt -- Alias for convenience

-- Appearance & UI
opt.syntax = 'on'           -- Enable syntax highlighting
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.number = true           -- Show line numbers
opt.relativenumber = true   -- Show relative line numbers
opt.cursorline = true       -- Highlight the current line
opt.signcolumn = 'yes'      -- Always show the sign column
opt.showmatch = true        -- Highlight matching brackets
opt.colorcolumn = '100,120' -- Show columns at 100 and 120
opt.ttyfast = true          -- Faster redrawing (might be default now)

-- Behavior
opt.compatible = false      -- Use Neovim defaults (important!)
opt.ignorecase = true       -- Ignore case in search patterns
opt.smartcase = true        -- Override ignorecase if search pattern has uppercase letters
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.swapfile = false        -- Disable swap files
opt.mouse = 'a'             -- Enable mouse support in all modes (optional)

-- Indentation
opt.tabstop = 4             -- Number of visual spaces per TAB
opt.softtabstop = 4         -- Number of spaces TAB counts for in insert mode
opt.shiftwidth = 4          -- Number of spaces to use for autoindent
opt.expandtab = true        -- Use spaces instead of tabs
opt.autoindent = true       -- Copy indent from current line when starting new line
vim.cmd('filetype plugin indent on') -- Enable filetype detection, plugins, and indenting

-- Search
opt.hlsearch = true         -- Highlight search results
opt.incsearch = true        -- Show incremental search results

