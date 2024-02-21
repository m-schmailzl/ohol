#!/bin/bash
set -e

if [ -z "$GAME_VERSION" ]
then
  echo "No GAME_VERSION has been set!"
  exit 1
fi


clone_and_get_version () {
  git clone --single-branch "https://github.com/jasonrohrer/$1.git"
  cd "$1"

  # find newest available version older than GAME_VERSION
  version=""
  number=$((GAME_VERSION))
  while (( number > GAME_VERSION-25 )) && [ -z "$version" ]
  do
    if [ $(git tag -l "OneLife_v$number") ]
    then
      version="v$number"
    fi
    ((number--))
  done

  git checkout -q "OneLife_$version"
  cd ..
  echo "$version"
}


MAIN_VERSION=$(clone_and_get_version OneLife)
MINOR_GEMS_VERSION=$(clone_and_get_version minorGems)
DATA_VERSION=$(clone_and_get_version OneLifeData7)

if [ -z "$MAIN_VERSION" ] || [ -z "$MINOR_GEMS_VERSION" ] || [ -z "$DATA_VERSION" ]
then
  echo "Could not fetch the given game version!"
  exit 2
fi

echo "--- Fetched sources for:"
echo "Main:$MAIN_VERSION Data:$DATA_VERSION MinorGems:$MINOR_GEMS_VERSION"
