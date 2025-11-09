#!/bin/bash

echo "🔧 Iniciant neteja de paquets d'idiomes no catalans ni castellans..."

# Eliminar diccionaris aspell
sudo apt purge -y \
aspell-am aspell-ar aspell-ar-large aspell-bg aspell-cs aspell-cy aspell-da aspell-de \
aspell-el aspell-en aspell-eo aspell-et aspell-eu aspell-fa aspell-fr aspell-ga \
aspell-gl-minimos aspell-he aspell-hr aspell-hu aspell-is aspell-it aspell-kk \
aspell-ku aspell-lt aspell-lv aspell-nl aspell-no aspell-pl aspell-pt-br aspell-pt-pt \
aspell-ro aspell-ru aspell-sk aspell-sl aspell-sv aspell-tl aspell-uk

# Eliminar diccionaris hunspell
sudo apt purge -y \
hunspell-fr hunspell-fr-classical hunspell-gl hunspell-gu hunspell-hi \
hunspell-hr hunspell-hu hunspell-id hunspell-is hunspell-it hunspell-kk \
hunspell-kmr hunspell-ko hunspell-lt hunspell-lv hunspell-ml hunspell-ne \
hunspell-nl hunspell-pl hunspell-pt-br hunspell-pt-pt hunspell-ro \
hunspell-ru hunspell-si hunspell-sl hunspell-sr hunspell-sv hunspell-te \
hunspell-th hunspell-vi

# Eliminar diccionaris ispell
sudo apt purge -y \
iamerican ibrazilian ibritish ibulgarian idutch ienglish-common \
ifrench-gut ihungarian iitalian ilithuanian ingerman inorwegian \
ipolish iportuguese irussian iswiss

# Eliminar diccionaris myspell i w*
sudo apt purge -y \
myspell-et myspell-fa myspell-ga myspell-he myspell-nb myspell-nn \
myspell-sk myspell-sq myspell-uk \
wamerican wbulgarian wfrench witalian wpolish wswedish wngerman wnorwegian wportuguese

# Eliminar metapaquets task-* excepte català i castellà
task_keep="task-catalan-desktop|task-spanish-desktop"
task_remove=$(dpkg -l | awk '/task-.*-desktop/ && $2 !~ /'"$task_keep"'/ {print $2}')
if [ -n "$task_remove" ]; then
  sudo apt purge -y $task_remove
fi

# Neteja final
sudo apt autoremove -y

echo "✅ Neteja completada. Només es mantenen català i castellà."

# Mostrar diccionaris i idiomes instal·lats
echo ""
echo "📚 Diccionaris i idiomes actualment instal·lats:"
dpkg -l | grep -E 'aspell|hunspell|myspell|ispell|w(spanish|catalan)|task-(catalan|spanish)-desktop' | awk '{print $2}'
