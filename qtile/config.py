# ██████████████████████████████████████████████████████
# ██████████████████████████████████████████████████████
# ████                                              ████
# ████                                              ████
# ████      ██████  ████████ ██ ██      ███████     ████
# ████     ██    ██    ██    ██ ██      ██          ████
# ████     ██    ██    ██    ██ ██      █████       ████
# ████     ██ ▄▄ ██    ██    ██ ██      ██          ████
# ████      ██████     ██    ██ ███████ ███████     ████
# ████         ▀▀                                   ████
# ████                                              ████
# ██████████████████████████████████████████████████████
# ██████████████████████████████████████████████████████
 
 
 
 
# ███████████████████████████████████████████████████████████████████████████████████████
#  ___                     _      
# |_ _|_ __  _ __  ___ _ _| |_ ___
#  | || '  \| '_ \/ _ \ '_|  _(_-<
# |___|_|_|_| .__/\___/_|  \__/__/
#           |_|                   



from libqtile import layout, widget, hook, bar, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

from libqtile.dgroups import simple_key_binder

from os import path, getenv
import copy
import subprocess
import json

from typing import List

# ███████████████████████████████████████████████████████████████████████████████████████
#   ___           __ _      
#  / __|___ _ _  / _(_)__ _ 
# | (__/ _ \ ' \|  _| / _` |
#  \___\___/_||_|_| |_\__, |
#                     |___/ 


mod = "mod1"
terminal = "kitty"
follow_mouse_focus = False
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# ███████████████████████████████████████████████████████████████████████████████████████
#  _  __            
# | |/ /___ _  _ ___
# | ' </ -_) || (_-<
# |_|\_\___|\_, /__/
#           |__/    

