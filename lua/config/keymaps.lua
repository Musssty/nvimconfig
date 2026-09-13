local map = vim.keymap.set

vim.g.mapleader = " "
-- map("n", "<leader>e", vim.cmd.Ex)

-- telescope
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Live grep" })
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Buffers" })
map("n", "<leader>fe", function() require("telescope.builtin").oldfiles() end, { desc = "Buffers" })

-- undotree
map("n", "<leader>u", vim.cmd.UndotreeToggle)

-- highlight and move
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- search navigation
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- window navigatoin
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")

-- diagnostics
map("n", "<leader>E", vim.diagnostic.open_float)


-- Java keymaps
vim.keymap.set('n', '<leader>jr', '<cmd>JavaRunnerRunMain<CR>', { desc = 'Java: Run main' })


-- Oil 
vim.keymap.set("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open Oil in a float" })
