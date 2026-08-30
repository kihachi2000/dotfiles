return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "bash",
            "c",
            "cpp",
            "css",
            "dockerfile",
            "html",
            "ini",
            "java",
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
