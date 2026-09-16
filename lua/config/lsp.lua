vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local opts = { buffer = bufnr, silent = true }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)     -- go to definition
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)    -- go to declaration
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- go to implementation
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)     -- find references
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)           -- hover docs
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- rename symbol
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- code actions
		vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- prev diagnostic
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- next diagnostic
		vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, opts) -- show diagnostic
	end,
})
