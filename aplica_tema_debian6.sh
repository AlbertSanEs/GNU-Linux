#!/bin/bash

# Es posible que no estigui instal·lat Grub
sudo apt install grub2-common > /dev/null

# Establim el tema per mitjà de les comandes que emprana Mate.
gsettings set org.mate.interface gtk-theme 'TraditionalOk'
gsettings set org.mate.Marco.general theme 'TraditionalOk'
gsettings set org.mate.interface icon-theme 'gnome'
gsettings set org.mate.background picture-filename /usr/share/desktop-base/spacefun-theme/wallpaper/contents/images/3840x2160.svg
gsettings set org.mate.screensaver picture-filename /usr/share/desktop-base/spacefun-theme/wallpaper/contents/images/3840x2160.svg




# Establim la ruta de la imatge del login
IMATGEGREETER="/usr/share/desktop-base/spacefun-theme/login/background.svg"

# Establim la ruta de la imatge pel Grub
GRUBIMATGE="/usr/share/desktop-base/spacefun-theme/grub/grub-16x9.png"


# Establim el fitxer de configuració del Greeter
GREETERCONFIG="/etc/lightdm/lightdm-gtk-greeter.conf"
GREETERBACKUP="${GREETERCONFIG}.bak"

# Establim el fitxer de configuració del Grub
GRUBCONFIG="/etc/default/grub"
GRUBBACKUP="${GRUBCONFIG}.bak"






# Comprovem la ruta de configuració del Greeter.
if [ ! -f "$IMATGEGREETER" ]; then
    echo "❌ La imatge no existeix: $IMATGEGREETER"
    exit 1
fi

if [ ! -f "$GREETERCONFIG" ]; then
    echo "❌ No s'ha trobat el fitxer de configuració: $GREETERCONFIG"
    exit 1
fi


# Comprovem la ruta de configuració del Grub.
if [ ! -f "$GRUBIMATGE" ]; then
    echo "❌ La imatge no existeix: $GRUBIMATGE"
    exit 1
fi

if [ ! -f "$GRUBCONFIG" ]; then
    echo "❌ No s'ha trobat el fitxer de configuració: $GRUBCONFIG"
    exit 1
fi


# Creem una còpia de seguretat del Greeter
sudo cp "$GREETERCONFIG" "$GREETERBACKUP"
echo "📁 Còpia de seguretat creada a: $GREETERBACKUP"


# Creem una còpia de seguretat del Grub
sudo cp "$GRUBCONFIG" "$GRUBBACKUP"
echo "📁 Còpia de seguretat creada a: $GRUBBACKUP"



# Elimina qualsevol línia background= o #background= del Greeter
sudo sed -i '/^#\?background=/d' "$GREETERCONFIG"

# Elimina qualsevol línia grub_background= o #grub_background= del Grub
sudo sed -i '/^#\?grub_background=/d' "$GRUBCONFIG"





# Afegeix la nova línia al final del Greeter
echo "background=$IMATGEGREETER" | sudo tee -a "$GREETERCONFIG" > /dev/null
echo "✅ Imatge del login actualizada."


# Afegeix la nova línia al final del Grub
echo "GRUB_BACKGROUND=$GRUBIMATGE" | sudo tee -a "$GRUBCONFIG" > /dev/null
sudo os-prober && sudo update-grub2 > /dev/null
echo "✅ Imatge del Grub actualitzada."
