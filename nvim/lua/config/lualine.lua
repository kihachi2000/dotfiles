local options = {}
options.theme = "yash"

local diagnostics = {"diagnostics"}
diagnostics.sources = {"nvim_diagnostic"}
diagnostics.sections = {"error", "warn"}
diagnostics.diagnostics_color = {}
diagnostics.diagnostics_color.error = "LualineError"
diagnostics.diagnostics_color.warn = "LualineWarning"
diagnostics.symbols = {}
diagnostics.symbols.error = "E"
diagnostics.symbols.warn = "W"
diagnostics.colored = true
diagnostics.update_in_insert = false
diagnostics.always_visible = false

local sections = {}
sections.lualine_a = {"mode"}
sections.lualine_b = {"branch", diagnostics}
sections.lualine_c = {"filename"}
sections.lualine_x = {"encoding"}
sections.lualine_y = {"progress"}
sections.lualine_z = {"location"}

require("lualine").setup {
    options = options,
    sections = sections,
}
