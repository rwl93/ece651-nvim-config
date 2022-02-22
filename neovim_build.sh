#!/bin/bash
# Basic vim setup script
# 1. Install (Neo)vim
nvim_install=-1
while [[ ! $nvim_install =~ ^[yYnN]$ ]]
do
  read -p "Do you want to install Neovim v0.6.1?
  If you already have nvim installed you can bypass this step.
  However, the setup has been tested with v0.6.1 and the nightly build only
  [default=y]/n: " nvim_install
  nvim_install=${nvim_install:-y}
done

if [ "$nvim_install" == "y" -o "$nvim_install" == "Y" ]
then
  echo "Downloading Neovim v0.6.1"
  wget -Nq https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
  wget -Nq https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage.sha256sum
  sha256sum --status -c nvim.appimage.sha256sum <(sha256sum nvim.appimage)
  if [[ $? != 0 ]]
  then
    echo "Signature Check Failed."
    exit 1
  fi
  mkdir -p $HOME/.local/bin
  chmod u+x nvim.appimage
  if [[ -f $HOME/.local/bin/nvim ]]
  then
    echo "$HOME/.local/bin/nvim already exists."
    read -p "Would you like to overwrite it? y/[n]" overwrite
    overwrite=${overwrite:-n}
    if [ "$overwrite" == "y" -o "$overwrite" == "Y" ]
    then
      rm $HOME/.local/bin/nvim
    else
      echo "Exiting: If you do not want to overwrite your current installation do not choose the install option."
      exit 1
    fi
  fi
  ln -s `pwd`/nvim.appimage $HOME/.local/bin/nvim
  export PATH=$PATH:$HOME/.local/bin
  echo "PATH=$PATH:$HOME/.local/bin" >> $HOME/.bashrc
else
  echo "Searching for nvim"
  nvimexec=`which nvim`
  if [[ $? -ne 0 ]]
  then
    echo "Exiting: Could not find nvim executable"
    exit 1
  fi
  echo "Using ${nvimexec}"
  ${nvimexec} -v | grep "^NVIM v.*$"
fi

vimexec=`which vim`
if [[ $? -ne 0 ]]
then
  read -p "Would you like to add 'vim' command in addition to 'nvim'? y/[n]: " symlinkvim
  symlinkvim=${symlinkvim:-n}
  if [ "$symlinkvim" == "y" -o "$symlinkvim" == "Y" ]
  then
    ln -s `pwd`/nvim.appimage $HOME/.local/bin/vim
  fi
else
  echo "You have another version of Vim installed: $vimexec"
  echo "Use the 'nvim' command to use the Neovim that was just installed"
fi

# 2. Set defaults
export EDITOR='nvim'
export VISUAL='nvim'
echo "export EDITOR='nvim'" >> $HOME/.bashrc
echo "export VISUAL='nvim'" >> $HOME/.bashrc

# 3. Install Fonts
read -p "Would you like to install a patched font (DejaVu Sans Mono) which adds nice icons? [y]/n: " installfonts
installfonts=${installfonts:-y}
if [ "$installfonts" == "y" -o "$installfonts" == "Y" ]
then
  wget -Nq https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DejaVuSansMono.zip
  mkdir -p $HOME/.local/share/fonts/truetype/DejaVuSansMono
  unzip DejaVuSansMono.zip -d $HOME/.local/share/fonts/truetype/DejaVuSansMono/
  fc-cache -f
  echo "xterm*faceName: DejaVu Sans Mono" >> ~/.Xresources
  xrdb -merge ~/.Xresources
  echo "If you are not using xterm, you will have to set your font to DejaVu Sans Mono (or any patched font) to see symbols"
fi

# 4. Setup vim dotfiles
mkdir -p $HOME/.config/nvim
if [[ -f $HOME/.config/nvim/init.vim ]]
then
  echo "Found $HOME/.config/nvim/init.vim"
  echo "Backing up your init.vim to ${HOME}/.config/nvim/init.vim.backup"
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.backup
fi
ln -s `pwd`/vimrc $HOME/.config/nvim/init.vim
if [[ -d $HOME/.local/share/nvim ]]
then
  echo "Found $HOME/.local/share/nvim"
  echo "Backing up your nvim dir to ${HOME}/.local/share/nvim-backup"
  mv $HOME/.local/share/nvim $HOME/.local/share/nvim-backup
fi
mkdir -p $HOME/.local/share/nvim/site/doc
ln -s `pwd`/ece651-config.txt $HOME/.local/share/nvim/site/doc/ece651-config.txt

