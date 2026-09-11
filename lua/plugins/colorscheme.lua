-- lua/plugins/colorscheme.lua
return {
    "oskarnurm/koda.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("koda").setup({
            transparent = false,
        })

        vim.cmd("colorscheme koda")
    end,
}
