local awful = require "awful"
local beautiful = require "beautiful"
local menubar = require("menubar")
local username = "noize"
local scrot_path = "/home/" .. username .. "/bnd/pictures/scrot/"

-- {{{ Menu
-- Create a laucher widget and a main menu
menufile = {
   { "7-Zip", "7zFM" },
   { "Bleachbit", "bleachbit" },
   { "Archive Manager", "file-roller" },
   { "ranger", terminal .. " -e ranger" },
   { "Thunar", "thunar" },
   { "Spacefm", "spacefm" },
}

menueditors = {
   { "Pluma", "pluma" },
   { "nano", terminal .. " -e nano" },
   { "vim", terminal .. " -e vim" },
   { "nvim", terminal .. " -e nvim" },
   { "gvim", "gvim" },
   { "Emacs (CLI)", terminal .. " -e emacs -nw" },
   { "Emacs", "emacs" },
}

connsub = {
   { "ftp", terminal .. " -e ftp" },
   { "nc", terminal .. " -e nc -l 9987" },
   { "telnet", terminal .. " -e telnet" },
}

cloudsub = {
   { "( empty )" },
}

mailsub = {
   { "mutt", "mutt" },
   { "Thunderbird", "thunderbird" },
}

msgsub = {
   { "irssi", "irssi" },
   { "Discord", "discord" },
}

browsersub = {
   { "Firefox", "firefox" },
   { "Firefox Dev", "firefox-developer-edition" },
   { "Firefox Nightly", "firefox-nightly" },
   { "Midori", "midori" },
   { "Surf", "surf" },
   { "Min", "min" },
}

menuweb = {
   { "Connection", connsub },
   { "Cloud", cloudsub },
   { "Mail", mailsub },
   { "Chat", msgsub },
   { "Browser", browsersub },
}

menumultimedia = {
   { "Alsamixer", terminal .. " -e alsamixer" },
   { "Cmus", terminal .. " -e cmus" },
   { "QTV4L2", "qv4l2" },
   { "nomacs", "nomacs" },
   { "VLC", "vlc" },
}

menuoffice = {
   { "Lyx", "lyx" },
   { "LO Calc", "libreoffice --calc" },
   { "LO Draw", "libreoffice --draw" },
   { "LO Impress", "libreoffice --impress" },
   { "LO Math", "libreoffice --math" },
   { "LO Writer", "libreoffice --writer" },
}

menugfx = {
   { "GIMP", "gimp" },
   { "Blender", "blender" },
   { "Inkscape", "inkscape" },
}

menuprod = {
   { "Audacity", "audacity" },
}

menudev = {
   { "gdb", terminal .. " -e gdb" },
   { "FLUID", "fluid" },
   { "IDLE", "idle" },
   { "Qt Creator", "qtcreator" },
   { "Lua", terminal .. " -e lua" },
   { "Python", terminal .. " -e python" },
}

menuhack = {
   { "metasploit", terminal .. " -e msfconsole" },
}

menuterm = {
   { "kitty", "kitty" },
   { "xfce4-terminal", "xfce4-terminal" },
   { "Terminator", "terminator" },
   { "cool-retro-term", "cool-retro-term" },
   { "uxterm", "uxterm" },
   { "xterm", "xterm" },
   { "urxvt", "urxvt" },
   { "Alacritty", "alacritty" },
   { "tmux", terminal .. " -e tmux" },
}

menushells = {
   { "bash", terminal .. " -e bash" },
   { "sh", terminal .. " -e sh" },
   { "fish", terminal .. " -e fish" },
   { "zsh", terminal .. " -e zsh" },
   { "slsh", terminal .. " -e slsh" },
   { "tclsh", terminal .. " -e tclsh" },
   { "wish", terminal .. " -e wish" },
}

learnsub = {
   { "Anki", "anki" },
}

x11sub = {
   { "xev", terminal .. " -e xev" },
   { "xrefresh", "xrefesh" },
}

menuutil = {
   { "Learning", learnsub },
   { "X11", x11sub },
}

menunouse = {
   { "unimatrix", terminal .. " -e unimatrix" },
   { "figlet", terminal .. " --hold -e figlet " .. hostname },
}

awesomesub = {
   { "Restart", awesome.restart },
   { "Quit", awesome.quit }
}

confsub = {
   { "awesome", editor_cmd .. " " .. awesome.conffile},
   { "vim", editor_cmd .. " ~/.vimrc"},
   { "emacs", editor_cmd .. " ~/.emacs"},
   { "xresources", editor_cmd .. " ~/.Xresources"},
   { "xprofile", editor_cmd .. " ~/.xprofile"},
   { "xinitrc", editor_cmd .. " ~/.xinitrc"},
}

mansub = {
   { "awesome", terminal .. " -e man awesome" },
   { "info", terminal .. " -e info" },
}

modsub = {
   { "lsblk", terminal .. " --hold -e lsblk" },
   { "pstree", terminal .. " -e /usr/bin/pstree | less" },
   { "pstree.x11", terminal .. " -e /usr/bin/pstree.x11 | less" },
   { "htop", terminal .. " -e htop" },
}

menusys = {
   { "awesome", awesomesub },
   { "Configuration", confsub },
   { "Manual", mansub },
   { "Administration", modsub },
   { "neofetch", terminal .. " --hold -e neofetch" },
   { "Terminal", terminal }, 
   { "Reboot", "reboot" },
   { "Poweroff", "poweroff" }
}

mymainmenu = awful.menu({ items = {
                             { "File", menufile },
                             { "Editors", menueditors },
                             { "Network", menuweb },
                             { "Multimedia", menumultimedia },
                             { "Office", menuoffice },
                             { "Graphics", menugfx },
                             { "Producing", menuprod },
                             { "Development", menudev },
                             { "Hacking", menuhack },
                             { "Terminal", menuterm },
                             { "Shells", menushells },
                             { "Utilities", menuutil },
                             { "Useless", menunouse },
                             { "System", menusys },
                             { "Scrot", "scrot '" .. scrot_path .. "%Y-%m-%d-%H%M%S_$wx$h_scrot.png' -e 'optipng $f'"},
}
                       })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}











--[[
M = {}

local gears = require "gears"

M.main = awful.menu {
  items = {
    { "Terminal", terminal },
    { "Browser", browser },
    { "Editor", editor },
    {
      "Apps",
      {
        { "Files", filebrowser },
        { "Inkscape", "inkscape" },
        { "Gimp", "gimp" },
        { "Zathura", "zathura" },
        { "Disks", "gnome-disks" },
        { "Kdenlive", "kdenlive" },
      },
    },
    {
      "Utilities",
      {
        {
          "Screenshot",
          function()
            F.scr.toggle()
          end,
        },
      },
    },
    {
      "Configure",
      {
        {
          "Change theme",
          function()
            F.theme_switch.toggle()
          end,
        },
        {
          "Edit config",
          C.editor .. " " .. require("gears").filesystem.get_configuration_dir() .. "/rc.lua",
        },
      },
    },
    {
      "Exit",
      {
        { "Log out", "awesome-client 'awesome.quit()'" },
        { "Power off", "poweroff" },
        { "Restart", "reboot" },
      },
    },
  },
}
]]--
