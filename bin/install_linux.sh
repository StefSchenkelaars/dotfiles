#!/usr/bin/env bash

echo '-- Give your admin password to start the installation'
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo '-- Clone repo'
if [ ! -d ~/dotfiles ]
then
  git clone https://github.com/StefSchenkelaars/dotfiles.git ~/dotfiles
fi

echo '-- Checking for NixOS'
if command -v nix &> /dev/null
then
  echo '   Ok'
else
  echo '   Installing NixOS'
  curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
  . ~/.nix-profile/etc/profile.d/nix.sh
fi

echo '-- Checking for NixOS home manager'
if command -v home-manager &> /dev/null
then
  echo '   Ok'
else
  echo '   Installing NixOS home manager'
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install
fi

echo '-- Symlinking the dotfiles repo to home-manager'
rm -Rf ~/.config/home-manager
ln -s ~/dotfiles/home-manager ~/.config/home-manager

echo '-- Running home manager'
home-manager switch

echo '-- Starting new bash terminal to reload profile'
exec bash
