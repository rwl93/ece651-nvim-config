#!/bin/bash
# Basic vim setup script
# 1. Install (Neo)vim
nvim_install=-1
while [[ ! $nvim_install =~ ^[01]$ ]]
do
  read -p "Do you want to install Neovim v0.6.1? (0/1)\n
  If you already have nvim installed you can bypass this step.\n
  However, the setup has been tested with v0.6.1 and the nightly build only\n
  [default=0]: " nvim_install
done

if [[ nvim_install -eq 0 ]]
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
    echo "Would you like to overwrite it? [n]"
    read overwrite
    if [ "$overwrite" == "y" -o "$overwrite" == "Y" ]
    then
      rm $HOME/.local/bin/nvim
    else
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
    echo "Could not find nvim executable"
    exit 1
  fi
  echo "Using ${nvimexec}"
  ${nvimexec} -v | grep "^NVIM v.*$"
fi

vimexec=`which vim`
if [[ $? -ne 0 ]]
then
  read -p "Would you like to add 'vim' command in addition to 'nvim'? y/[n]: " symlinkvim
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

# 3. Setup vim dotfiles
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
cp ece651-config.txt /home/rwl93/.local/share/nvim/site/doc/ece651-config.txt

# 4. Install vim-plug
echo "Installing vim-plug to manage plugins"
echo "See repository at https://github.com/junegunn/vim-plug"
echo "Also, find help in vim with ':h plug'"
git clone https://github.com/junegunn/vim-plug.git
sh -c 'curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# 5. Install plugins
nvim -E -u vimrc +PlugInstall - <<<'helptags ALL'

# 5. Point to walkthrough
cat << EOF
Congratulations! Neovim was successfully installed.
To get started, open Neovim with nvim (or vim if chosen earlier) and type:
    :PlugInstall
Make sure to hit enter to run the command.

We are using vim-plug to manage plugins. This command installs all of the
plugins specified in the vimrc ($HOME/.config/nvim/init.vim).

When vim-plug has completed quit out of vim by typing ":q" (which is much more
intuitive than <C-x><C-c>). Now restart vim and you will notice that the
Telescope plugin is installing some stuff. This will only happen the first time
after installing the plugin so don't worry about slow startup times.

Now take a look through the documentation for the vim config which will explain
the customizations and workflow we just installed. To do this run:
    :helptags ALL
    :h ece651-config
EOF
