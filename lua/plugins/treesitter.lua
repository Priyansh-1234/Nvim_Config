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
