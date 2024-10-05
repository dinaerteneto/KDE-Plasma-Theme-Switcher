#!/bin/bash

# Remover o timer e o serviço systemd
echo "Parando e desabilitando o timer..."
sudo systemctl stop theme_switcher.timer
sudo systemctl disable theme_switcher.timer

echo "Removendo o arquivo de serviço..."
sudo rm /etc/systemd/system/theme_switcher.service
sudo rm /etc/systemd/system/theme_switcher.timer

# Remover o script e o arquivo de configuração
echo "Removendo o script de /usr/bin..."
sudo rm /usr/bin/theme_switcher

echo "Removendo o arquivo de configuração..."
rm -f "$HOME/.config/theme_config"

echo "Desinstalação concluída!"
