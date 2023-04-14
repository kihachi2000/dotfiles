local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

-- ファイラー設定
local file_browser = {
    theme = "dropdown",
    hijack_netrw = true,
    mappings = {
        ["i"] = {
            ["<Tab>"] = actions.close,
        },
        ["n"] = {
            ["<Tab>"] = actions.close,
            ["h"] = fb_actions.goto_parent_dir,
            ["l"] = actions.select_default,
            ["."] = fb_actions.toggle_hidden,
            ["<Tab>"] = false,
            ["<S-Tab>"] = false,
            ["<CR>"] = actions.select_vertical,
        }
    }
}

-- キー設定
vim.api.nvim_set_keymap(
    "n",
    "<Tab>",
    "<cmd>Telescope file_browser hide_parent_dir=true<CR>",
    { noremap = true }
)


return file_browser
