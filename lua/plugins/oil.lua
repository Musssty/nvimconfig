return {
  {
    "nvim-mini/mini.files",
    version = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      mappings = {
        go_in       = "<Right>",
        go_in_plus  = "<CR>",
        go_out      = "<Left>",
        go_out_plus = "<S-Left>",
      },
      windows = {
        preview = true,
        width_preview = 40,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          local mf = require("mini.files")
          if not mf.close() then
            mf.open(vim.api.nvim_buf_get_name(0), true)
          end
        end,
        desc = "File explorer (current file)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "File explorer (cwd)",
      },
    },
  },
}
