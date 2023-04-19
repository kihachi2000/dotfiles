local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

-- ファイラー設定
local file_browser = {
    theme = "dropdown",
    hide_parent_dir = true,
    hijack_netrw = true,
    display_stat = { mode = true, size = false, date = true },
    --git_status = false,
    mappings = {
        ["i"] = {
            ["<Tab>"] = actions.close,
        },
        ["n"] = {
            ["<Tab>"] = actions.close,
            ["h"] = fb_actions.goto_parent_dir,
            ["l"] = actions.select_default,
            ["."] = fb_actions.toggle_hidden,
            ["<S-Tab>"] = false,
            ["<CR>"] = actions.select_vertical,
        }
    }
}

-- キー設定
vim.api.nvim_set_keymap(
    "n",
    "<Tab>",
    "<cmd>Telescope file_browser path=%:p:h<CR>",
    { noremap = true }
)


return file_browser
