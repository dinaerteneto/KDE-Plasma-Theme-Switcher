#!/bin/bash

# Caminho do arquivo de configuração
CONFIG_FILE="$HOME/.config/theme_config"

# Verificar se o arquivo de configuração já existe
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Movendo o arquivo de configuração para ~/.config..."
    mkdir -p "$HOME/.config"
    cp theme_config "$CONFIG_FILE"
else
    echo "O arquivo de configuração já existe em ~/.config. Nenhuma ação necessária."
fi


# Copiar o script para /usr/bin
echo "Copiando o script para /usr/bin..."
sudo cp theme-switcher.sh /usr/bin/theme-switcher
sudo chmod +x /usr/bin/theme-switcher

# Criar um arquivo de serviço systemd
echo "Criando o arquivo de serviço systemd..."
cat << EOF | sudo tee /etc/systemd/system/theme-switcher.service > /dev/null
[Unit]
Description=Trocar tema do KDE Plasma

[Service]
Type=oneshot
ExecStart=/usr/bin/theme-switcher
EOF

# Criar um arquivo de timer systemd
echo "Criando o arquivo de timer systemd..."
cat << EOF | sudo tee /etc/systemd/system/theme-switcher.timer > /dev/null
[Unit]
Description=Timer para trocar tema do KDE Plasma a cada hora

[Timer]
OnCalendar=hourly
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Habilitar e iniciar o timer
echo "Habilitando e iniciando o timer..."
sudo systemctl enable theme-switcher.timer
sudo systemctl start theme-switcher.timer

echo "Instalação concluída! O tema será trocado automaticamente a cada hora."
