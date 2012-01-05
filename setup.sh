ROOTDIR=`pwd`

git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cd ./vim_plugins/snipmate-snippets
rake deploy_local
cd $ROOTDIR

mkdir -p ~/.vim/autoload ~/.vim/bundle; \
  curl -so ~/.vim/autoload/pathogen.vim \
  https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim

cp -r ./.vim/after ~/.vim/
cp ./.vimrc ~/

vim -u .vimrc +BundleInstall +q +q
