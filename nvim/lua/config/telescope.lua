vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files theme=dropdown<CR>", { noremap = false })
vim.keymap.set("n", "<C-g>", "<cmd>Telescope live_grep theme=dropdown<CR>", { noremap = false })
vim.keymap.set("n", "<C-b>", "<cmd>Telescope buffers theme=dropdown<CR>", { noremap = false })

local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        theme = require("telescope.themes").get_dropdown(),
        preview = false,
        prompt_prefix = "  ",
        initial_mode = "normal",
        mappings = {
            ["i"] = {
                ["<Tab>"] = false,
                ["<S-Tab>"] = false,
                ["<CR>"] = actions.select_default,
                ["<S-CR>"] = actions.select_vertical,
            },
            ["n"] = {
                ["<Tab>"] = false,
                ["<S-Tab>"] = false,
                ["<CR>"] = actions.select_default,
                ["<S-CR>"] = actions.select_vertical,
            },
        },
    },
    extensions = {
        file_browser = require("config.telescope-file-browser"),
    },
})

--vim.api.nvim_set_hl(0, "TelescopeBorder", {bg="#181f3e"})
--vim.api.nvim_set_hl(0, "TelescopeMatching", {fg="#f4af24"})
--vim.api.nvim_set_hl(0, "TelescopePromptNormal", {bg="#181f3e"})
--vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {fg="#f4af24"})
--vim.api.nvim_set_hl(0, "TelescopeResultsNormal", {bg="#181f3e", fg="#d0d0d0"})
--vim.api.nvim_set_hl(0, "TelescopeSelection", {bg="#4054a5"})

require("telescope").load_extension("file_browser")
