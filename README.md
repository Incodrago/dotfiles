My dotfiles, mainly there so I can reproduce it later
nothing complicated, I use arch with hyprland with:
- kitty (terminal emulator)
- waybar (status bar)
- rofi (application launcher and wallpaper selection)
- swaync (notification center)
- pywal (grab colors from wallpapers to apply them to styles)
- swww (for setting the wallpaper. hyprpaper would've worked too but no wallpaper change animation)

You will need to give execution permissions to the files in ~/.local/bin
Specifically the files "walset" and "walset-backend".
`chmod +x ~/.local/bin/walset`
`chmod +x ~/.local/bin/walset-backend`

walset and walset-backend are meant to be used as commands in the terminal and are executed as such by hyprland when setting a wallpaper. So you will need to add them to your PATH environment variable.
To do this, add `export PATH=$PATH:/home/<your_username>/.local/bin` at the end of your .bashrc file (or .zshrc or whichever shell you use)

just to let you know changing wallpapers creates a file: `~/.cache/last_wallpaper.txt`
it's so that swww can read which wallpaper was picked last at boot and show that. Also for hyprlock (so it knows which image to show)

main shortcuts are:
- mainMod + Q to open a terminal
- mainMod + C to kill active window
- mainmod + M to exit hyprland
- mainMod + E to start file manager (dolphin)
- mainMod + I to toggle floating
- mainMod + O to pin a floating window
- mainMod + Space to open rofi
- mainMod + F to fullscreen a window
- mainMod + B to open browser (i use zen browser)
- mainMod + S to screenshot a screen (add shift for region, ctrl for window)
- mainMod + L to lock (hyprlock)
- mainMod + W to choose wallpaper among the list (list of wallpapers in ~/.config/wallpapers)
- mainMod + Shift + Arrows to move windows around
- mainMod + Numbers_from_number_row to switch workspace (/!\ warning this is set for azerty keyboards, i left the qwerty keybinds though you just have to uncomment them)
- mainMod + Shift + Numbers_from_number_row to move active window to selected workspace

no installation scripts sorry i'm sure you will need to change the hyprland config too since it's set for my monitors

work in progress

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e29f1fe9-0a81-42e1-ba27-22eba8cc7fd7" />
