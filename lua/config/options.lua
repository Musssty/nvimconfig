vim.opt.clipboard = "unnamedplus"

vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.numberwidth = 4
vim.opt.smartindent = true
vim.opt.indentexpr = ""

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- C/C++ indenting (tabs, width 8 — Linux-kernel style, matches SalarAlo's config)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function(args)
        local bo = vim.bo[args.buf]
        bo.tabstop = 8
        bo.shiftwidth = 8
        bo.expandtab = false
        bo.autoindent = true
        bo.smartindent = true
        bo.copyindent = true
        bo.preserveindent = true
    end,
})
