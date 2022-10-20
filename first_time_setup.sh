#!/usr/bin/env bash

# Parse args / config
NVIMDIR="$HOME/.config/nvim/"
FORCE=0
PARAMS=""

while (( "$#" )); do
  case "$1" in
    --force)
      FORCE=1
      shift
      ;;
    --reinstall)
      echo "[+] Copying init.vim to $NVIMDIR/"
      cp init.vim $NVIMDIR/init.vim
      exit 1
      shift
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

echo "[+] Installing neovim setup"

# Make the nvim directory if its not there
if [ ! -f "$HOME/.config/nvim/init.vim" ] || [ $FORCE == 1 ] ; then
  mkdir -p $NVIMDIR
  mkdir -p $NVIMDIR/autoload
  cp init.vim $NVIMDIR/init.vim
  cp cscope_maps.vim $NVIMDIR/cscope_maps.vim
  cp coc_config.vim $NVIMDIR/coc_config.vim
  echo "[+] Created $NVIMDIR/init.vim"
fi

# Copy over the colors
if [ ! -d "$NVIMDIR/colors" ] || [ $FORCE == 1 ]; then
  cp -r colors $NVIMDIR/colors
  echo "[+] Copied colors to $NVIMDIR/colors"
fi

# Uses vim-plug to manage plugins. If not installed, install
# Installation: Download plug.vim and put it in the "autoload" directory.
PLUGVIM_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if [ ! -f "$NVIMDIR/autoload/plug.vim" ] || [ $FORCE == 1 ]; then
  wget $PLUGVIM_URL -O $NVIMDIR/autoload/plug.vim
  mkdir $NVIMDIR/plugged
  echo "[+] Downloaded plug.vim"
fi

# for pynvim
pip3 install pynvim
pip3 install --upgrade pynvim

# check if we have apt or pacman
which apt &> /dev/null
ISAPT=$?
which pacman &> /dev/null
ISPACMAN=$?

if [ $ISAPT -eq 0 ]; then
  # for tig
  sudo apt install tig
  # for airline
  sudo apt install fonts-powerline
elif [ $ISPACMAN -eq 0 ]; then
  # for tig
  sudo pacman -S tig
  # for airline
  sudo pacman -S powerline-fonts
  # for nodejs
  sudo pacman -S nodejs
  # for npm
  sudo pacman -S npm

  sudo npm install -g yarn
else
  echo "[!] Neither apt nor pacman found in system. Couldnt install tig and powerline"
fi

# Install coc extensions
#nvim -u coc_extension_install.vim

if [ $ISAPT -eq 1 ]; then
  echo "[+] The plugin CoC uses nodejs. Please go here: https://nodejs.org/en/download/ and install it. node needs to be in your \$PATH"
  echo "[+] You also need yarn. do \"npm install -g yarn\" . yarn needs to be in your \$PATH"
  echo "[+] You need to install these coc extensions"
fi
cat coc_extension_install.vim
