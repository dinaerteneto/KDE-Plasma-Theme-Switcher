# KDE Plasma Theme Switcher

This project provides an automatic theme switching script for KDE5 Plasma, allowing you to switch between light and dark themes at specified times. The script applies the Plasma style, colors, window decorations, icons, and wallpaper. 

## Features
- **Automatic theme switching** between light and dark themes.
- Customizable colors, icons, Plasma styles, and window decorations.
- Simple configuration through a `.config` file.
- Works only for **KDE5 Plasma** environments.

## Installation

### Prerequisites
- **KDE Plasma 5** installed.
- Ensure you have `qdbus`, `kwriteconfig5`, and `plasma-apply-colorscheme` tools available in your system (typically pre-installed with KDE).

### Steps
1. Clone this repository to your local machine:
    ```bash
    git clone https://github.com/yourusername/kde-theme-switcher.git
    cd kde-theme-switcher
    ```

2. Run the installation script:
    ```bash
    sudo ./install
    ```

   This will copy the scripts to `/usr/bin` and the configuration file to `~/.config`, allowing you to run them from anywhere in the terminal.

3. **Edit the configuration**:
   Open the configuration file `~/.config/theme_config.conf` and customize it as needed. The configuration controls the following for both light and dark themes:
   - **Color scheme**
   - **Wallpaper**
   - **Icons**
   - **Window decorations**
   - **Plasma style**

   Example configuration:
   ```ini
   # Light theme settings
   [light]
   colorscheme=RelaxLightColor
   wallpaper=~/Pictures/backgrounds/light_wallpaper.jpg
   icon_theme=Tela-circle
   window_decoration=__aurorae__svg__Relax-Blur-Light-Aurorae
   plasma_style=Relax-Light-Plasma

   # Dark theme settings
   [dark]
   colorscheme=RelaxDarkColor
   wallpaper=~/Pictures/backgrounds/dark_wallpaper.jpg
   icon_theme=Tela-circle
   window_decoration=__aurorae__svg__Relax-Blur-Aurorae
   plasma_style=Relax-Plasma

   [settings]
    light_start_hour=7
    dark_start_hour=16

4. **Set up automatic theme switching**:
   To switch themes automatically, you can use `cron`. Edit your `crontab` with the following commands:
   ```bash
   crontab -e
   ```

    Add these lines to switch to the light theme at 7 AM and to the dark theme at 7 PM:
   ```bash
    0 7 * * * /usr/bin/change_theme light
    0 19 * * * /usr/bin/change_theme dark
    ```

## Usage

To manually switch themes, run:

```bash
./change_theme.sh light    # To switch to the light theme
./change_theme.sh dark     # To switch to the dark theme
```

## Usage

To manually switch themes, run:

```bash
./change_theme.sh light    # To switch to the light theme
./change_theme.sh dark     # To switch to the dark theme
```

## Visual Studio Code Configuration

If you are using Visual Studio Code, you might want to set your preferred color themes to match your KDE themes. Add the following lines to your `settings.json` file:

```json
{
    "workbench.preferredLightColorTheme": "Solarized Light",
    "workbench.preferredDarkColorTheme": "Dracula Theme"
    // "workbench.colorTheme": "Dracula Theme"
}
```

## Uninstall

To uninstall the theme switcher, run the following command:

```bash
./uninstall.sh
