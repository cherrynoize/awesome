local awful = require "awful"
local beautiful = require "beautiful"
local theme = require("themes.neo.theme")

local hostname = "daisy~machine"

-- {{{ Menu
-- Create a laucher widget and a main menu
mainmenu = awful.menu({ items = {
                             {
                                "File",
                                {
                                   { "7-Zip", "7zFM" },
                                   { "Bleachbit", "bleachbit" },
                                   { "Archive Manager", "file-roller" },
                                   { "ranger", terminal .. " -e ranger" },
                                   { "Thunar", "thunar" },
                                   { "Spacefm", "spacefm" },
                                },
                             },
                             {
                                "Editors",
                                {
                                   { "Pluma", "pluma" },
                                   { "nano", terminal .. " -e nano" },
                                   { "vim", terminal .. " -e vim -S .vim/sessions/main.vim" },
                                   { "nvim", terminal .. " -e nvim -S .vim/sessions/main.vim" },
                                   { "gvim", "gvim" },
                                   { "Emacs (CLI)", terminal .. " -e emacs -nw" },
                                   { "Emacs", "emacs" },
                                },
                             },
                             {
                                "Network",
                                { "Connection",
                                  {
                                     { "ftp", terminal .. " -e ftp" },
                                     { "nc", terminal .. " -e nc -vkl 9987" },
                                     { "telnet", terminal .. " -e telnet" },
                                  },
                                },
                                {
                                   "Cloud",
                                   {
                                      { "( empty )" },
                                   },
                                },
                                {
                                   "Mail",
                                   {
                                      { "mutt", "mutt" },
                                      { "Thunderbird", "thunderbird" },
                                   },
                                },
                                {
                                   "Chat",
                                   {
                                      { "irssi", "irssi" },
                                      { "Discord", "discord" },
                                   },
                                },
                                {
                                   "Browser",
                                   {
                                      { "Firefox", "firefox" },
                                      { "Firefox Dev", "firefox-developer-edition" },
                                      { "Firefox Nightly", "firefox-nightly" },
                                      { "Midori", "midori" },
                                      { "Surf", "surf" },
                                      { "Min", "min" },
                                   },
                                },
                             },
                             {
                                "Multimedia",
                                {
                                   { "Alsamixer", terminal .. " -e alsamixer" },
                                   { "Cmus", terminal .. " -e cmus" },
                                   { "QV4L2", "qv4l2" },
                                   { "nomacs", "nomacs" },
                                   { "VLC", "vlc" },
                                },
                             },
                             {
                                "Office",
                                {
                                   { "Lyx", "lyx" },
                                   { "LO Calc", "libreoffice --calc" },
                                   { "LO Draw", "libreoffice --draw" },
                                   { "LO Impress", "libreoffice --impress" },
                                   { "LO Math", "libreoffice --math" },
                                   { "LO Writer", "libreoffice --writer" },
                                },
                             },
                             {
                                "Graphics",
                                {
                                   { "GIMP", "gimp" },
                                   { "Blender", "blender" },
                                   { "Inkscape", "inkscape" },
                                },
                             },
                             {
                                "Producing",
                                {
                                   {
                                      "Music",
                                      {
                                         { "Audacity", "audacity" },
                                      },
                                   },
                                   {
                                      "Video",
                                      {
                                         { "Kdenlive", "kdenlive" },
                                      },
                                   },
                                },
                             },
                             {
                                "Development",
                                {
                                   { "gdb", terminal .. " -e gdb" },
                                   { "FLUID", "fluid" },
                                   { "IDLE", "idle" },
                                   { "Qt Creator", "qtcreator" },
                                   { "Lua", terminal .. " -e lua" },
                                   { "Python", terminal .. " -e python" },
                                },
                             },
                             {
                                "Hacking",
                                {
                                   { "Metasploit", terminal .. " -e msfconsole" },
                                },
                             },
                             {
                                "Terminal",
                                {
                                   { "kitty", "kitty" },
                                   { "xfce4-terminal", "xfce4-terminal" },
                                   { "Terminator", "terminator" },
                                   { "tmux", terminal .. " -e tmux" },
                                   { "cool-retro-term", "cool-retro-term" },
                                   { "uxterm", "uxterm" },
                                   { "xterm", "xterm" },
                                   { "urxvt", "urxvt" },
                                   { "Alacritty", "alacritty" },
                                },
                             },
                             {
                                "Shells",
                                {
                                   { "bash", terminal .. " -e bash" },
                                   { "sh", terminal .. " -e sh" },
                                   { "fish", terminal .. " -e fish" },
                                   { "zsh", terminal .. " -e zsh" },
                                   { "slsh", terminal .. " -e slsh" },
                                   { "tclsh", terminal .. " -e tclsh" },
                                   { "wish", terminal .. " -e wish" },
                                },
                             },
                             {
                                "Utilities",
                                {
                                   {
                                      "Learning",
                                      {
                                         { "Anki", "anki" },
                                      },
                                   },
                                   {
                                      "X11",
                                      {
                                         { "xev", terminal .. " -e xev" },
                                         { "xrefresh", "xrefresh" },
                                      },
                                   },
                                   { "Webcam", "vlc v4l2://:input-slave=alsa://:v4l-vdev='/dev/video0'" },
                                },
                             },
                             {
                                "Useless",
                                {
                                   { "unimatrix", terminal .. " -e unimatrix" },
                                   { "figlet", terminal .. " --hold -e figlet " .. hostname },
                                   { "vis", terminal .. " -e vis" },
                                },
                             },
                             {
                                "System",
                                {
                                   {
                                      "awesome",
                                      {
                                         { "Restart", awesome.restart },
                                         { "Logout", awesome.quit }
                                      },
                                   },
                                   {
                                      "Manual",
                                      {
                                         { "awesome", terminal .. " -e man awesome" },
                                         { "info", terminal .. " -e info" },
                                      },
                                   },
                                   {
                                      "Configuration",
                                      {
                                         { "awesome", editor_cmd .. " " .. awesome.conffile},
                                         { "vim", editor_cmd .. " .vimrc"},
                                         { "emacs", editor_cmd .. " .emacs"},
                                         { "xresources", editor_cmd .. " .Xresources"},
                                         { "xprofile", editor_cmd .. " .xprofile"},
                                         { "xinitrc", editor_cmd .. " .xinitrc"},
                                      },
                                   },
                                   {
                                      "Appearance",
                                      {
                                         { "lxappearance", "lxappearance"},
                                      },
                                   },
                                   {
                                      "Administration",
                                      {
                                         { "lsblk", terminal .. " --hold -e lsblk" },
                                         { "pstree", terminal .. " -e /usr/bin/pstree | less" },
                                         { "pstree.x11", terminal .. " -e /usr/bin/pstree.x11 | less" },
                                         { "htop", terminal .. " -e htop" },
                                         { "gnome-disks", "gnome-disks" },
                                      },
                                   },
                                   { "neofetch", terminal .. " --hold -e neofetch" },
                                   { "Reboot", "reboot" },
                                   { "Poweroff", "poweroff" }
                                },
                             },
                             { "Screenshot", "snip"},
                       }})

menu_launcher = awful.widget.launcher({ image = theme.launcher_icon,
                                     menu = mainmenu })
-- }}}
