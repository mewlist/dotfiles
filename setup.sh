ROOTDIR=`pwd`

curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
git submodule init
git submodule update

#cd ./vim_plugins/snipmate-snippets
#rake deploy_local
cd $ROOTDIR

mkdir -p ~/.vim/autoload ~/.vim/bundle; \
  curl -so ~/.vim/autoload/pathogen.vim \
  https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim

cp ./.vimrc ~/

rm -f ~/.vim/bundle/snipmate.vim/snippets/*
