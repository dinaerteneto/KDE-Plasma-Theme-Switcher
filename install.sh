#!/bin/bash

# Mover o arquivo de configuração para ~/.config
echo "Movendo o arquivo de configuração para ~/.config..."
mkdir -p "$HOME/.config"
cp theme_config "$HOME/.config/theme_config"

# Copiar o script para /usr/bin
echo "Copiando o script para /usr/bin..."
cp theme_switcher.sh /usr/bin/theme_switcher
chmod +x /usr/bin/theme_switcher

# Criar um arquivo de serviço systemd
echo "Criando o arquivo de serviço systemd..."
cat << EOF | sudo tee /etc/systemd/system/theme_switcher.service > /dev/null
[Unit]
Description=Trocar tema do KDE Plasma

[Service]
Type=oneshot
ExecStart=/usr/bin/theme_switcher
EOF

# Criar um arquivo de timer systemd
echo "Criando o arquivo de timer systemd..."
cat << EOF | sudo tee /etc/systemd/system/theme_switcher.timer > /dev/null
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
sudo systemctl enable theme_switcher.timer
sudo systemctl start theme_switcher.timer

echo "Instalação concluída! O tema será trocado automaticamente a cada hora."
