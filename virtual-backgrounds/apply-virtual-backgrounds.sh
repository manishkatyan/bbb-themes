#!/bin/bash
FULL="/usr/share/meteor/bundle/programs/web.browser/app/resources/images/virtual-backgrounds"
THUMB="${FULL}/thumbnails"
HTML5_ETC_CONFIG="/etc/bigbluebutton/bbb-html5.yml"
TEMP_HTML5_CONFIG="/tmp/bbb-html5.yml"
THEME_PATH="/var/www/bigbluebutton-default/themes"

cp -r *.jpg "$FULL"

if [ ! -f "$HTML5_ETC_CONFIG" ];then
    touch "$HTML5_ETC_CONFIG"
fi

cd "$THEME_PATH/virtual-backgrounds/"

echo "" | tee "$TEMP_HTML5_CONFIG"

for pic in *.jpg; do

    convert "$pic" -resize 50x50^ -gravity Center -extent 50x50 "${THUMB}/${pic}"

    yq w "$TEMP_HTML5_CONFIG" public.virtualBackgrounds.fileNames[+] "$pic"  | tee "$HTML5_ETC_CONFIG"
done

echo "Please restart the BigBluebutton"