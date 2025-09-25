return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions') 
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local action_state = require('telescope.actions.state')
    local conf = require('telescope.config').values

    telescope.setup {
      defaults = {
        layout_config = {
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
      },
    }

    -- Keymaps
    vim.keymap.set('n', '<leader>p', builtin.find_files, { desc = '[P]roject Find Files' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })

    -- Integration with Harpoon (ensure Harpoon is loaded first or handle lazily)
    local harpoon_present, harpoon = pcall(require, "harpoon")
    if not harpoon_present then
      print("Harpoon not found for Telescope integration.")
      return
    end

    local function toggle_telescope_harpoon(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
      end

      pickers.new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
              results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set('n', '<C-e>', function()
        -- Ensure the list is accessible when the keymap runs
        local harpoon_list = harpoon:list()
        toggle_telescope_harpoon(harpoon_list)
      end, { desc = "Telescope Harpoon List" })
  end,
}
