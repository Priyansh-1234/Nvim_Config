return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,

		config = function()
			local wk = require("which-key")

			wk.setup({
				preset = "helix",
				win = {
					border = "rounded",
				},
			})

			wk.add({
				{ "<leader>w", desc = "Write file" },
				{ "<leader>o", desc = "Source file" },
			})

			wk.add({
				{ "g", group = "Goto" },
				{ "gd", group = "Goto Definition" },
				{ "gr", group = "Goto Reference" },
				{ "K", group = "Hover Documentation" },
			})

      wk.add({
        {'<leader>s', group = "Search"},
        {'<leader>l', group = "LSP"}
      })
		end,
	},
}
