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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo '-- Setup Homebrew taps'
homebrew_taps=(
  'homebrew/cask-drivers'
  'homebrew/cask-fonts'
  'heroku/brew'
  'thoughtbot/formulae'
)
for tap in "${homebrew_taps[@]}"; do
 brew tap $tap
done

echo '-- Install Homebrew formulae'
homebrew_formulae=(
  '1password'
  'act'
  'adobe-acrobat-reader'
  'alfred'
  'appcleaner'
  'asdf'
  'awscli'
  'caffeine'
  'clipgrab'
  'cmake'
  'curl'
  'docker'
  'dropbox'
  'firefox'
  'ffmpeg'
  'gcc'
  'google-chrome'
  'heroku'
  'htop'
  'little-snitch'
  'microsoft-office'
  'microsoft-teams'
  'mysql'
  'ngrok'
  'parity'
  'postgres-unofficial'
  'postman'
  'redis'
  'reviewdog/tap/reviewdog'
  'rubymine'
  'skype'
  'slack'
  'spotify'
  'tig'
  'transmission'
  'vlc'
  'watchman'
  'wget'
  'wireshark'
  'zoom'
)

brew install $( printf "%s " "${homebrew_formulae[@]}" )

echo '-- Clone repo into Development folder'
if [ ! -d ~/Documents/Development/dotfiles ]
then
  mkdir -p ~/Documents/Development/
  git clone https://github.com/StefSchenkelaars/dotfiles.git ~/Documents/Development/dotfiles
fi

echo '-- Install Oh My ZSH'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo '-- Symlink the dotfiles'
ln -fs ~/Documents/Development/dotfiles/shell/zshrc ~/.zshrc
ln -fs ~/Documents/Development/dotfiles/git/gitignore ~/.gitignore

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

echo '-- Setup yarn with asdf'
asdf plugin add yarn
asdf install yarn latest
asdf global yarn latest

echo '-- Setting OSX settings'
chflags nohidden ~/Library/
