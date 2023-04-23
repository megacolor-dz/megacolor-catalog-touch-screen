#!/usr/bin/env bash

img_path=$1
if [[ "$img_path" != *.original ]]; then
  echo image file "$img_path" must have .original extension
  exit 1
fi
echo adding logos to $img_path
img=$(basename $img_path)
img=${img/.original/}
dest=$(echo $img_path | sed -e 's/\/.*//')
img_height=$(convert $img_path -print "%h" /dev/null)
logo_megacolor_height=$(echo $img_height/7 | bc)
logo_kdenco_height=$(echo $img_height/5 | bc)
convert megacolor-logo.png -resize $logo_megacolor_height megacolor-logo-temp.png
convert kndeco+spiver-logo.png -resize $logo_kdenco_height kndeco+spiver-logo-temp.png
margin=$(echo "${logo_megacolor_height}/10" | bc)
geometry="+${margin}+${margin}"
convert \
  $img_path megacolor-logo-temp.png -gravity southwest -geometry $geometry \
  -composite kndeco+spiver-logo-temp.png -gravity southeast -geometry $geometry \
  -composite $dest/$img
rm megacolor-logo-temp.png kndeco+spiver-logo-temp.png
