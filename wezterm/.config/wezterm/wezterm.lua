local wezterm = require('wezterm')
return {
    -- General options
    hide_mouse_cursor_when_typing = false,
    hide_tab_bar_if_only_one_tab = true,
    scrollback_lines = 10000,
    audible_bell = "Disabled",
    -- term = "wezterm",

    -- Startup
    -- default_prog = { "wsl", "-d", "fedora-34", "--cd", "~" },

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
        -- { family = 'Minecraft Mono' },  -- https://github.com/IdreesInc/Monocraft
        -- { family = 'Cascadia Mono', weight = 'DemiLight' },
        -- { family = 'FiraMono Nerd Font Mono' },
    }),
    line_height = 1.15,
    font_size = 13,
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },  -- disable ligatures

    -- Theming
    color_scheme = 'Catppuccin Mocha',
    default_cursor_style = "SteadyBlock",
}

-- vim: set backupcopy=no:
