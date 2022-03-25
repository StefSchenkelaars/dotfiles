#!/usr/bin/env bash

echo '-- Give your admin password to start the installation'
# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `old_osx_script` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo -- Give the path to the latest backup......
read BACKUP_PATH

if [ -z "$BACKUP_PATH" ]; then
  echo 'No path given so not restoring backups'
else
  echo -- Restore old ssh settings
  sudo cp -R "$BACKUP_PATH"/Users/`whoami`/.ssh ~/
  echo '   Done'

  echo -- Restore old keychains
  sudo cp -R "$BACKUP_PATH"/Users/`whoami`/Library/Keychains ~/Library
  echo '   Done'

  echo -- Restore old gpg keys
  sudo cp -R "$BACKUP_PATH"/Users/`whoami`/.gnupg* ~/
  echo '   Done'

  echo -- Restore gitconfig
  sudo cp -R "$BACKUP_PATH"/Users/`whoami`/.gitconfig ~/
  echo '   Done'

  echo -- Restore aws settings
  sudo cp -R "$BACKUP_PATH"/Users/`whoami`/.aws ~/
  echo '   Done'
fi