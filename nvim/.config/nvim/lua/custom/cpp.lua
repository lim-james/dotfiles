vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    -- Set 'keywordprg' to use 'cppman' for C and C++ files
    vim.opt_local.keywordprg = "cppman"
  end,
})

-- Lua function to execute cppman in a vertical split
local function open_cppman_split(search_term)
  -- Use vsplit (vertical split) or split (horizontal split)
  vim.cmd('rightbelow vsplit')
  
  -- Open a terminal in the new split and run cppman with the term
  vim.cmd('terminal cppman ' .. search_term)

  -- This makes sure you land on the new terminal buffer
  vim.cmd('wincmd w')
end

-- Create a custom Neovim Command
vim.api.nvim_create_user_command('CppmanSplit', function(opts)
  -- The search term is taken from the command line argument
  open_cppman_split(opts.args)
end, {
  nargs = 1,
  complete = 'shellcmd', -- Optional: allows tab completion on the command line
  desc = 'Open cppman in a vertical split'
})

-- Optional: Map a key to quickly open the split for the word under the cursor
vim.keymap.set('n', '<leader>cK', function()
  -- Get the word under the cursor
  local word = vim.fn.expand('<cword>')
  open_cppman_split(word)
end, { desc = 'Open cppman split for word' })
