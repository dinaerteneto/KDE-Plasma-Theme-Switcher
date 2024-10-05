#!/bin/bash

# Definir o caminho do arquivo de configuração
CONFIG_FILE="$HOME/.config/theme_config"

# Função para carregar valores da seção correta do .config
load_config() {
    local section="$1"
    colorscheme=$(awk -F'=' "/\[$section\]/{a=1} a==1&&\$1~/colorscheme/{print \$2;exit}" "$CONFIG_FILE")
    wallpaper=$(awk -F'=' "/\[$section\]/{a=1} a==1&&\$1~/wallpaper/{print \$2;exit}" "$CONFIG_FILE")
    icon_theme=$(awk -F'=' "/\[$section\]/{a=1} a==1&&\$1~/icon_theme/{print \$2;exit}" "$CONFIG_FILE")
    window_decoration=$(awk -F'=' "/\[$section\]/{a=1} a==1&&\$1~/window_decoration/{print \$2;exit}" "$CONFIG_FILE")
    plasma_style=$(awk -F'=' "/\[$section\]/{a=1} a==1&&\$1~/plasma_style/{print \$2;exit}" "$CONFIG_FILE")
}

# Função para definir o tema com base na hora atual
set_theme_based_on_time() {
    hour=$(date +'%H')
    light_start_hour=$(awk -F'=' '/light_start_hour/{print $2}' "$CONFIG_FILE")
    dark_start_hour=$(awk -F'=' '/dark_start_hour/{print $2}' "$CONFIG_FILE")

    if [ "$hour" -ge "$light_start_hour" ] && [ "$hour" -lt "$dark_start_hour" ]; then
        echo "light"
    else
        echo "dark"
    fi
}

# Verificar o argumento de entrada (claro ou escuro)
if [[ "$1" == "light" ]]; then
    load_config "light"
elif [[ "$1" == "dark" ]]; then
    load_config "dark"
else
    # Se não houver argumento, definir o tema com base na hora atual
    theme=$(set_theme_based_on_time)
    load_config "$theme"
fi

# Aplicar esquema de cores, papel de parede, ícones, decoração de janelas e estilo Plasma
plasma-apply-colorscheme "$colorscheme"
plasma-apply-wallpaperimage "$wallpaper"
kwriteconfig5 --file ~/.config/kdeglobals --group Icons --key Theme "$icon_theme"
kwriteconfig5 --file ~/.config/kwinrc --group org.kde.kdecoration2 --key theme "$window_decoration"
kwriteconfig5 --file ~/.config/plasmarc --group Theme --key name "$plasma_style"

# Reconfigurar o KWin e o Plasma Shell
qdbus org.kde.KWin /KWin reconfigure
