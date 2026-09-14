return {
---- Nightfox [ CURRENT ]
  {
    "EdenEast/nightfox.nvim",
  },

--- Everforest
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.everforest_background = "hard"
			vim.g.everforest_disable_italic_comment = 1
		end,
	},

--- Rosepine
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		priority = 1000,
	},

--- Gruber Darker
	{
		"blazkowolf/gruber-darker.nvim",
	},
}
