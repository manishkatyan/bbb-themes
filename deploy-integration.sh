#!/bin/bash
HEAD_HTML="/usr/share/meteor/bundle/programs/web.browser/head.html"
HEAD_HTML_DEFAULT="/usr/share/meteor/bundle/programs/web.browser/head.html.default"
HEAD_HTML_LEGACY="/usr/share/meteor/bundle/programs/web.browser.legacy/head.html"
HEAD_HTML_LEGACY_DEFAULT="/usr/share/meteor/bundle/programs/web.browser.legacy/head.html.default"
BBB_WEBROOT="/var/www/bigbluebutton-default"

install_themes(){
    backup_default_files
    if [ -d "$BBB_WEBROOT/bbb-themes" ];then
    echo "bbb-theme already installed.Do you wish to install it again?"
    echo "Note: Any changes you have made to bbb-themes will be lost"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) 
            wget -O "$BBB_WEBROOT/main.tar.gz" https://github.com/manishkatyan/bbb-themes/archive/main.tar.gz   
            tar -xvzf "$BBB_WEBROOT/main.tar.gz" -C "$BBB_WEBROOT/bbb-themes/" --strip-components=1
            if ! grep -Fxq "<link rel=\"stylesheet\" href=\"/bbb-themes/bbb-theme.css\">" $HEAD_HTML
            then
                echo "">> $HEAD_HTML
                echo "">> $HEAD_HTML_LEGACY
                echo "<link rel=\"stylesheet\" href=\"/bbb-themes/bbb-theme.css\">"  >>  $HEAD_HTML
                echo "<link rel=\"stylesheet\" href=\"/bbb-themes/bbb-theme.css\">"  >>  $HEAD_HTML_LEGACY
            fi
            echo "Please select the theme."
            set_theme
            echo "Theme installed Successfully Please restart BigBlueButton"
            exit;;
            No ) exit;;
        esac
    done

    else
        echo "Creating bbb-themes"
        mkdir -p "$BBB_WEBROOT/bbb-themes"
        wget -O "$BBB_WEBROOT/main.tar.gz" https://github.com/manishkatyan/bbb-themes/archive/main.tar.gz; 
        tar -xvzf "$BBB_WEBROOT/main.tar.gz" -C "$BBB_WEBROOT/bbb-themes/" --strip-components=1
        echo "">> $HEAD_HTML
        echo "">> $HEAD_HTML_LEGACY
        echo "<link rel=\"stylesheet\" href=\"/bbb-themes/bbb-theme.css\">"  >>  $HEAD_HTML
        echo "<link rel=\"stylesheet\" href=\"/bbb-themes/bbb-theme.css\">"  >>  $HEAD_HTML_LEGACY
        echo "Please select the theme."
        set_theme
        echo "Theme installed Successfully Please restart BigBlueButton"
    fi
}

backup_default_files(){
    if [ ! -f "$HEAD_HTML_DEFAULT" ];then
        echo "Creating a copy of $HEAD_HTML at $HEAD_HTML_DEFAULT"
        cp $HEAD_HTML $HEAD_HTML_DEFAULT
    fi

    if [ ! -f "$HEAD_HTML_LEGACY_DEFAULT" ];then
        echo "Creating a copy of $HEAD_HTML_LEGACY at $HEAD_HTML_LEGACY_DEFAULT"
        cp "$HEAD_HTML_LEGACY" "$HEAD_HTML_LEGACY_DEFAULT"
    fi
}

uninstall_themes(){
    echo "Uninstalling bbb-themes"
    mv $HEAD_HTML_DEFAULT $HEAD_HTML
    mv $HEAD_HTML_LEGACY_DEFAULT $HEAD_HTML_LEGACY
    echo "Please restart the BigBlueButton to complete the bbb-themes uninstall"
    echo "To restart please run bbb-conf --restart"
}


set_theme(){
    cd "$BBB_WEBROOT/bbb-themes/themes/";
    select theme in *; do
        echo "Selected Theme: $theme"
        echo "@import \"./themes/$theme/theme.css\"" > "$BBB_WEBROOT/bbb-themes/bbb-theme.css"
        break;
    done
}

# check_if_theme_installed(){
#     theme_name=$1
#     is_theme_imported=false
#     is_theme_added=false
#     if grep -Fxq "<link rel=\"stylesheet\" href=\"/bbb-themes/bbb-theme.css\">" $HEAD_HTML
#     then
#         is_theme_added=true
#     fi

#     if grep -Fxq "$theme_name" "$BBB_WEBROOT/bbb-themes/bbb-theme.css"
#     then
#         is_theme_added=true
#     fi
#     if [ $is_theme_imported && $is_theme_added ];then
#         theme_installed=true
#     fi
# }

init_bbb_themes(){
    select action in Set-Theme Install Uninstall Exit;do
        case $action in
            Set-Theme )
                set_theme
                echo "Theme set successfully."
                break;;

            Install )
                install_themes
                 break;;

            Uninstall )
                uninstall_themes;
                exit;;
                
            Exit )
            echo "Exitting..."
                exit;;
        esac
    done
}
init_bbb_themes
