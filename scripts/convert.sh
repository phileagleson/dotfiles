#!/bin/zsh

for filename in $HOME/Downloads/Captures/Autosaved\ Captures.localized/*.ts; do
  ext='.mp4'
  baseName=${filename%.*}
  outputName=${baseName}${ext}
  ffmpeg -i "${filename}" -acodec copy -vcodec copy "${outputName}" > /dev/null


  #Delete after conversion
  rm "${filename}" 

done



