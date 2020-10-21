#!/usr/bin/env bash

echo '-- Give your admin password to start the installation'
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo '-- Checking for homebrew'
if command -v brew &> /dev/null
then
  echo '   Ok'
else
  echo '   Installing homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo '-- Setup Homebrew taps'
homebrew_taps=(
  'homebrew/cask-drivers'
  'homebrew/cask-fonts'
  'homebrew/cask-versions'
  'heroku/brew'
  'thoughtbot/formulae'
)
for tap in "${homebrew_taps[@]}"; do
 brew tap $tap
done

echo '-- Install Homebrew formulae'
homebrew_formulae=(
  'htop'
  'tig'
  'gpg'
  'asdf'
  'reviewdog/tap/reviewdog'
  'imagemagick'
  'yarn'
  'heroku'
  'parity'
  'wxmac'
  'autoconf'
  'fop'
  'letsencrypt'
  'watchman'
)
brew install $( printf "%s " "${homebrew_formulae[@]}" )

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
  'postman'
  'microsoft-teams'
  'time-out'
  'zeplin'
  'zoomus'
  'scroll-reverser'
  'java'
  'garmin-express'
  'google-chrome-canary'
  'ngrok'
)
brew cask install $( printf "%s " "${homebrew_casks[@]}" )

echo '-- Clone repo into Development folder'
if [ ! -d ~/Development/dotfiles ]
then
  mkdir -p ~/Development/
  git clone https://github.com/StefSchenkelaars/dotfiles.git ~/Development/dotfiles
fi

echo '-- Install Oh My ZSH'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo '-- Symlink the dotfiles'
ln -fs ~/Development/dotfiles/shell/zshrc ~/.zshrc
ln -fs ~/Development/dotfiles/git/gitignore ~/.gitignore

echo '-- Setup ruby with asdf'
asdf plugin add ruby
asdf install ruby latest

echo '-- Setup nodejs with asdf'
asdf plugin add nodejs
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf install nodejs latest

echo '-- Setup elixir with asdf'
asdf plugin add erlang
asdf install erlang latest
asdf plugin add elixir
asdf install elixir latest

echo '-- Setting OSX settings'
chflags nohidden ~/Library/
