return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "python", "javascript", "typescript", "go" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },  
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },
}
