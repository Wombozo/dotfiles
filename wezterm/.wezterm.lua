local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Geometry
config.initial_cols = 120
config.initial_rows = 28

-- Font
config.font_size = 12
config.font = wezterm.font 'JetBrains Mono NL'

-- Window
local BG = wezterm.gui.get_appearance()
config.window_decorations = "NONE"

-- Opacity
config.window_background_opacity = 0.93

-- Themes
local dark_themes = {
    -- "Gruvbox Dark (Gogh)",
    -- "Batman",
    -- "tokyonight_storm",
    -- "Cai (Gogh)",
    "Dracula",
}

local light_themes = {
    "Catppuccin Latte",
    "Mexico Light (base16)",
    "Modus-Operandi",
    "PaperColorLight (Gogh)",
    "Tinacious Design (Light)", -- limite mais ok
}

local counter_file = '/tmp/wezterm_theme_counter'
local function load_counter()
    local file = io.open(counter_file, "r")
    if file then
        local count = tonumber(file:read("*a"))
        file:close()
        return count or 0
    else
        return 0
    end
end

local function save_counter(count)
    local file = io.open(counter_file, "w")
    if file then
        file:write(tostring(count))
        file:close()
    end
end

wezterm.on("gui-startup", function(cmd)
    local counter = load_counter()
    local selected_theme
    local num_themes

    if BG == 'Light' then
        num_themes = #light_themes
        local index = (counter % #light_themes) + 1
    local file = io.open('/tmp/theme.txt', "w")
    if file then
      file:write(tostring(light_themes[index]))
      file:close()
    end
        selected_theme = light_themes[index]
    else
        num_themes = #dark_themes
        local index = (counter % #dark_themes) + 1
        selected_theme = dark_themes[index]
    end
    wezterm.log_info('Theme ' , selected_theme)
    wezterm.on('window-config-reloaded', function(window, pane)
        window:set_config_overrides({ color_scheme = selected_theme })
    end)

    if (counter + 1) >= num_themes then
        save_counter(0)
    else
        save_counter(counter + 1)
    end
    config.color_scheme = selected_theme
end)



-- Tabbar
config.enable_tab_bar = false

-- Key Bindings
config.keys = {
    {
        key = 't',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.Nop
        -- action = wezterm.action.SpawnTab 'CurrentPaneDomain'
    },
    -- {
    --     key = '}',
    --     mods = 'CTRL|SHIFT',
    --     action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain'}
    -- },
    -- {
    --     key = 'Backslash',
    --     mods = 'CTRL|SHIFT',
    --     action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain'}
    -- },
    {
        key = 'd',
        mods = 'CTRL | SHIFT',
        action = wezterm.action_callback(function(win, pane)
            local tab, window = pane:move_to_new_window()
        end),
    },
    {
        key = 'I',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                if line and line ~= '' then
                    window:perform_action(
                        wezterm.action.SwitchToWorkspace { name = line, spawn = { args = { os.getenv("SHELL") or "zsh"}, set_environment_variables = { DEBUG = "1", WEZTERM_WORKSPACE = line,}} },
                        pane
                    )
                end
            end),
        },
    },
    -- Afficher le launcher fuzzy pour lister/switcher tous les workspaces existants
    {
        key = 'i',
        mods = 'ALT',
        action = wezterm.action.ShowLauncherArgs {
            flags = 'FUZZY|WORKSPACES',
        },
    },
}

-- SSH
config.ssh_backend = "Ssh2";

return config
