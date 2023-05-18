vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    command = "PackerCompile",
})

-- CursorHoldが発火するまでの時間
vim.opt.updatetime = 200
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        if not require("cmp").visible() then
            vim.diagnostic.open_float(0, { scope = "cursor", focus = false })
        end
    end,
})
