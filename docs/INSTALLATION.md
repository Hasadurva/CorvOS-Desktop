# Manual installation

CorvOS Desktop is an experimental collection of i3/X11 configurations, scripts, fonts and assets. It is not an installer or a complete desktop environment package yet. These instructions describe a manual install for experienced Linux users.

The current configuration was built on Linux Mint with i3 on X11. Other distributions and desktop environments will need adjustments. Read the whole guide before copying files.

## 1. Get the repository

The current work-in-progress configuration is on `audit/desktop-configs`, not `main`.

```sh
git clone --single-branch --branch audit/desktop-configs https://github.com/Hasadurva/CorvOS-Desktop.git
cd CorvOS-Desktop
```

## 2. Check compatibility first

- **Session:** CorvOS targets i3 running on X11. Do not use this i3 config as-is in a Wayland session.
- **Existing setup:** copy over only after backing up your current configs. The commands below replace files with the same destination names.
- **Cinnamon/MATE integration:** the reference i3 config calls `cinnamon-screensaver`, `cinnamon-screensaver-command`, `cinnamon-settings`, and `/usr/libexec/polkit-mate-authentication-agent-1`. These are Linux Mint/Cinnamon-oriented. Replace or remove those lines if your system uses other screen-locking, settings, or PolicyKit tools. Check the PolicyKit agent's path on your distribution.
- **Fonts and themes:** CorvOS includes its bird font and Weather Icons font, but not Noto Sans, JetBrains Mono Nerd Font, the Gruvbox Plus icon pack, the Gruvbox GTK theme, or the Capitaine Gruvbox cursor theme.
- **Monitor setup:** the default Polybar config is single-monitor. The optional dual-monitor config assumes outputs named `DP-0` and `DP-2`; change them to match `xrandr --query` on your machine.
- **Optional widgets:** QRedshift is not in the usual Debian/Ubuntu or Arch official repositories. The default i3 config starts it, so install it or disable its startup line and Polybar module as described below.

## 3. Install package dependencies

Package names vary by distribution and release. These are starting points for Debian/Ubuntu-based systems and Arch Linux. Review the package manager's proposed changes before confirming.

### Debian, Ubuntu, and Linux Mint

```sh
sudo apt update
sudo apt install i3-wm polybar rofi picom dunst kitty btop xsettingsd dex \
  python3 fontconfig fonts-noto-core iproute2 playerctl brightnessctl wmctrl \
  ffmpeg libnotify-bin pulseaudio-utils
```

Ubuntu may require the **Universe** repository for some packages. `pulseaudio-utils` provides commands such as `pactl` and `paplay` and can also be used with a compatible PipeWire PulseAudio server. `ffmpeg` supplies `ffplay`; `libnotify-bin` supplies `notify-send`.

### Arch Linux

```sh
sudo pacman -S i3-wm polybar rofi picom dunst kitty btop xsettingsd dex \
  python fontconfig noto-fonts iproute2 playerctl brightnessctl wmctrl \
  ffmpeg libnotify libpulse
```

### Optional widget packages

