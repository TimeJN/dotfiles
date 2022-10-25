#!/bin/bash
rm -rf $HOME/.aria2
rm -rf $HOME/.vim
rm -rf $HOME/.xprofile
rm -rf $HOME/.zshrc
rm -rf $HOME/.config/alacritty
rm -rf $HOME/.config/mpd
rm -rf $HOME/.config/ncmpcpp
rm -rf $HOME/.config/polybar
rm -rf $HOME/.config/osdlyrics
rm -rf $HOME/.config/ranger
rm -rf $HOME/.config/systemd
rm -rf $HOME/.config/picom
rm -rf $HOME/.config/fontconfig
ln -s $PWD/.aria2 $HOME/.aria2
ln -s $PWD/.vim $HOME/.vim
ln -s $PWD/.xprofile $HOME/.xprofile
ln -s $PWD/.zshrc $HOME/.zshrc
ln -s $PWD/.config/alacritty/ $HOME/.config/alacritty
ln -s $PWD/.config/mpd/ $HOME/.config/mpd
ln -s $PWD/.config/ncmpcpp/ $HOME/.config/ncmpcpp
ln -s $PWD/.config/polybar/ $HOME/.config/polybar
ln -s $PWD/.config/osdlyrics/ $HOME/.config/osdlyrics
ln -s $PWD/.config/ranger/ $HOME/.config/ranger
ln -s $PWD/.config/systemd/ $HOME/.config/systemd
ln -s $PWD/.config/picom/ $HOME/.config/picom
ln -s $PWD/.config/fontconfig/ $HOME/.config/fontconfig
