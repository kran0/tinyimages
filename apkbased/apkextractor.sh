#!/bin/sh

# Extracts installed apk package files
#  from Alpine system to the target directory
#
# USAGE: $0 PACKAGE [PACKAGE] ... [PACKAGE]
#

[ -z "$1" ]      && exit 0
[ -z "$TARGET" ] && TARGET="/target"
#[ -d "$TARGET" ] && mkdir -p "$TARGET"
mkdir -p "$TARGET"


function getDependsOn {
# find full number of depencies
 [ -z "$1" ] && exit 0

 if [ -z "$SEENFILE" ]
 then
  SEENFILE=$(mktemp)
  printf '%s\n' "$@" > $SEENFILE
 fi

 DEPENDSON=$(apk info -R "$@"\
             | sed -e '/ depends on:$/d'\
             | grep -Fxvf "$SEENFILE"\
             | tee -a "$SEENFILE")

 printf '%s\n' "$@" "$DEPENDSON" $(getDependsOn "$DEPENDSON")
 [ -f "$SEENFILE" ] && rm "$SEENFILE"
}

function getContains {
# find unique file names containeing in given packages
 [ -z "$1" ]\
  || apk info -L "$@"\
     | sed -e '/ contains:$/d'\
           -e '/^[[:space:]]*$/d'\
     | sort -u
}

getContains $(getDependsOn "$@" | sort -u)\
 | tar vc -C / -T -\
 | tar x -C "$TARGET"
