local wezterm = require('wezterm')
return {
    -- General options
    hide_tab_bar_if_only_one_tab = true,
    scrollback_lines = 10000,
    audible_bell = "Disabled",

    -- Startup
    default_prog = { "wsl", "-d", "fedora-34", "--cd", "~" },

    -- Window appearance
    window_decorations = "RESIZE",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    -- Font
    font = wezterm.font_with_fallback({
        { family = 'Cascadia Mono', weight = 'DemiLight' },
    }),
    line_height = 1.15,
    font_size = 16,

    -- Theming
    colors = require("colors/catppuccin").setup({
        sync = false,
        flavour = "mocha"
    }),
    default_cursor_style = "SteadyBlock",
}

-- vim: set backupcopy=no:
