#!/bin/zsh

if [ -z "$1" ]
  then
    echo "Enter output filename:"
    read outputFile
else
  outputFile=$1
fi

if [ -z "$2" ]
  then
    echo "Enter a URL:"
    read url
  else
    url=$2
fi

ext='.ts'
fullOutput="${outputFile}${ext}"


mpv --quiet --mute=yes --stream-record="${HOME}/Downloads/Captures/Autosaved Captures.localized/${fullOutput}" $url > /dev/null &

