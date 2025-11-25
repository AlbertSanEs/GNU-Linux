#!/bin/bash

#Declaració de variables
IMATGEGREETER="/usr/share/desktop-base/spacefun-theme/login/background.svg"
MOUSEGREETER="mate-black"
GREETERCONFIG="/etc/lightdm/lightdm-gtk-greeter.conf"
GREETERBACKUP="${GREETERCONFIG}.bak"
GRUBIMATGE="/usr/share/desktop-base/spacefun-theme/grub/grub-16x9.png"
GRUBCONFIG="/etc/default/grub"
GRUBBACKUP="${GRUBCONFIG}.bak"


#Instal·lació de paquets necessaris
echo "Instal·lant els paquets necessaris..."
sudo apt install grub2-common -y > /dev/null
echo "Tots els paquets necessaris s'han instal·lat"


# Revisió de les rutes de les configuracions
if [ ! -f "$GREETERCONFIG" ]; then
    echo "❌ No s'ha trobat el fitxer de configuració: $GREETERCONFIG"
    exit 1
fi
echo "[OK] Ruta de la configuració del Greeter "$GREETERCONFIG
sleep 1

if [ ! -f "$GRUBCONFIG" ]; then
    echo "❌ No s'ha trobat el fitxer de configuració: $GRUBCONFIG"
    exit 1
fi
echo "[OK] Ruta de la configuració del Grub2 "$GRUBCONFIG
sleep 1



# Revisió de les rutes de les imatges
if [ ! -f "$IMATGEGREETER" ]; then
    echo "❌ La imatge no existeix: $IMATGEGREETER"
    exit 1
fi
echo "[OK] Ruta de la imatge "$IMATGEGREETER
sleep 1

if [ ! -f "$GRUBIMATGE" ]; then
    echo "❌ La imatge no existeix: $GRUBIMATGE"
    exit 1
fi
echo "[OK] Ruta de la imatge del Grub2 "$GRUBIMATGE
sleep 1





# Creació de còpies de seguretat de les configuracions actuals
sudo cp "$GREETERCONFIG" "$GREETERBACKUP"
echo "[OK] Còpia de seguretat del Greeter creada a: $GREETERBACKUP"
sleep 1
sudo cp "$GRUBCONFIG" "$GRUBBACKUP"
echo "[OK] Còpia de seguretat del Grub2 creada a: $GRUBBACKUP"


echo "Eliminat configuració actual del fons de login, ratolí i Grub2..."
# Elimina qualsevol línia background= o #background= del Greeter de la configuració actual
sudo sed -i '/^#\?background=/d' "$GREETERCONFIG"
# Elimina qualsevol línia #cursor-theme-name= del Greeter de la configuració actual
sudo sed -i '/^#\?cursor-theme-name=/d' "$GREETERCONFIG"
# Elimina qualsevol línia grub_background= o #grub_background= del Grub de la configuració actual
sudo sed -i '/^#\?grub_background=/d' "$GRUBCONFIG"
sleep 1
echo "[OK] Configuració actual eliminada"
sleep 1



echo "Aplicant les imatges al Greeter i al Grub2..."
echo "background=$IMATGEGREETER" | sudo tee -a "$GREETERCONFIG" > /dev/null
echo "cursor-theme-name=$MOUSEGREETER" | sudo tee -a "$GREETERCONFIG" > /dev/null
echo "GRUB_BACKGROUND=$GRUBIMATGE" | sudo tee -a "$GRUBCONFIG" > /dev/null
sudo os-prober && sudo update-grub2 > /dev/null
sleep 1
echo "[OK] Imatges aplicades"
sleep 1

echo "Ajustant nou tema d'escriptori..."
sleep 1
echo "Aplicant 'Traditional Ok'..."
gsettings set org.mate.interface gtk-theme 'TraditionalOk'
sleep 1
gsettings set org.mate.Marco.general theme 'TraditionalOk'
echo "[OK] 'Traditional Ok aplicat"
sleep 1
echo "Aplicant tema d'icones Debian..."
gsettings set org.mate.interface icon-theme 'gnome'
sleep 1
echo "[OK] Icones Debian aplicades"
sleep 1
echo "Establint fons de pantalla i imatge de bloqueig de pantalla..."
gsettings set org.mate.background picture-filename /usr/share/desktop-base/spacefun-theme/wallpaper/contents/images/3840x2160.svg
gsettings set org.mate.screensaver picture-filename /usr/share/desktop-base/spacefun-theme/wallpaper/contents/images/3840x2160.svg
sleep 1
echo "[OK] Imatges establertes"
sleep 1
echo "[OK] Totes les modificacions aplicades"
