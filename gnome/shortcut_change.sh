#!/usr/bin/env bash

# Workspaces
dconf write /org/gnome/mutter/dynamic-workspaces true
dconf write /org/gnome/desktop/wm/preferences/num-workspaces 9

dconf write /org/gnome/shell/keybindings/switch-to-application-1  "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-2  "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-3  "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-4  "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-5  "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-6  "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-7  "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-8  "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-9  "@as []"

dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1  "['<Super>1']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2  "['<Super>2']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3  "['<Super>3']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4  "['<Super>4']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-5  "['<Super>5']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-6  "['<Super>6']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-7  "['<Super>7']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-8  "['<Super>8']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-9  "['<Super>9']"

dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-1  "['<Super><Shift>1']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-2  "['<Super><Shift>2']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-3  "['<Super><Shift>3']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-4  "['<Super><Shift>4']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-5  "['<Super><Shift>5']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-6  "['<Super><Shift>6']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-7  "['<Super><Shift>7']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-8  "['<Super><Shift>8']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-9  "['<Super><Shift>9']"

# Rofi
dconf write /org/gnome/mutter/keybindings/switch-monitor "['<Super><Shift>p', 'XF86Display']"

dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'Rofi'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Super>p'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'rofi -show drun'"
