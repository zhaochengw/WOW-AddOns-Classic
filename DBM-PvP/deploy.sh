#!/bin/bash

function error() {
	echo $*
	exit 1
}

test -e "$1" || error "Usage: $0 <WoW base dir>"

CLASSIC="$1/_classic_era_/Interface/AddOns/DBM-PvP"
WOTLK="$1/_classic_/Interface/AddOns/DBM-PvP"
RETAIL="$1/_retail_/Interface/AddOns/DBM-PvP"

rsync --delete -r --exclude=.\* DBM-PvP/ "$CLASSIC"
rsync --delete -r --exclude=.\* DBM-PvP/ "$WOTLK"
rsync --delete -r --exclude=.\* DBM-PvP/ "$RETAIL"