- **Power Profiles Daemon:** install `power-profiles-daemon` if you want the ECO/BAL/POW module. On Debian/Ubuntu, use `sudo apt install power-profiles-daemon`; on Arch, use `sudo pacman -S power-profiles-daemon`. The profile controls depend on the daemon and hardware support.
- **QRedshift:** on Arch, see the [AUR package](https://aur.archlinux.org/packages/qredshift). On Debian/Ubuntu, download the matching `.deb` for your architecture from [QRedshift releases](https://github.com/raphaelquintao/QRedshift/releases) and install it using your package manager. See the upstream instructions before installation.
- **Gruvbox Plus icons:** install the [icon theme](https://github.com/SylEleuth/gruvbox-plus-icon-pack) separately. The [AUR package](https://aur.archlinux.org/packages/gruvbox-plus-icon-theme) is available on Arch; other distributions can use the [upstream releases](https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases).
- **JetBrains Mono Nerd Font:** the CorvOS Rofi theme uses this font name and a Nerd Font search glyph. Install a compatible Nerd Font or change the `font` setting in `configs/rofi/themes/CorvOS-Theme.rasi`.
- **Gruvbox GTK and Capitaine cursor themes:** these are referenced by `configs/xsettingsd/xsettingsd.conf` and `configs/Xresources`, but are not bundled. Install them or edit those theme names to values available on your machine.

If you do not want an optional widget, remove it from `modules-right` in the Polybar config and remove its corresponding `[module/…]` section. For QRedshift, also remove the startup command for `polybar-qredshift start` from the i3 config. If you keep the power profile module, install and enable the daemon.

## 4. Back up existing files

Back up the destination files and directories before copying anything. The following optional helper uses POSIX shell syntax, so run it inside `sh` or `bash`, not directly at a Fish prompt. It backs up only the CorvOS destination paths that already exist.

```sh
backup="$HOME/corvos-config-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup"

for path in \
  .config/i3 .config/polybar .config/rofi .config/dunst \
  .config/picom .config/btop .config/xsettingsd .Xresources \
  .local/bin/corvos .local/share/fonts/corvos.otf \
  .local/share/fonts/weathericons-regular.otf .local/share/corvos/sounds
do
  if [ -e "$HOME/$path" ]; then
    cp -a "$HOME/$path" "$backup/"
  fi
done

printf 'Backup saved to %s\n' "$backup"
```

Keep the backup until you have tested the setup. This helper backs up the installed CorvOS scripts and named font/sound files too, but it does not back up unrelated files in those directories or your Zen history. If you already manage these configs with Git, make sure the current state is committed or otherwise recoverable.

## 5. Copy configs, scripts, and assets

Run these commands from the repository root, after making the backup. They replace files with matching names in your home directory.

### Create destination directories

```sh
mkdir -p ~/.config/i3 ~/.config/polybar ~/.config/rofi/themes ~/.config/dunst
mkdir -p ~/.config/picom ~/.config/btop/themes ~/.config/xsettingsd
mkdir -p ~/.local/bin/corvos ~/.local/share/fonts ~/.local/share/corvos/sounds
```

### Install configurations

```sh
cp -a configs/i3/config ~/.config/i3/config
cp -a configs/polybar/config.ini ~/.config/polybar/config.ini
cp -a configs/dunst/dunstrc ~/.config/dunst/dunstrc
cp -a configs/picom/picom.conf ~/.config/picom/picom.conf
cp -a configs/xsettingsd/xsettingsd.conf ~/.config/xsettingsd/xsettingsd.conf
cp -a configs/rofi/config.rasi ~/.config/rofi/config.rasi
cp -a configs/rofi/themes/CorvOS-Theme.rasi \
  configs/rofi/themes/CorvOS-Theme-colors.rasi ~/.config/rofi/themes/
cp -a configs/btop/btop.conf ~/.config/btop/btop.conf
cp -a configs/btop/themes/gruvbox_dark.theme ~/.config/btop/themes/
cp -a configs/Xresources ~/.Xresources
```

The bundled `CorvOS-Theme.rasi` imports `CorvOS-Theme-colors.rasi` by filename, so keep both files together in `~/.config/rofi/themes/`. The optional `spotlight-dark.rasi` is not selected by the default config; copy it into that directory only if you want it available as an alternative.

### Install custom scripts and Zen corpus

```sh
cp -a scripts/. ~/.local/bin/corvos/
```

This copies the scripts and `zen_corpus.json.gz` together. Keep the corpus beside the `zen` script because the script loads it relative to its own location. Zen history is stored separately under `~/.local/state/corvos/zen/`.

### Install fonts and notification sound

```sh
cp -a assets/fonts/corvos.otf assets/fonts/weathericons-regular.otf ~/.local/share/fonts/
fc-cache -f ~/.local/share/fonts
cp -a assets/sounds/pda-news.ogg ~/.local/share/corvos/sounds/
```

The bundled font family names are expected to be `corvos` and `Weather Icons`. Check font matching if a glyph is missing:

```sh
fc-match corvos
fc-match "Weather Icons"
fc-match "Noto Sans SemiCondensed"
fc-match "JetBrains Mono Nerd Font"
```

If a font name resolves to an unexpected substitute, install the intended font or update the corresponding font name in the config. The `font-0` Polybar setting uses a 5-point size in the current config; increase that value if the main bar text appears too small on your display.

## 6. Choose the monitor layout

The default `configs/polybar/config.ini` does not pin a monitor, allowing Polybar to choose the primary display.

For the supplied dual-monitor layout, back up your installed Polybar config, then copy `configs/polybar/config.dual-monitor.ini` to `~/.config/polybar/config.ini`. Edit `monitor = DP-0` and `monitor = DP-2` to match the outputs from `xrandr --query`. Add this startup line to `~/.config/i3/config` so the secondary bar starts too:

```i3
exec --no-startup-id polybar secondary
```

The included i3 config starts only the primary `corvos` bar by default. Do not add the secondary startup line unless you are using the dual-monitor config.

## 7. Test before restarting your session

Validate the i3 configuration before logging out:

```sh
i3 -C -c ~/.config/i3/config
```

Check the fonts using the `fc-match` commands above. If Polybar is not already running, you can start it from a terminal to inspect errors:

```sh
polybar -c ~/.config/polybar/config.ini -l info corvos
```

Avoid starting a second copy of the bar while one is already running. Test Rofi with `rofi -show drun`, check Zen with `~/.local/bin/corvos/zen --stats`, and make sure Dunst starts and shows notifications.

After checking the config and dependencies, reload or restart i3 using your usual workflow. Keep your existing session or another recovery route available until the new setup is working.

## 8. Customise and troubleshoot

- **No weather data:** the weather widget needs an internet connection and uses Open-Meteo. The default coordinates are broad starter coordinates for Germany. The `CORVOS_WEATHER_LAT`, `CORVOS_WEATHER_LON`, `CORVOS_WEATHER_TIMEZONE`, and `CORVOS_WEATHER_LOCATION` environment variables can override them. Make sure variables are inherited by i3/Polybar, or edit the defaults in `scripts/polybar-weather`.
- **RED widget does not respond:** QRedshift must be installed and available as `qredshift`. The helper currently looks for a display name containing `DP-` in QRedshift's output; systems whose display names differ may need an adjustment to `scripts/polybar-qredshift`.
- **Power mode shows `???`:** check that `power-profiles-daemon` is installed, enabled, and supports your hardware.
- **Volume keys do nothing:** check that `pactl` is installed and can connect to your PulseAudio-compatible audio server. `playerctl` and `brightnessctl` are used by their respective media and brightness key bindings.
- **Timer notifications:** `notify-send` provides desktop notifications; `paplay` provides the completion sound when available. The sound file path is `/usr/share/sounds/freedesktop/stereo/complete.oga`, which may not exist on every distribution.
- **Date format errors:** `scripts/polybar-date` uses `en_GB.UTF-8`. Change the locale in that script if your system does not have that locale generated.
- **btop CPU power readings:** the bundled btop config enables CPU watt readings, which may require additional privileges or a supported sensor. If you do not want to configure that, set `show_cpu_watts = False` in `~/.config/btop/btop.conf`.
- **NET indicator:** the current helper checks for an IPv4 default route. An IPv6-only setup may need an adjustment to `scripts/polybar-net-status`.
- **Standalone Rofi helpers:** `rofi-audio` and `rofi-power-menu` are copied with the other scripts but are not bound to keys by the default i3 config. Add your own key bindings if you want to use them.

For file sources, attribution, and third-party licences, see [ASSET-SOURCES.md](ASSET-SOURCES.md). **Important:** the licence for the exact upstream Rofi theme source still needs confirmation. Do not redistribute the bundled adapted theme in a public release until that permission/licensing question is resolved.

## Rollback

If the setup does not work, restore the files from the backup created in step 4. If you did not create a backup, restore the individual destination files from your previous dotfiles or package defaults. Do not delete your backup until you are satisfied with the setup.
