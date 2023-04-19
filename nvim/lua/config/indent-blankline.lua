vim.api.nvim_set_hl(0, "OddIndent", { bg="#11162c", nocombine=true })
vim.api.nvim_set_hl(0, "EvenIndent", { bg="#181f3e", nocombine=true })

require("indent_blankline").setup {
    char = "",
    char_highlight_list = {
        "OddIndent",
        "EvenIndent",
    },
    space_char_highlight_list = {
        "OddIndent",
        "EvenIndent",
    },
    show_trailing_blankline_indent = false,
}
