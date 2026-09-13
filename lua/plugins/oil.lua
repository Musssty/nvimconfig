return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      -- Configure the floating window appearance and size
      float = {
        -- Padding around the floating window
        -- max_width and max_height can be integers or percentages (0 to 1)
        max_width = 0.5,   -- 50% of the screen width
        max_height = 0.4,  -- 40% of the screen height
        border = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow"
        win_options = {
          winblend = 10,    -- Slight transparency (0 is fully opaque, 100 is invisible)
        },
      },
    })
  end
}
