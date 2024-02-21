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

./OneLifeServer