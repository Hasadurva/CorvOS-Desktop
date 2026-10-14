# Third-party assets and licenses

CorvOS bundles the Weather Icons font and currently includes an adapted Rofi theme. Review the licensing status of every bundled third-party asset before making a public release.

## Weather Icons font (included)

CorvOS includes the unmodified OpenType font from [Erik Flowers' Weather Icons project](https://github.com/erikflowers/weather-icons).

- **Bundled font:** `assets/fonts/weathericons-regular.otf`
- **License and attribution:** `assets/fonts/OFL-Weather-Icons.txt` (SIL Open Font License 1.1)
- **Upstream font source:** [weathericons-regular.otf](https://github.com/erikflowers/weather-icons/blob/master/_docs/font-source/weathericons-regular.otf)
- **Credits:** Font and CSS work by Erik Flowers; original icon designs by Lukas Bischoff.

The Polybar configuration uses the `Weather Icons` font family. The weather script maps Open-Meteo weather codes to glyphs from this font, so users do not need to source a separate weather font.

## CorvOS Rofi theme (licensing review required)

- **Bundled files:** `configs/rofi/themes/CorvOS-Theme.rasi` and `configs/rofi/themes/CorvOS-Theme-colors.rasi`
- **Adaptation:** Customized for CorvOS by Hasadurva in 2026.
- **Source repository:** [LilAiluropoda/hyprland-gruvbox-theme](https://github.com/LilAiluropoda/hyprland-gruvbox-theme)
- **Related Rofi template attribution:** Aditya Shakya (adi1090x), [adi1090x/rofi](https://github.com/adi1090x/rofi).

**Licensing status:** the source repository linked above does not clearly identify a licence covering the exact Rofi theme files reused here. Attribution alone does not grant redistribution permission. The theme is present in this development branch while its licensing status is being checked. Do not treat the GPL-3.0 project licence in this repository as proof that the upstream theme was licensed under GPL-3.0. Before making a public release, obtain permission or clear licence information for the exact upstream files, or replace the adapted theme with an independently authored version whose licensing is clear.

The main theme imports its companion palette by relative filename. The Rofi configuration selects `~/.config/rofi/themes/CorvOS-Theme.rasi`; install both theme files into `~/.config/rofi/themes/`.

## Rofi application icons (not included)

The Rofi configuration sets `icon-theme: "Gruvbox-Plus-Dark"`. This icon theme is **not included** in CorvOS.

Get it from the [upstream Gruvbox Plus icon pack](https://github.com/SylEleuth/gruvbox-plus-icon-pack) and follow its installation instructions. The [AUR package](https://aur.archlinux.org/packages/gruvbox-plus-icon-theme) is available on Arch; other distributions can use the [upstream releases](https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases). The project uses GPL-3.0 and lists additional licences for components from other icon projects; review its licence files and notices when obtaining or redistributing it.

If you do not install the icon theme, Rofi may fall back to other available icons. You can also change `icon-theme` in your Rofi configuration to a theme already installed on your system.

## Other dependencies

The installer should check for required applications and report missing dependencies rather than silently installing packages or requiring administrator privileges. See [INSTALLATION.md](INSTALLATION.md) for manual setup instructions.
