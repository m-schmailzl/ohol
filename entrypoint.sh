#!/bin/bash

cd /opt/OneLife/server

# create default config
cd default-settings
for file in *
do
  if [ ! -e "../settings/$file" ]
  then
    echo "Creating default config file '$file'..."
    cp "$file" "../settings/$file"
  fi
done
cd ..

if [ "$DISABLE_DECAY" == 1 ]
then
  echo "Removing decay transitions..."
  while read line; do
    rm -f "transitions/$line"
  done <decayTransitions.txt
  rm -f transitions/cache.fcz
fi

./OneLifeServer