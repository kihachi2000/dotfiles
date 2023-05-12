vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files theme=dropdown<CR>", { noremap = false })
vim.keymap.set("n", "<C-g>", "<cmd>Telescope live_grep theme=dropdown<CR>", { noremap = false })
vim.keymap.set("n", "<C-b>", "<cmd>Telescope buffers theme=dropdown<CR>", { noremap = false })

local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        theme = require("telescope.themes").get_dropdown(),
        preview = false,
        prompt_prefix = "  ",
        initial_mode = "insert",
        mappings = {
            ["i"] = {
                ["<CR>"] = actions.select_default,
                ["<S-CR>"] = actions.select_vertical,
            },
            ["n"] = {
                ["<Tab>"] = false,
                ["<S-Tab>"] = false,
                ["l"] = actions.select_default,
                ["<CR>"] = actions.select_vertical,
            },
        },
    },
    pickers = {
        find_files = {
            mappings = {
                ["n"] = {
                    ["C-p"] = actions.close,
                },
            },
        },
        live_grep = {
            mappings = {
                ["n"] = {
                    ["C-g"] = actions.close,
                },
            },
        },
        buffers = {
            mappings = {
                ["n"] = {
                    ["C-b"] = actions.close,
                },
            },
        },
    },
    extensions = {
        file_browser = require("config.telescope-file-browser"),
    },
})

require("telescope").load_extension("file_browser")
