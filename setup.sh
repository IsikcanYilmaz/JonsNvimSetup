#!/usr/bin/env bash

# Parse args / config
NVIMDIR="$HOME/.config/nvim/"
FORCE=0
PARAMS=""

TMPDIR="/tmp/"

NVIM_DESIRED_VERSION="v0.9.4"
NVIM_DESIRED_RELEASE_URL="https://github.com/neovim/neovim/releases/download/"$NVIM_DESIRED_VERSION"/"
NVIM_NIGHTLY_RELEASE_URL="https://github.com/neovim/neovim/releases/download/nightly/"
NVIM_NIGHTLY_LINUX_NAME="nvim-linux64.tar.gz"
NVIM_NIGHTLY_MACOS_NAME="nvim-macos.tar.gz"

# Check if nvim is installed. If not, download the latest binary
function install_nvim_if_not_installed()
{
  which nvim &> /dev/null
  NVIM_NOT_INSTALLED=$?

  if [[ $NVIM_NOT_INSTALLED -eq 1 || $FORCE -eq 1 ]]; then
    echo "[?] Nvim not installed! Should this script install it? (y/n)"
    installSelection=""
    while [[ "$installSelection" != "y" && "$installSelection" != "n" ]]; do
      read installSelection
      echo $installSelection
    done
    
    if [ "$installSelection" == "n" ]; then
      echo "[!] Won't install"
      return 0
    fi
    
    filename=""
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      echo "[*] Linux"
      filename="$NVIM_NIGHTLY_LINUX_NAME"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      echo "[*] MacOS"
      filename="$NVIM_NIGHTLY_MACOS_NAME"
    else
      echo "[!] Unknown platform! $OSTYPE"
      return 1
    fi
    
    initPwd=$PWD
    cd $TMPDIR
    wget "$NVIM_DESIRED_RELEASE_URL/$filename"
    mkdir nvimDl
    mv $filename nvimDl
    cd nvimDl
    tar xvf $filename
    nvimExtractDir=$(echo $filename | awk -F. '{print $1}')
    cd $nvimExtractDir
    
    echo "[*] Installing nvim binary to /usr/bin/"
    sudo cp bin/nvim /usr/bin/nvim
    # TODO copy the rest of the files? # 

    cd $initPwd
  else
    echo "[*] Nvim found at " $(which nvim)
  fi
}

function install_nvim_config()
{
	echo "[+] Copying init.lua to $NVIMDIR/"
	cp dotfiles/init.lua $NVIMDIR/init.lua
}

function install_tmux_config()
{
	echo "[+] Copying .tmux.conf to $HOME/"
	cp dotfiles/.tmux.conf $HOME
}

# Parse args
while (( "$#" )); do
  case "$1" in
    --force)
      FORCE=1
      shift
      ;;
		--nvim-only)
			install_nvim_config
			exit 1
			shift
			;;
		--tmux-only)
			install_tmux_config
			exit 1
			shift
			;;
    --reinstall)
			install_nvim_config
			install_tmux_config
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

install_nvim_if_not_installed

echo "[+] Installing neovim setup"

# Make the nvim directory if its not there
if [ ! -f "$HOME/.config/nvim/init.lua" ] || [ $FORCE == 1 ] ; then
  mkdir -p $NVIMDIR
  mkdir -p $NVIMDIR/autoload
  cp dotfiles/init.lua $NVIMDIR/init.lua
	cp dotfiles/.tmux.conf $HOME
  echo "[+] Created $NVIMDIR/init.lua."
	echo "[+] Created $HOME/.tmux.conf"
fi

# Copy over the colors
if [ ! -d "$NVIMDIR/colors" ] || [ $FORCE == 1 ]; then
  cp -r colors $NVIMDIR/colors
  echo "[+] Copied colors to $NVIMDIR/colors."
fi

# NO LONGER USE PLUG. WE NOW USE PACKER
# Uses vim-plug to manage plugins. If not installed, install
# Installation: Download plug.vim and put it in the "autoload" directory.
# PLUGVIM_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
# if [ ! -f "$NVIMDIR/autoload/plug.vim" ] || [ $FORCE == 1 ]; then
#   wget $PLUGVIM_URL -O $NVIMDIR/autoload/plug.vim
#   mkdir $NVIMDIR/plugged
#   echo "[+] Downloaded plug.vim"
# fi

# for pynvim
pip3 install pynvim
pip3 install --upgrade pynvim

# get the latest npm
echo "[!] You may want to get the latest npm/node:"
echo "curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -"
echo "sudo apt-get install -y nodejs"

if [ $OSTYPE == "darwin"* ]; then
  brew install tig
  brew install fonts-powerline
  brew install nodejs
  brew install npm
  brew install bear
elif [ $OSTYPE == "linux-gnu"* ]; then
  # check if we have apt or pacman
  which apt &> /dev/null
  ISAPT=$?
  which pacman &> /dev/null
  ISPACMAN=$?
  if [ $ISAPT -eq 0 ]; then
    sudo apt install tig
    sudo apt install fonts-powerline
    sudo apt install nodejs
    sudo apt install bear
  elif [ $ISPACMAN -eq 0 ]; then
    sudo pacman -S tig
    sudo pacman -S powerline-fonts
    sudo pacman -S nodejs
    sudo pacman -S npm
    sudo pacman -S bear
    # sudo npm install -g yarn
  else
    echo "[!] Neither apt nor pacman found in system. Couldnt install tig and powerline."
  fi
fi

echo "[*] Refer to cscope_init.sh for helper bash functions."

# Install coc extensions
#nvim -u coc_extension_install.vim

# if [ $ISAPT -eq 1 ]; then
#   echo "[+] The plugin CoC uses nodejs. Please go here: https://nodejs.org/en/download/ and install it. node needs to be in your \$PATH"
#   echo "[+] You also need yarn. do \"npm install -g yarn\" . yarn needs to be in your \$PATH"
#   echo "[+] You need to install these coc extensions"
# fi
# cat coc_extension_install.vim
