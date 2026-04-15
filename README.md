# Hammerspoon de la zero (config „max settings”)

Config complet, modular, pentru `~/.hammerspoon` cu focus pe productivitate:
- management avansat de ferestre (halves, quarters, thirds, fullscreen, hints, nudge)
- launcher de aplicații pe shortcut-uri rapide
- automatizări de sistem (caffeine, dark mode, mic mute, lock/sleep)
- clipboard manager cu istoric mare
- highlight pointer + cheatsheet hotkeys
- auto-reload la orice modificare `.lua`

## 1) Instalare
1. Instalează Hammerspoon și pornește aplicația.
2. Activează permisiunile macOS cerute:
   - **Accessibility**
   - **Automation**

## 2) Copiere config

```bash
cp -R .hammerspoon ~/.hammerspoon
```

Apoi în Hammerspoon: `Reload Config`.

## 3) Legendă hotkeys
- **Hyper** = `Ctrl + Alt + Cmd`
- **Hyper+Shift** = `Ctrl + Alt + Cmd + Shift`

## 4) Shortcut-uri

### Ferestre (Hyper)
- `← / → / ↑ / ↓`: halves
- `1 / 2 / 3 / 4`: quarters
- `5 / 6 / 7`: thirds
- `M`: maximize
- `C`: center
- `F`: toggle fullscreen
- `N`: mută pe monitorul din stânga
- `;`: mută pe monitorul din dreapta
- `=` / `-`: resize mai mare / mai mic
- `H / J / K / L`: nudge stânga / jos / sus / dreapta
- `W`: window hints

### Clipboard (Hyper)
- `V`: deschide istoricul clipboard
- `Y`: restore ultimul item din istoric

### Sistem (Hyper)
- `0`: toggle caffeine
- `9`: toggle dark mode
- `8`: mic mute/unmute
- `Return`: lock screen
- `Backspace`: pornește screensaver
- `P`: highlight cursor
- `/`: show all hotkeys
- `` ` ``: open Hammerspoon Console

### Aplicații (Hyper+Shift)
- `T`: Ghostty
- `B`: Google Chrome
- `F`: Finder
- `S`: Slack
- `E`: VS Code
- `D`: Discord
- `O`: Obsidian
- `U`: Music
- `C`: Calendar
- `N`: Notes
- `P`: chooser cu aplicațiile deschise
- `R`: reload config
- `Q`: close aplicația activă

## 5) Personalizare rapidă
Toate variabilele importante sunt în:
- `.hammerspoon/modules/config.lua`

Poți ajusta:
- lista de aplicații
- mărimea istoriei clipboard
- intervalul de polling clipboard
- pașii de resize/nudge pentru ferestre

## 6) Structură
- `init.lua` – bootstrap, auto-reload, hotkeys globale
- `modules/config.lua` – setări centrale
- `modules/window.lua` – window manager
- `modules/launcher.lua` – app launcher
- `modules/system.lua` – sistem & menubar
- `modules/clipboard.lua` – clipboard manager
- `modules/mouse.lua` – highlight cursor
