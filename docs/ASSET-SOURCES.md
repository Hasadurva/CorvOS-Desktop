# Third-party assets and licenses

CorvOS includes a small number of bundled assets. Review the licence files alongside each asset before redistribution.

## Weather Icons font

CorvOS includes the unmodified OpenType font from [Erik Flowers' Weather Icons project](https://github.com/erikflowers/weather-icons).

- **Bundled font:** `assets/fonts/weathericons-regular.otf`
- **License and attribution:** `assets/fonts/OFL-Weather-Icons.txt` (SIL Open Font License 1.1)
- **Upstream font source:** [weathericons-regular.otf](https://github.com/erikflowers/weather-icons/blob/master/_docs/font-source/weathericons-regular.otf)
- **Credits:** Font and CSS work by Erik Flowers; original icon designs by Lukas Bischoff.

The Polybar configuration uses the `Weather Icons` font family. The weather script maps Open-Meteo weather codes to glyphs from this font.

## CorvOS Rofi theme

- **Files:** `configs/rofi/themes/CorvOS-Theme.rasi` and `configs/rofi/themes/CorvOS-Theme-colors.rasi`
- **Theme:** authored and configured for CorvOS Desktop by Hasadurva in 2026.
- **Palette:** uses Gruvbox-inspired color values.

The bundled files are the CorvOS-specific implementation, not a copy of an upstream theme collection. The palette file is imported by relative filename, so install both files into `~/.config/rofi/themes/`. The Rofi configuration selects `~/.config/rofi/themes/CorvOS-Theme.rasi`.

## Rofi application icons (not included)

The Rofi configuration sets `icon-theme: "Gruvbox-Plus-Dark"`. This icon theme is **not included** in CorvOS.

Get it from the [upstream Gruvbox Plus icon pack](https://github.com/SylEleuth/gruvbox-plus-icon-pack) and follow its installation instructions. The [AUR package](https://aur.archlinux.org/packages/gruvbox-plus-icon-theme) is available on Arch; other distributions can use the [upstream releases](https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases). The project uses GPL-3.0 and lists additional licences for components from other icon projects; review its licence files and notices when obtaining or redistributing it.

If you do not install the icon theme, Rofi may fall back to other available icons. You can also change `icon-theme` in your Rofi configuration to a theme already installed on your system.

## Other dependencies

See [INSTALLATION.md](INSTALLATION.md) for manual setup and dependency information.
