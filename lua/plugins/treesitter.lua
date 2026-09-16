return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()

		-- install the parsers you want
		require("nvim-treesitter").install({
			"lua", "vim", "vimdoc", "javascript", "typescript", "python", "bash", "markdown", "c", "cpp", "go",
		})

		-- auto-start highlighting/indent per filetype
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if lang and vim.treesitter.language.add(lang) then
					vim.treesitter.start()
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
