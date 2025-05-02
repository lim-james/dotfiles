return {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = false,
        theme = 'kanagawa',
        component_separators = { left = ' ', right = ' '},
        section_separators = { left = ' ', right = ' '},
        disabled_filetypes = { statusline = {}, tabline = {} },
      },
      sections = {
        lualine_a = {'location'},
        lualine_b = { {'filename', path = 1 } }, 
        lualine_c = {},
        lualine_x = {},
        lualine_y = {'diff', 'diagnostics'},
        lualine_z = {'branch'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { {'filename', path = 1 } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'branch'}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end,
}
