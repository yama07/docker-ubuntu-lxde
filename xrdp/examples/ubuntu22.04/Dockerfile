FROM yama07/docker-ubuntu-lxde:22.04-pulseaudio_ja

## Customize login screen
RUN apt-get update \
    && apt-get install -y curl imagemagick \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \
    && curl -sS http://www.anit.az/wp-content/uploads/2017/12/logo_xrdp-1.png | \
        convert -flatten -resize 240x140 - bmp3:/usr/share/xrdp/xrdp_logo_flat.bmp \
    && sed -i".bak" /etc/xrdp/xrdp.ini \
        -e 's/^grey=.*$/grey=c9c9c9/' \
        -e 's/^#black=.*$/black=4f4f4f/' \
        -e 's/^#blue=.*$/blue=858585/' \
        -e 's/^ls_top_window_bg_color=.*$/ls_top_window_bg_color=002b36/' \
        -e 's/^ls_width=.*$/ls_width=470/' \
        -e 's/^ls_height=.*$/ls_height=340/' \
        -e 's/^ls_bg_color=.*$/ls_bg_color=ffffff/' \
        -e 's@^ls_logo_filename=.*$@ls_logo_filename=/usr/share/xrdp/xrdp_logo_flat.bmp@' \
        -e 's/^ls_logo_x_pos=.*$/ls_logo_x_pos=110/' \
        -e 's/^ls_label_x_pos=.*$/ls_label_x_pos=90/' \
        -e 's/^ls_input_x_pos=.*$/ls_input_x_pos=180/' \
        -e 's/^ls_input_y_pos=.*$/ls_input_y_pos=190/' \
        -e 's/^ls_btn_ok_x_pos=.*$/ls_btn_ok_x_pos=255/' \
        -e 's/^ls_btn_ok_y_pos=.*$/ls_btn_ok_y_pos=285/' \
        -e 's/^ls_btn_cancel_x_pos=.*$/ls_btn_cancel_x_pos=355/' \
        -e 's/^ls_btn_cancel_y_pos=.*$/ls_btn_cancel_y_pos=285/'

## Theme
RUN apt-get update \
    && apt-get install -y arc-theme  paper-icon-theme \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \
    && sed -i /etc/xdg/lxsession/LXDE/desktop.conf \
      -e 's@^sNet/ThemeName=.*$@sNet/ThemeName=Arc@' \
      -e 's@^sNet/IconThemeName=.*$@sNet/IconThemeName=Paper@' \
    && curl -sS -o /usr/share/lxde/images/lxde-icon-flat.png \
        https://icon-icons.com/icons2/1508/PNG/64/desktopenvironmentlxde_103966.png \
    && sed -i /etc/xdg/lxpanel/LXDE/panels/panel \
      -e 's@transparent=0$@transparent=1@' \
      -e 's@background=1$@background=0@' \
      -e 's@alpha=0$@alpha=181@' \
      -e 's@image=/usr/share/lxde/images/lxde-icon.png$@image=/usr/share/lxde/images/lxde-icon-flat.png@' \
    && sed -i /etc/xdg/openbox/LXDE/rc.xml \
      -e 's@<name>Onyx</name>@<name>Breeze-ob</name>@'

## Wallpaper
RUN curl -sS -o /usr/share/lxde/wallpapers/jammy-jellyfish-wallpaper.jpg \
        https://c0.wallpaperflare.com/path/294/1007/621/abstract-biology-black-background-graphic-f979b43712a2ddd8ef42f113d04670ab.jpg \
    && sed -i /etc/xdg/pcmanfm/LXDE/pcmanfm.conf \
      -e 's@wallpaper=/etc/alternatives/desktop-background@wallpaper=/usr/share/lxde/wallpapers/jammy-jellyfish-wallpaper.jpg@'

## System
RUN \
    ### PROXY
    { \
      echo 'Defaults env_keep="http_proxy"'; \
      echo 'Defaults env_keep+="https_proxy"'; \
    } > /etc/sudoers.d/ENV_KEEP \
    ### Default engine
    && sed -i "1i dconf write /desktop/ibus/general/preload-engines \"['mozc-jp']\"" /etc/skel/.xsession

## Dev tools
RUN apt-get update \
    && apt-get install -y \
        less vim emacs nano nkf tree \
        git tmux zip \
        cifs-utils \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

## VSCode
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list \
    && apt-get update \
    && apt-get install -y code \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

## Firefox
## https://launchpad.net/~mozillateam/+archive/ubuntu/ppa
RUN apt-get remove -y firefox \
    && curl -fsSL 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x0AB215679C571D1C8325275B9BDB3D89CE49EC21' | gpg --dearmor -o /usr/share/keyrings/mozillateam-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/mozillateam-keyring.gpg] https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/mozillateam.list \
    && { \
      echo "Package: firefox*"; \
      echo "Pin: release o=LP-PPA-mozillateam"; \
      echo "Pin-Priority: 1001"; \
    } > /etc/apt/preferences.d/mozilla-firefox \
    && apt-get update \
    && apt-get install -y firefox \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

## Google Chrome
## Note: linux/arm64 is not supported.
RUN [ $(dpkg --print-architecture) = "amd64" ] || exit 0; \
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/chrome-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/chrome-archive-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
