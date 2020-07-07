echo 'Removing node_modules'
find ~/Development -name "node_modules" -type d -prune -exec rm -rf '{}' +

echo 'Removing logs'
find ~/Development -type f -name "*.log" -delete

echo 'Cleaning homebrew'
brew cleanup
rm -rf $(brew --cache)

echo 'Cleaning yarn cache'
yarn cache clean

echo 'Starting docker'
if (! docker stats --no-stream ); then
  open /Applications/Docker.app
while (! docker stats --no-stream ); do
  echo '  still starting...'
  sleep 5
done
fi

echo 'Cleaning docker'
docker system prune --all --volumes -f
