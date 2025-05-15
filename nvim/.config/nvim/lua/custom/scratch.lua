local scratch_id = 0

local function scratch_split(split_cmd)
  return function()
    scratch_id = scratch_id + 1
    vim.cmd(split_cmd)
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'wipe'
    vim.bo.swapfile = false
    vim.cmd('file [Scratch ' .. scratch_id .. ']')
  end
end

vim.keymap.set('n', '<C-w>s', scratch_split('new'),  { desc = 'Scratch horizontal split' })
vim.keymap.set('n', '<C-w>S', scratch_split('new'),  { desc = 'Scratch horizontal split' })
vim.keymap.set('n', '<C-w>v', scratch_split('vnew'), { desc = 'Scratch vertical split' })
vim.keymap.set('n', '<C-w>V', scratch_split('vnew'), { desc = 'Scratch vertical split' })

