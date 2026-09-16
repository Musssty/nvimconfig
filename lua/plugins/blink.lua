-- lua/plugins/blink.lua
return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" }, -- optional but common: snippet collection
  version = "1.*", -- pin to stable releases; blink is under active development
  opts = {
    keymap = { preset = "none",
    			["<Tab>"] = { "select_next", "fallback" },
    			["<S-Tab>"] = { "select_prev", "fallback" },
    			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    		}, -- or "super-tab" for tab-to-select style
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = { auto_show = true },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  opts_extend = { "sources.default" },
}
