#!/bin/bash

gsettings set org.mate.interface gtk-theme 'TraditionalOk'
gsettings set org.mate.Marco.general theme 'TraditionalOk'
gsettings set org.mate.interface icon-theme 'gnome'
gsettings set org.mate.background picture-filename /usr/share/desktop-base/spacefun-theme/wallpaper/contents/images/3840x2160.svg

# Ruta de la imatge SVG
IMATGE="/usr/share/desktop-base/spacefun-theme/login/background.svg"

# Fitxer de configuració
CONFIG="/etc/lightdm/lightdm-gtk-greeter.conf"
BACKUP="${CONFIG}.bak"

# Comprovacions
if [ ! -f "$IMATGE" ]; then
    echo "❌ La imatge no existeix: $IMATGE"
    exit 1
fi

if [ ! -f "$CONFIG" ]; then
    echo "❌ No s'ha trobat el fitxer de configuració: $CONFIG"
    exit 1
fi

# Còpia de seguretat
sudo cp "$CONFIG" "$BACKUP"
echo "📁 Còpia de seguretat creada a: $BACKUP"

# Elimina qualsevol línia background= o #background=
sudo sed -i '/^#\?background=/d' "$CONFIG"

# Afegeix la nova línia al final
echo "background=$IMATGE" | sudo tee -a "$CONFIG" > /dev/null

echo "✅ Línia background actualitzada amb la imatge SVG."




# Per a revisar si funciona correctament.
IMATGEBLOC="/usr/share/desktop-base/spacefun-theme/wallpaper/contents/images/3840x2160.svg"

# Ruta de la imatge (canvia-ho pel teu camí)
IMATGEBLOC="$1"

# Comprova si la imatge existeix
if [ ! -f "$IMATGEBLOC" ]; then
  echo "⚠️ La imatge no existeix: $IMATGEBLOC"
  exit 1
fi

# Estableix la imatge com a fons d'escriptori (que MATE Screensaver utilitza)
gsettings set org.mate.background picture-filename "$IMATGEBLOC"

# Opcional: assegura que MATE Screensaver utilitza el fons d'escriptori
gsettings set org.mate.screensaver use-theme-background true

echo "✅ Imatge de bloqueig configurada amb: $IMATGEBLOC"




