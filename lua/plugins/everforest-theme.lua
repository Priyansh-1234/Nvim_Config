return {
  {
      'sainnhe/everforest',
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.everforest_background = "hard"
        vim.g.everforest_disable_italic_comment = 1
      end,
  }
}