keys = [
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "h", lazy.layout.left()),


    Key([mod], "e", lazy.layout.toggle_split()),

    Key([mod, "shift"], "k", lazy.layout.grow_up()),
    Key([mod, "shift"], "j", lazy.layout.grow_down()),
    Key([mod, "shift"], "h", lazy.layout.grow_left()),
    Key([mod, "shift"], "l", lazy.layout.grow_right()),
    Key([mod, "control"], "h", lazy.layout.swap_column_left()),
    Key([mod, "control"], "l", lazy.layout.swap_column_right()),


    Key([mod], "comma", lazy.layout.increase_nmaster()),
    Key([mod], "period", lazy.layout.decrease_nmaster()),

    Key([mod], "o", lazy.next_screen()),
    Key([mod, "shift"], "f", lazy.spawn("firefox")),
    Key([mod], "p", lazy.spawn('rofi -show drun -theme ~/dotfiles/rofi/config.rasi -display-drun "Launch"')),
    Key([mod], "s",  lazy.spawn(path.expanduser("~/dotfiles/rofi/powermenu.sh"))),
    Key([mod], "End",  lazy.spawn("playerctl play-pause -p spotify")),
    Key([mod], "Print",  lazy.spawn("/usr/local/bin/ss_clipboard.sh")),
    Key([mod,"shift"], "BackSpace",  lazy.spawn(path.expanduser("~/dotfiles/qtile/keyboard_layout cycle us fr ru"))),

    Key([], "F3", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([], "F2", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([], "F1", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),

    Key([mod], "Return", lazy.spawn(terminal)),

    Key([mod], "space", lazy.next_layout()),
    Key([mod, "shift"], "space", lazy.to_layout_index(0)),
    Key([mod, "shift"], "q", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
]

# ███████████████████████████████████████████████████████████████████████████████████████
#   ___                      
#  / __|_ _ ___ _  _ _ __ ___
# | (_ | '_/ _ \ || | '_ (_-<
#  \___|_| \___/\_,_| .__/__/
#                   |_|      

groups = [
        Group("", layout='columns'),
        Group("", layout='max',
            matches=[Match(wm_class=['firefox'])]),
        Group("", layout='max',
            matches=[Match(wm_class=['Microsoft Teams - Preview'])]),
        Group("", layout='floating',
            matches=[
                Match(wm_class=['Spotify', 'discord', 'TelegramDesktop']),
                ]),
        Group("", layout='columns'),
        Group("", layout='max'),
        Group("", layout='max',
            matches=[Match(wm_class=['Thunderbird'])]),
        Group("", layout='max'),
        ]


dgroups_key_binder = simple_key_binder(mod)


# ███████████████████████████████████████████████████████████████████████████████████████
#   ___     _            
#  / __|___| |___ _ _ ___
# | (__/ _ \ / _ \ '_(_-<
#  \___\___/_\___/_| /__/


color_data = json.loads(open(getenv('HOME')+'/.cache/wal/colors.json').read())
c1 = color_data['colors']['color1']
c2 = color_data['colors']['color2']
c3 = color_data['colors']['color3']
c4 = color_data['colors']['color4']
c5 = color_data['colors']['color5']
c6 = color_data['colors']['color6']
c7 = color_data['colors']['color7']
c8 = color_data['colors']['color8']
bg = color_data['special']['background']
fg = color_data['special']['foreground']


# ███████████████████████████████████████████████████████████████████████████████████████
#  _                       _      
# | |   __ _ _  _ ___ _  _| |_ ___
# | |__/ _` | || / _ \ || |  _(_-<
# |____\__,_|\_, \___/\_,_|\__/__/
#            |__/                 


layouts = [
    layout.Columns(
        margin = 5,
        ),
    layout.Max(),
    layout.Floating(),
]

# ███████████████████████████████████████████████████████████████████████████████████████
#  ___           
# | _ ) __ _ _ _ 
# | _ \/ _` | '_|
# |___/\__,_|_|  


widget_defaults = dict(
    font = "Mochiy Pop One",
    fontsize = 14,
    padding = 2,
    foreground= fg,
    background= bg
)
extension_defaults = widget_defaults.copy()

def wn_parse(text):
     for string in [" - Chromium", " - Firefox", "fish "]:
         text = text.replace(string, "")
     return text

def init_widgets_list():
    widgets_list = [
                widget.Sep(padding = 20, linewidth = 0), 
                widget.GroupBox(
                       margin_y = 3,
                       margin_x = 0,
                       padding_y = 5,
                       padding_x = 10,
                       borderwidth = 3,
                       active = fg,
                       inactive = c1,
                       rounded = False,
                       highlight_color = c1,
                       highlight_method = "line",
                       this_current_screen_border = bg,
                       this_screen_border = fg,
                       other_current_screen_border = bg,
                       other_screen_border = bg,
                       foreground = fg,
                       ),
                widget.CurrentLayout(),
                widget.Sep(padding = 30, linewidth = 0), 

                widget.WindowName(
                    fmt="   {0}",
                    background = c8,
                    foreground = bg,
                    format = '{name}',
                    padding = 15,
                    parse_text = wn_parse,
                    empty_group_string = "Empty group",
                    ),
                widget.Sep(padding = 20, linewidth = 0), 
                widget.GenPollText(
                    func= lambda: subprocess.check_output(path.expanduser("~/dotfiles/qtile/get_spotify_status.sh")).decode("utf-8"),
                    update_interval=1,
                    max_chars = 60,
                    background = c3,
                    foreground = bg,
                    fmt = '  {}  ',
                    ),
                widget.Spacer(length=20),

                #widget.Clipboard(
                #    fmt='Clipboard : {}     ',
                #    font = 'NotoSans Italic',
                #    max_chars = 20,
                #    padding = 5,
                #    timeout = None
                #    ),
                widget.Battery(
                    ful_char = '',
                    charge_char = '',
                    empty_char = '',
                    discharge_char = '',
                    unknown_char = '',
                    battery  = 1,
                    format = '{char} {percent:2.0%}    ',
                    padding = 5,
                    ),
                widget.KeyboardLayout(
                    fmt = '    {}  ',
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(path.expanduser("~/dotfiles/qtile/keyboard_layout cycle fr us ru"))}),
                widget.Volume(
                    fmt = '   墳  {}  ',
                    padding = 5
                    ),
                widget.Sep(padding = 20, linewidth = 0), 
                widget.Clock(format='  %a %d-%m        %H:%M'),
                widget.Sep(padding = 20, linewidth = 0), 
                widget.QuickExit(
                    fmt = '        ',
                    background = c5,
                    foreground = bg,
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(path.expanduser("~/dotfiles/rofi/powermenu.sh &"))}
                    ),
                widget.Sep(padding = 10, linewidth = 0), 
                ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=40)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=40))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

# ███████████████████████████████████████████████████████████████████████████████████████
#  ___ _            _             
# / __| |_ __ _ _ _| |_ _  _ _ __ 
# \__ \  _/ _` | '_|  _| || | '_ \
# |___/\__\__,_|_|  \__|\_,_| .__/
#                           |_|   


@hook.subscribe.startup
def autostart():
    home = path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

@hook.subscribe.startup_once
def autostart_once():
    home = path.expanduser('~/.config/qtile/autostart_once.sh')
    subprocess.call([home])
