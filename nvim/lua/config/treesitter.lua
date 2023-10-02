require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        disable = {"vim"},
        additional_vim_regex_highlighting = false,
    },
})
