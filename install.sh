#!/bin/bash
# check git command
type git || {
    echo 'Please install git or update your path to include the git executable!'
    exit 1
}
type curl || {
    echo 'Please install curl or update your path to include the curl executable!'
    exit 1
}
echo ""
NVIM_DIR="$HOME/.local/share/nvim/site"
VUNDLE_DIR="$NVIM_DIR/bundle/Vundle.vim"
NEOBUNDLE_DIR="$NVIM_DIR/bundle/neobundle.vim"
DEIN_DIR="$NVIM_DIR/bundle/dein.vim"
PACKER_DIR="$NVIM_DIR/pack/packer/start/packer.nvim"

mkdir -p $NVIM_DIR/bundle

# Vim-plug install
echo "# Vim-plug"
curl -fLo $NVIM_DIR/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Vundle install
echo "# Vundle"
if [ ! -d $VUNDLE_DIR ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
else
    (cd $VUNDLE_DIR && git pull)
fi

# NeoBundle install
echo "# NeoBundle"
if [ ! -d $NEOBUNDLE_DIR ]; then
    git clone https://github.com/Shougo/neobundle.vim $NEOBUNDLE_DIR
else
    (cd $NEOBUNDLE_DIR && git pull)
fi

# Dein install
echo "# Dein"
if [ ! -d $DEIN_DIR ]; then
    bash <(curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh) $DEIN_DIR
else
    (cd $DEIN_DIR && git pull)
fi

# Install plugins
nvim -Nu src/plug.vim +PlugInstall +qa

# Dein installs plugins in different directory structure
# Manually install plugins with :call dein#install() and quit
ln -sf src/dein.vim plugins.vim
nvim -Nu vimrc +'echo ":call dein#install()"'

ln -sf src/dein-all.vim plugins.vim
nvim -Nu vimrc +'echo ":call dein#install()"'
