-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core & custom configuration BEFORE lazy setup
require("core.globals")
require("core.options")
require("core.keymaps")
require("custom.scratch")
require("custom.markdown")

-- Setup lazy.nvim
require("lazy").setup("plugins", {
  -- You can add lazy.nvim options here, e.g.:
  -- checker = { enabled = true, notify = false }, -- Check for updates daily
  -- performance = {
  --   rtp = {
  --     -- disable some standard plugins
  --     disabled_plugins = {
  --       "gzip",
  --       "matchit",
  --       "matchparen",
  --       "netrwPlugin",
  --       "tarPlugin",
  --       "tohtml",
  --       "tutor",
  --       "zipPlugin",
  --     },
  --   },
  -- },
})

-- Optional: Anything that *must* run after plugins are loaded
-- vim.cmd.colorscheme("kanagawa-dragon") -- Already handled by plugin config
