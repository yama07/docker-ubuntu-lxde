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
      sudo \
      supervisor \
      tzdata \
      xorg \
      xorgxrdp \
      xrdp \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build \
    /opt/su-exec/su-exec /usr/sbin/su-exec

# Set locale
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo 'Asia/Tokyo' > /etc/timezone
RUN locale-gen ja_JP.UTF-8 \
    && echo 'LC_ALL=ja_JP.UTF-8' > /etc/default/locale \
    && echo 'LANG=ja_JP.UTF-8' >> /etc/default/locale
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8

# Set default vars
ENV DEFAULT_USER=developer \
    DEFAULT_PASSWD=xrdppasswd

# Set sudoers for any user
RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ALL

# Change permission so that non-root user can add users and groups
RUN chmod u+s /usr/sbin/useradd \
    && chmod u+s /usr/sbin/groupadd

# Expose RDP port
EXPOSE 3389

RUN echo "startlxde" > /etc/skel/.xsession \
    && install -o root -g xrdp -m 2775 -d /var/run/xrdp \
    && install -o root -g xrdp -m 3777 -d /var/run/xrdp/sockdir \
    && install -o root -g root -m 0755 -d /var/run/dbus \
    && install -o root -g root -m 0644 /dev/null /etc/securetty \
    && sed -i 's|.*pam_systemd.so|#&|g' /etc/pam.d/common-session \
    && sed -i 's|\[Session\]|&\npolkit/command=|' /etc/xdg/lxsession/LXDE/desktop.conf \
    && usermod -aG ssl-cert xrdp \
    && ln -s /usr/share/lxde/wallpapers/lxde_blue.jpg /etc/alternatives/desktop-background

# Set supervisord conf for xrdp service
RUN { \
      echo "[supervisord]"; \
      echo "user=root"; \
      echo "nodaemon=true"; \
      echo "logfile=/var/log/supervisor/supervisord.log"; \
      echo "childlogdir=/var/log/supervisor"; \
      echo "[program:dbus]"; \
      echo "command=/usr/bin/dbus-daemon --system --nofork --nopidfile"; \ 
      echo "[program:xrdp-sesman]"; \
      echo "command=/usr/sbin/xrdp-sesman --nodaemon"; \
      echo "[program:xrdp]"; \
      echo "command=/usr/sbin/xrdp --nodaemon"; \
      echo "user=xrdp"; \
    } > /etc/supervisor/xrdp.conf

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
