return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup() -- REQUIRED

    -- Keymaps
    vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = '[A]dd File to Harpoon' })
    vim.keymap.set('n', '<leader>e', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon Quick Menu' })

    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = 'Harpoon To File 1' })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = 'Harpoon To File 2' })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = 'Harpoon To File 3' })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = 'Harpoon To File 4' })
    vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = 'Harpoon To File 5' })
    vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, { desc = 'Harpoon To File 6' })
    vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, { desc = 'Harpoon To File 7' })
    vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end, { desc = 'Harpoon To File 8' })
    vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end, { desc = 'Harpoon To File 9' })

    vim.keymap.set('n', '<leader><tab>', function() harpoon:list():next() end, { desc = 'Harpoon Next' })
    vim.keymap.set('n', '<leader><S-tab>', function() harpoon:list():prev() end, { desc = 'Harpoon Previous' })

    -- UI Extension
    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-v>", function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr, silent = true })

        vim.keymap.set("n", "<C-x>", function()
          harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr, silent = true })
      end,
    })
  end,
}
