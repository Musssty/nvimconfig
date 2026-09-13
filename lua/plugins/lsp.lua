return {
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        handlers = {
          -- generic/default handler for every other server
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- specific handler for pyright
          ["pyright"] = function()
            require("lspconfig").pyright.setup({
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic", -- default; toggle via :Pyright
                  },
                },
              },
            })
          end,
        },
      })

      -- :Pyright strict / :Pyright basic / :Pyright off
      vim.api.nvim_create_user_command("Pyright", function(opts)
        for _, c in ipairs(vim.lsp.get_clients({ name = "pyright" })) do
          c.config.settings.python.analysis.typeCheckingMode = opts.args
          c.notify("workspace/didChangeConfiguration", { settings = c.config.settings })
        end
      end, {
        nargs = 1,
        complete = function()
          return { "strict", "basic", "standard", "off" }
        end,
      })
    end,
  },
}
