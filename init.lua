-- ============================================================================
-- Simple NVIM Config
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ============================================================================
-- OPTIONS
-- ============================================================================

vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 4
vim.o.signcolumn = "yes"          -- stops text shifting when diagnostics appear
vim.o.scrolloff = 10
vim.o.wrap = false
vim.o.termguicolors = true

-- smear-cursor does not get along with an empty guicursor
-- vim.o.guicursor = ""

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true             -- undodir defaults to stdpath("state").."/undo"

vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true            -- a capital in the query makes it case-sensitive

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.updatetime = 250

vim.o.foldmethod = "expr"         -- treesitter sets foldexpr below
vim.o.foldlevelstart = 99         -- ...but don't open files folded shut

-- ============================================================================
-- PLUGINS
-- ============================================================================

vim.pack.add({
  { src = "https://github.com/oskarnurm/koda.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim",                     version = "stable" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",         version = "main" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/saghen/blink.cmp",                        version = vim.version.range("1.*") },
  { src = "https://github.com/rafamadriz/friendly-snippets" },

  -- LSP. mason must come before mason-lspconfig.
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },

  -- pinned: main is broken as of Sep 2026, see issue #179
  { src = "https://github.com/sphamba/smear-cursor.nvim",               version = "507b9ed5a133bf8c19d30aef8f8ee8512d0ca6bf" },
})

-- build steps: vim.pack has no `build` field, so hook the PackChanged event
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    if name == "telescope-fzf-native.nvim" then
      vim.system({ "make" }, { cwd = ev.data.path })
    elseif name == "nvim-treesitter" then
      vim.cmd("TSUpdate")
    end
  end,
})

-- built-in plugins that ship with Neovim but are opt-in
vim.cmd.packadd("nvim.undotree")

-- ============================================================================
-- COLORSCHEME
-- ============================================================================

vim.cmd.colorscheme("koda-dark")

-- ============================================================================
-- mini.nvim
-- ============================================================================

require("mini.surround").setup()  -- sa / sd / sr to add, delete, replace
require("mini.pairs").setup()     -- auto-close brackets and quotes
require("mini.ai").setup()        -- better a/i textobjects

-- ============================================================================
-- oil.nvim
-- ============================================================================

require("oil").setup({
  default_file_explorer = true,
  columns = { "icon" },
  view_options = { show_hidden = true },
  keymaps = {
    ["<CR>"] = "actions.select",
    ["<Right>"] = "actions.select",
    ["<Left>"] = "actions.parent",
    ["q"] = "actions.close",
    ["gp"] = "actions.preview",
  },
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Parent directory" })
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File explorer" })

-- ============================================================================
-- telescope
-- ============================================================================

require("telescope").setup({})
pcall(require("telescope").load_extension, "fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fe", builtin.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fs", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Grep string" })

-- ============================================================================
-- treesitter
-- ============================================================================

require("nvim-treesitter").setup()

require("nvim-treesitter").install({
  "lua", "vim", "vimdoc", "javascript", "typescript",
  "python", "bash", "markdown", "c", "cpp", "go",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})

-- ============================================================================
-- toggleterm
-- ============================================================================

require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  direction = "float",
  insert_mappings = true,
  start_in_insert = true,
  shade_terminals = true,
})

vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal (float)" })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Terminal (horizontal)" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", { desc = "Terminal (vertical)" })

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("term_keymaps", { clear = true }),
  pattern = "term://*",
  callback = function()
    local opts = { buffer = 0 }
    -- note: this eats <esc> inside TUIs like lazygit. Use <C-\><C-n> there.
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-Left>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-Down>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-Up>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-Right>", [[<Cmd>wincmd l<CR>]], opts)
  end,
})

-- ============================================================================
-- smear-cursor
-- ============================================================================

require("smear_cursor").setup({
  stiffness = 0.8,
  trailing_stiffness = 0.5,
  distance_stop_animating = 0.5,
})

-- ============================================================================
-- blink.cmp
-- ============================================================================

require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  },
  completion = {
    list = {
      selection = { preselect = false, auto_insert = false },
    },
    documentation = { auto_show = true },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})

-- ============================================================================
-- LSP
-- ============================================================================

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "clangd" },
  -- automatic_enable defaults to true: installed servers get vim.lsp.enable()d
})

-- tell servers what blink can do on top of Neovim's built-in capabilities
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
})

-- per-server tweaks. cmd/filetypes/root_markers come from nvim-lspconfig,
-- so only the things you actually want to change go here.
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
    },
  },
})

local sev = vim.diagnostic.severity
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded", source = true },
  signs = {
    text = {
      [sev.ERROR] = "E",
      [sev.WARN] = "W",
      [sev.INFO] = "I",
      [sev.HINT] = "H",
    },
  },
})

-- Neovim provides grn (rename), gra (code action), grr (references),
-- gri (implementation), grt (type definition) and K (hover) by default.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, opts)
  end,
})

-- ============================================================================
-- KEYMAPS
-- ============================================================================

-- move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- keep the cursor centred
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- window navigation
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Window right" })

-- paste over a selection without clobbering the register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

vim.keymap.set("n", "<leader>u", "<cmd>Undotree<cr>", { desc = "Undo tree" })

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

-- tabs, 8 wide, for C-family and Lua
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("tab_indent", { clear = true }),
  pattern = { "c", "cpp", "lua" },
  callback = function(args)
    local bo = vim.bo[args.buf]
    bo.tabstop = 8
    bo.shiftwidth = 8
    bo.expandtab = false
    bo.autoindent = true
    bo.copyindent = true
    bo.preserveindent = true
  end,
})

-- briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("yank_highlight", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
