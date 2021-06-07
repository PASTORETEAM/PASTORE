#!/usr/bin/env bash
cd $HOME/PASTORE
rm -rf $HOME/.telegram-cli
install() {
apt install dnsutils
rm -rf $HOME/.telegram-cli
sudo chmod +x tg
chmod +x PASTORE
chmod +x Run
./Run
}
if [ "$1" = "ins" ]; then
install
fi
chmod +x install.sh
lua start.lua
