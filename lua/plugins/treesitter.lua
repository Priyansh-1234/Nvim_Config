return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"lua",
				"luadoc",
				"c",
				"zig",
				"ocaml",
				"python",
        "haskell",
			},

			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		},
	},
}
