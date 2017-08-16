FROM ubuntu:14.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      lxde \
      xrdp \
      ibus \
      ibus-mozc \
      language-pack-ja-base \
      language-pack-ja \
      fonts-ipafont-gothic \
      fonts-ipafont-mincho \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

# Expose RDP port
EXPOSE 3389

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
ENV USER_NAME=developer \
    PASSWD=xrdppasswd
ENV HOME=/home/${USER_NAME}
WORKDIR $HOME
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER_NAME}

# Change permission so that non-root user can add users and groups
RUN chmod u+s /usr/sbin/useradd \
    && chmod u+s /usr/sbin/groupadd

# Copy XRDP endpoint script
COPY endpoint.sh /opt/
CMD ["/opt/endpoint.sh"]
