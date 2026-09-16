-- highlight and move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- search navigation
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- window navigatoin
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")

-- page up/down
vim.keymap.set("n", "<C-Down>", "<C-d>zz")
vim.keymap.set("n", "<C-Up>", "<C-u>zz")

-- highlight line or word -> sap(  replace ( with what ever yo uwant to wrap the word in

