# Assets to source separately

CorvOS does not bundle every third-party font or icon theme referenced by the desktop configuration. Install these yourself before enabling the related features.

## Polybar weather icons

The Polybar configuration currently requests a font family named `Cinnamon Weather`, and `scripts/polybar-weather` emits private-use glyphs U+E000–U+E00D. That font is **not included** in this repository.

The original font file used by the author is a custom `CinnamonWeather.otf`; its redistribution licence and exact relationship to upstream icon artwork have not been verified. CorvOS therefore does not redistribute it or claim it is covered by the licence of another weather-icon project.

Options:

- Obtain a copy of the exact font from a source whose redistribution terms you have checked, and install it for your own user.
- Alternatively, replace the font and update the glyph mapping in `scripts/polybar-weather` to match a different icon font. Do not assume that another font uses the same private-use codepoints.

For reference, the separate upstream [Weather Icons project](https://github.com/erikflowers/weather-icons) states that its font is licensed under the SIL Open Font License 1.1. That licence statement applies to that project’s font, not automatically to the custom Cinnamon Weather font.

## Rofi application icons

The Rofi configuration sets `icon-theme: "Gruvbox-Plus-Dark"`. This icon theme is **not included** in CorvOS.

Get it from the [upstream Gruvbox Plus icon pack](https://github.com/SylEleuth/gruvbox-plus-icon-pack) and follow its installation instructions. The upstream project identifies GPL-3.0 as its project licence and lists additional licences for components from other icon projects; review its licence files and notices when obtaining or redistributing it.

If you do not install the icon theme, Rofi may fall back to other available icons. You can also change `icon-theme` in your Rofi configuration to a theme already installed on your system.

## Other dependencies

The installer should check for required applications and report missing dependencies rather than silently installing packages or requiring administrator privileges. See the main installation guide for the supported desktop components.
