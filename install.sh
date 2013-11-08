#! /bin/sh

#Author:songchenglin
#Email:songchenglin92@gmail.com

#Back up old configure and plugins
echo "backup old configure to /tmp ..."
mv ~/.vim /tmp/vim_backup
mv ~/.vimrc /tmp/vimrc_backup
echo "backup finished."
#Install new configure and plugins
echo "Install new configure"
cp .vim ~/ -rf
cp .vimrc ~/

echo "Install finished!"
