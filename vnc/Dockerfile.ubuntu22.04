FROM ubuntu:22.04 as build

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y curl make gcc

RUN curl -s -L https://github.com/ncopa/su-exec/archive/v0.2.tar.gz | tar zx -C /opt/ \
    && mv /opt/su-exec* /opt/su-exec \
    && cd /opt/su-exec \
    && make

####################################

FROM ubuntu:22.04

# For slim:
#   --build-arg ADDITIONAL_APT_GET_OPTS=--no-install-recommends
ARG ADDITIONAL_APT_GET_OPTS=""

RUN echo 'path-include=/usr/share/locale/ja/LC_MESSAGES/*.mo' > /etc/dpkg/dpkg.cfg.d/includes \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y $ADDITIONAL_APT_GET_OPTS \
      dbus-x11 \
      fonts-noto-cjk \
      ibus \
      ibus-gtk \
      ibus-gtk3 \
      ibus-gtk4 \
      ibus-mozc \
      im-config \
      language-pack-ja \
      language-pack-ja-base \
      lxde \
      net-tools \
      novnc \
      sudo \
      supervisor \
      tzdata \
      x11vnc \
      xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build \
    /opt/su-exec/su-exec /usr/sbin/su-exec

# Set locale
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo 'Asia/Tokyo' > /etc/timezone \
    && locale-gen ja_JP.UTF-8 \
    && echo 'LC_ALL=ja_JP.UTF-8' > /etc/default/locale \
    && echo 'LANG=ja_JP.UTF-8' >> /etc/default/locale
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8

# Set default vars
ENV DEFAULT_USER=developer \
    DEFAULT_PASSWD=vncpasswd

# Set sudoers for any user
RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ALL

# Change permission so that non-root user can add users and groups
RUN chmod u+s /usr/sbin/useradd \
    && chmod u+s /usr/sbin/groupadd

# Expose VNC and noVNC ports
EXPOSE 5900
EXPOSE 80

RUN install -o root -g root -m 0755 -d /var/run/dbus \
    && sed -i 's|\[Session\]|&\npolkit/command=|' /etc/xdg/lxsession/LXDE/desktop.conf \
    && ln -s /usr/share/lxde/wallpapers/lxde_green.jpg /etc/alternatives/desktop-background

# Set supervisord conf
RUN { \
      echo '[supervisord]'; \
      echo 'user=root'; \
      echo 'nodaemon=true'; \
      echo 'logfile=/var/log/supervisor/supervisord.log'; \
      echo 'childlogdir=/var/log/supervisor'; \
      echo '[program:dbus]'; \
      echo 'priority=10'; \
      echo 'command=/usr/bin/dbus-daemon --system --nofork --nopidfile'; \
      echo '[program:lightdm]'; \
      echo 'priority=20'; \
      echo 'command=/usr/local/bin/start-lightdm.sh'; \
      echo '[program:x11vnc]'; \
      echo 'priority=30'; \
      echo 'startretries=5'; \
      echo 'command=/usr/bin/x11vnc -display :0 -auth /var/run/lightdm/root/:0 -rfbauth /etc/x11vnc.passwd -xkb -forever -shared -repeat -capslock'; \
      echo '[program:novnc]'; \
      echo 'priority=40'; \
      echo 'user=${USER}'; \
      echo 'command=/usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen 80'; \
    } > /etc/supervisor/vnc.conf.template

# Set scripts and configuration for lightdm and Xvfb
RUN { \
        # This script waits for D-Bus to be ready, then starts lightdm.
        # If lightdm starts before D-Bus is active, the startup of lightdm may fail.
        # Therefore, it is necessary to wait until D-Bus is ready before starting lightdm.
        # This script was created to solve this problem.
        echo '#!/bin/sh'; \
        echo 'while true'; \
        echo 'do'; \
        echo '    busctl > /dev/null 2>&1 && break'; \
        echo '    sleep 0.1'; \
        echo 'done'; \
        echo 'exec /usr/sbin/lightdm'; \
    } > /usr/local/bin/start-lightdm.sh \
    && chmod +x /usr/local/bin/start-lightdm.sh \
    && { \
        # This script starts Xvfb with the given resolution
        echo '#!/bin/sh'; \
        echo 'RESOLUTION="$1"'; \
        echo 'exec /usr/bin/Xvfb :0 -screen 0 "$RESOLUTION" -nolisten tcp'; \
    } > /usr/local/bin/start-Xvfb.sh \
    && chmod +x /usr/local/bin/start-Xvfb.sh \
    && { \
        # This is a template for lightdm configuration
        echo '[Seat:*]'; \
        echo 'xserver-command=/usr/local/bin/start-Xvfb.sh "${RESOLUTION}"'; \
        echo 'autologin-user=${USER}'; \
        echo 'autologin-user-timeout=0'; \
        echo 'autologin-session=LXDE'; \
    } > /etc/lightdm/lightdm.conf.template

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
