return {
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        config = function()
            require('toggleterm').setup({
                open_mapping = [[<c-\>]], -- global toggle for the default terminal
                direction = 'float',
                insert_mappings = true, -- works from insert mode too
                start_in_insert = true,
                shade_terminals = true,
            })

            -- Explicit layout keymaps
            vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { desc = 'Terminal (float)' })
            vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>',
                { desc = 'Terminal (horizontal)' })
            vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<CR>',
                { desc = 'Terminal (vertical)' })

            -- Easier navigation out of terminal mode into normal mode / splits
            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-Left>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-Down>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-Up>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-Right>', [[<Cmd>wincmd l<CR>]], opts)
            end

            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end,
    },
}
