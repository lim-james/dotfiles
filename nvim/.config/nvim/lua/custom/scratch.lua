local scratch_id = 0

local function scratch_buffer()
  scratch_id = scratch_id + 1
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.filetype = 'markdown'
  vim.bo.swapfile = false
  vim.cmd('file [Scratch ' .. scratch_id .. ']')
end

vim.keymap.set('n', '<leader>ss', scratch_buffer, { desc = 'Make current buffer a scratch buffer' })
