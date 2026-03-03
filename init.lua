vim.g.mapleader = " "
vim.g.maplocalleader = "//"

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.swapfile = false
vim.opt.winborder = "rounded"

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.completeopt = "menu,menuone,noselect,noinsert"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlighting when yanking text.",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local map = function(keys, func, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, keys, func, { desc = desc })
end

-- [ Mappings ] --
map("<leader>o", vim.cmd.source, "Source neovim config file")
map("<leader>w", vim.cmd.write, "Write file")
map("<leader>q", vim.cmd.quit, "Quit file")
map("<Esc>", vim.cmd.nohlsearch, "No highlight search")
map("<leader>t", ":botright 15split term:// ", "Run the terminal with the given command")
map("<leader>co", ":colorscheme ", "Select the colorscheme")
map("<leader>e", vim.cmd.Explore, "Explore file tree")

--  local term_buf = nil
--  map("<leader>t", function ()
--    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
--      local wins = vim.fn.win_findbuf(term_buf)
--      if #wins > 0 then
--        vim.api.nvim_win_close(wins[1], true)
--      else
--        vim.cmd("15split")
--        vim.api.nvim_win_set_buf(0, term_buf)
--        vim.cmd("startinsert")
--      end
--    else
--      vim.cmd("15split term://bash")
--      term_buf = vim.api.nvim_get_current_buf()
--      vim.cmd("startinsert")
--    end
--  end,
--  "Toggle the Bash Terminal")


-- [ Choosing the colorscheme ] --
-- Good options
--
-- desert
-- evening
-- everforest
-- habamax
-- lunaperche [Light theme is good, dark not so much ]
-- peachpuff  [ This is a light theme but preety good ]
-- retrobox   [ For some reason this is a dark theme but setting it after peachpuff makes it light]
-- rose-pine-moon
-- slate
-- sorbet

vim.opt.background = "light"
vim.cmd.colorscheme "retrobox"

require("config.lazy")
