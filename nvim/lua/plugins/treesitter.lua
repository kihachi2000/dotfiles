return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "bash",
            "c",
            "cpp",
            "dockerfile",
            "json",
            "lua",
            "markdown",
            "rust",
            "toml",
            "tsx",
            "typescript",
            "yaml",
        })
    end,
}
