# Install 

## Install bbb-themes:
```sh
curl -O https://raw.githubusercontent.com/manishkatyan/bbb-themes/main/deploy-integration.sh && bash deploy-integration.sh
```
Then select the appropriate options.

## Change bbb-theme:
run: 

`bash /var/www/bigbluebutton-default/themes/deploy-integration.sh`  and select "Set-Theme" option

## Set virtual background:

- First install bbb-themes.
- Copy the virtual background image into `/var/www/bigbluebutton-default/themes/virtual-backgrounds/` 

- run `bash /var/www/bigbluebutton-default/themes/virtual-backgrounds/apply-virtual-backgrounds.sh`


# Uninstall

## Uninstall the bbb-themes:
 Run:
 
 `bash /var/www/bigbluebutton-default/themes/deploy-integration.sh` and select Uninstall option.

## Remove Virtual background:

Run:

`rm /usr/share/meteor/bundle/programs/web.browser/app/resources/images/virtual-backgrounds/<IMAGE_NAME>.jpg`

`rm /usr/share/meteor/bundle/programs/web.browser/app/resources/images/virtual-backgrounds/thumbnails/<IMAGE_NAME>.jpg`

Remove the IMAGE_NAME.jpg from `/etc/bigbluebutton/bbb-html5.yml`

## Don't forget to restart the bbb each time you run these scripts.
