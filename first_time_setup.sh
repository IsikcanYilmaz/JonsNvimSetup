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
  echo "[+] Created ~/.config/nvim/init.vim"
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

# for tig
sudo apt install tig

# for airline
sudo apt install fonts-powerline

# Install coc extensions
#nvim -u coc_extension_install.vim

echo "[+] The plugin CoC uses nodejs. Please go here: https://nodejs.org/en/download/ and install it. node needs to be in your \$PATH"
echo "[+] You also need yarn. do \"npm install -g yarn\" . yarn needs to be in your \$PATH"
echo "[+] You need to install these coc extensions"
cat coc_extension_install.vim
