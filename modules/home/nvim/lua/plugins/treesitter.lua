require("nvim-treesitter").setup({
  auto_install = false, 
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },
})
