#!/bin/bash
set -e

cd /opt/OneLife/server

./configure 1
make

ln -s ../../OneLifeData7/objects .
ln -s ../../OneLifeData7/transitions .
ln -s ../../OneLifeData7/categories .
ln -s ../../OneLifeData7/tutorialMaps .
ln -s ../../OneLifeData7/dataVersionNumber.txt .
ln -s ../../OneLifeData7/contentSettings .

git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=2 refs/tags | grep "OneLife_v" | sed -e 's/OneLife_v//' > serverCodeVersionNumber.txt

# symlink all permanent files to put them in a single volume
mkdir data
ln -s data/biome.db .
ln -s data/curseCount.db .
ln -s data/curses.db .
ln -s data/eve.db .
ln -s data/floor.db .
ln -s data/floorTime.db .
ln -s data/grave.db .
ln -s data/lookTime.db .
ln -s data/map.db .
ln -s data/mapTime.db .
ln -s data/meta.db .
ln -s data/playerStats.db .
ln -s data/trust.db .
ln -s data/biomeRandSeed.txt .
ln -s data/familyDataLog.txt .
ln -s data/log.txt .
ln -s data/recentPlacements.txt .

mv settings default-settings
mkdir settings
