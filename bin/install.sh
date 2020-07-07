#!/usr/bin/env bash

echo '-- Give your admin password to start the installation'
# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo '-- Checking for homebrew'
if command -v brew &> /dev/null
then
  echo '   Ok'
else
  echo '   Installing homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo '-- Install Homebrew formulae'
homebrew_formulae=(
  'htop'
  'tig'
  'gpg'
  'asdf'
)
brew install $( printf "%s " "${homebrew_formulae[@]}" )

echo '-- Setup Homebrew taps'
homebrew_taps=(
  'homebrew/cask-drivers'
  'homebrew/cask-fonts'
)
for tap in "${homebrew_taps[@]}"; do
 brew tap $tap
done

echo '-- Install Homebrew casks'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
homebrew_casks=(
  'little-snitch'
  'alfred'
  'google-chrome'
  'dropbox'
  'atom'
  'appcleaner'
  'firefox'
  'microsoft-office'
  'skype'
  'slack'
  'spotify'
  'transmission'
  'vlc'
  '1password'
  'rubymine'
  'webstorm'
  'wacom-tablet'
  'caffeine'
  'gpg-suite'
  'postgres'
  'redis'
  'mactex'
  'docker'
)
# 'font-dejavu-sans-mono-for-powerline'
# 'font-dejavu-sans'
# 'font-dejavusansmono-nerd-font-mono'
# 'font-dejavusansmono-nerd-font'
brew cask install $( printf "%s " "${homebrew_casks[@]}" )

echo '-- Install Oh My ZSH'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#echo '-- Clone repo into Development folder'
#mkdir -p ~/Development/
#git clone --branch rewrite https://github.com/StefSchenkelaars/dotfiles.git ~/Development/

#echo '-- Symlink the dotfiles'
ln -fs ~/Development/dotfiles/shell/zshrc ~/.zshrc
