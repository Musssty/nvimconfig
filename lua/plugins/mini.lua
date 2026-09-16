-- lua/plugins/mini.lua
return {
  	"nvim-mini/mini.nvim",
  	version = false, -- use "*" instead if you want the stable branch only
  	config = function()
    		require("mini.surround").setup()   -- e.g. sa/sd/sr for add/delete/replace surround
    		require("mini.pairs").setup()      -- auto-close brackets/quotes
		require("mini.ai").setup()
    		-- add more modules here as you want them
  	end,
}