# 5. Install vim-plug
echo "Installing vim-plug to manage plugins"
echo "See repository at https://github.com/junegunn/vim-plug"
echo "Also, find help in vim with ':h plug'"
git clone https://github.com/junegunn/vim-plug.git
mkdir -p ${HOME}/.local/share/nvim/site/autoload/
wget -O ${HOME}/.local/share/nvim/site/autoload/plug.vim \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 6. Install dependencies
cat << EOF

-------------------------------------------------------------------------------
Dependencies Section:
EOF
read -p "Would you like to install dependencies for neovim? [y]/n: " installdeps
installdeps=${installdeps:-n}
if [ "$installdeps" == "y" -o "$installdeps" == "Y" ]
then
cat << EOF
-------------------------------------------------------------------------------
Installing dependencies: Nodejs and npm
EOF
read -p "Would you like to update and upgrade apt before downloading dependencies?y/[n]: " preupgrade
preupgrade=${preupgrade:-n}
if [ "$preupgrade" == "y" -o "$preupgrade" == "Y" ]
then
  sudo apt update && sudo apt upgrade
fi

# required for install LSP servers
sudo apt install -y nodejs npm
# Java
cat << EOF
-------------------------------------------------------------------------------
Installing dependencies: Java and clang-format
EOF
sudo apt install -y openjdk-16-jdk clang-format
# Telescope reqs
cat << EOF
-------------------------------------------------------------------------------
Installing dependencies: Ripgrep fd-find fzf
EOF
sudo apt install -y ripgrep fd-find
# Python3 reqs
cat << EOF
-------------------------------------------------------------------------------
Installing dependencies: python3
EOF
sudo apt install python3 python3-pip
sudo pip3 install neovim
else
    echo "Skipping dependency install"
fi

# 7. Install plugins
nvim -E -u vimrc-install +PlugInstall - <<<'helptags ALL'

# 8. Setup Telescope fzf
neovimbuilddir=`pwd`
cd $HOME/.local/share/nvim/plugged/telescope-fzf-native.nvim/
make
cd $neovimbuilddir

# 8. Point to walkthrough
cat << EOF

-------------------------------------------------------------------------------
Congratulations! Neovim was successfully installed.
To get started, open Neovim with nvim (or vim if chosen earlier) and type:
    :PlugInstall
Make sure to hit enter to run the command.

Note: Don't worry about the startup errors right now they will go away once
we've installed the plugins and LSP servers.

We are using vim-plug to manage plugins. This command installs all of the
plugins specified in the vimrc ($HOME/.config/nvim/init.vim).

When vim-plug has completed quit out of vim by typing ":q" (which is much more
intuitive than <C-x><C-c>). Now restart vim and you will notice that the
Telescope plugin is installing some stuff. This will only happen the first time
after installing the plugin so don't worry about slow startup times.

Now install the LSP servers that you would like to use. We'll be using
nvim-lsp-installer to help install the servers:
    :LspInstallInfo
This will bring up a popup menu with all of the available LSP servers. You can
navigate to any LSP server and press "i" to install the server. The suggested
servers are:
- jdtls (requires that you have Java installed)
- clangd (c/cpp)
- dockerls (docker)
- zeta_note (markdown)
- vimls (for editing vimrc)
- sumneko_lua (Neovim uses Lua so you might eventually edit some Lua)

Note if you are adding other LSP servers make sure to add them to the list in
your init.vim ($HOME/.config/nvim/init.vim) under the Plugins>LSP Servers
section. You can type "/local servers<Enter>" to search for the exact line.

Now take a look through the documentation for the vim config which will explain
the customizations and workflow we just installed. To do this run:
    :helptags ALL
    :h ece651-config

Note: If you are still seeing a startup error about Telescope and fzf follow
these steps:
    1. Open vim go to vimrc/init.vim by typing "ev" in normal mode
    2. Search for the telescope-fzf-native plugin by typing (in normal mode):
        "/telescope-fzf-native<Enter>"
    3. Comment out that line with "gcc" in normal mode
    4. Save (":w") and source with "sv"
    5. Run: ":PlugClean"
    6. Uncomment the telescope-fzf-native line
    7. Repeat step 4
    8. Run: ":PlugInstall"
    9. Restart vim and you shouldn't see the error
I'm not exactly sure why this error is happening, but the above steps should
solve the issue. See ":h ECE651ConfigFAQ" for this list of steps if you forget
them.
EOF
