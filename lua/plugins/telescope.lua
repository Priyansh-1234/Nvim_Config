return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({})

			local builtin = require("telescope.builtin")
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { desc = "Telescope: " .. desc })
			end

      map("<leader>sd", builtin.lsp_document_symbols, "Document Symbols")
			map("<leader>sh", builtin.help_tags, "Search Help")
			map("<leader>sf", builtin.find_files, "Search File")
			map("<leader>sr", builtin.oldfiles, "Search Recent")
		end,
	},
}
