# docker-ubuntu-lxde

[![Docker Pulls](https://img.shields.io/docker/pulls/yama07/docker-ubuntu-lxde?style=for-the-badge)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde)
[![GitHub](https://img.shields.io/github/license/yama07/docker-ubuntu-lxde?style=for-the-badge)](https://github.com/yama07/docker-ubuntu-lxde)

[![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/yama07/docker-ubuntu-lxde/.github%2Fworkflows%2Fubuntu20.04_all.yml?logo=githubactions&label=Build%20Ubuntu20.04%20based%20Docker%20images&style=for-the-badge)](https://github.com/yama07/docker-ubuntu-lxde/actions/workflows/ubuntu20.04_all.yml)
[![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/yama07/docker-ubuntu-lxde/.github%2Fworkflows%2Fubuntu22.04_all.yml?logo=githubactions&label=Build%20Ubuntu22.04%20based%20Docker%20images&style=for-the-badge)](https://github.com/yama07/docker-ubuntu-lxde/actions/workflows/ubuntu22.04_all.yml)

## Quick reference

- [README | XRDP Docker image](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/README.md)
- [README | VNC/noVNC Docker image](https://github.com/yama07/docker-ubuntu-lxde/blob/master/vnc/README.md)

## What is this?

Ubuntu の LXDE デスクトップ環境の Docker image です。
リモートデスクトップとして RDP(xrdp)や VNC(x11vnc, noVNC)を使用します。

日本語環境(ibus-mozc による日本語入力可能)かつ、`-u`による一般ユーザ起動においても`sudo`コマンドが使用可能です。

## Supported tags

### XRDP

- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/22.04-xrdp_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=22.04-xrdp_ja)
  `22.04-xrdp_ja`, `jammy-xrdp_ja`, `latest-xrdp`, `latest`: Ubuntu22.04 ベース [(xrdp/Dockerfile.ubuntu22.04)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/Dockerfile.ubuntu22.04)
- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/22.04-xrdp-slim_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=22.04-xrdp-slim_ja)
  `22.04-xrdp-slim_ja`, `jammy-xrdp-slim_ja`: サイズを軽量化した Ubuntu22.04 ベース [(xrdp/Dockerfile.ubuntu22.04)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/Dockerfile.ubuntu22.04)
- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/22.04-xrdp-pulseaudio_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=22.04-xrdp-pulseaudio_ja)
  `22.04-xrdp-pulseaudio_ja`, `jammy-xrdp-pulseaudio_ja`: 音声転送可能な Ubuntu22.04 ベース [(xrdp/Dockerfile.ubuntu22.04_pulseaudio)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/Dockerfile.ubuntu22.04_pulseaudio)
- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/20.04-xrdp_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=20.04-xrdp_ja)
  `20.04-xrdp_ja`, `focal-xrdp_ja`: Ubuntu20.04 ベース [(xrdp/Dockerfile.ubuntu20.04)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/Dockerfile.ubuntu20.04)
- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/20.04-xrdp-slim_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=20.04-xrdp-slim_ja)
  `20.04-xrdp-slim_ja`, `focal-xrdp-slim_ja`: サイズを軽量化した Ubuntu20.04 ベース [(xrdp/Dockerfile.ubuntu20.04)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/Dockerfile.ubuntu20.04)
- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/20.04-xrdp-pulseaudio_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=20.04-xrdp-pulseaudio_ja)
  `20.04-xrdp-pulseaudio_ja`, `focal-xrdp-pulseaudio_ja`: 音声転送可能な Ubuntu20.04 ベース [(xrdp/Dockerfile.ubuntu20.04_pulseaudio)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/Dockerfile.ubuntu20.04_pulseaudio)

### VNC

- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/22.04-vnc_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=22.04-vnc_ja)
  `22.04-vnc_ja`, `jammy-vnc_ja`, `latest-vnc`: Ubuntu22.04 ベース [(vnc/Dockerfile.ubuntu22.04)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/vnc/Dockerfile.ubuntu22.04)
- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/22.04-vnc-slim_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=22.04-vnc-slim_ja)
  `22.04-vnc-slim_ja`, `jammy-vnc-slim_ja`: サイズを軽量化した Ubuntu22.04 ベース [(vnc/Dockerfile.ubuntu22.04_slim)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/vnc/Dockerfile.ubuntu22.04)
- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/20.04-vnc_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=20.04-vnc_ja)
  `20.04-vnc_ja`, `focal-vnc_ja`: Ubuntu20.04 ベース [(vnc/Dockerfile.ubuntu20.04)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/vnc/Dockerfile.ubuntu20.04)
- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/20.04-vnc-slim_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=20.04-vnc-slim_ja)
  `20.04-vnc-slim_ja`, `focal-vnc-slim_ja`: サイズを軽量化した Ubuntu20.04 ベース [(vnc/Dockerfile.ubuntu20.04_slim)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/vnc/Dockerfile.ubuntu20.04)

## Quick start

### XRDP

```sh
$ docker run -it \
    -p 3389:3389 \
    -u $(id -u):$(id -g) \
    -e USER=yama07 \
    -e PASSWD=mypasswd \
    yama07/docker-ubuntu-lxde:20.04-xrdp_ja
```

リモートデスクトップアプリケーションで `<DockerホストのIPアドレス>:3389`に接続して下さい。
ユーザー名は`yama07`、パスワードは`mypasswd`です。

接続後にログイン画面やデスクトップ画面が表示されない場合、`--privileged`オプションを付けることで成功する可能性があります。

パラメータの詳細などは、[README | XRDP Docker image](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/README.md)を参照して下さい。

### VNC

```sh
$ docker run -it \
    -p 5900:5900 \
    -p 8080:80 \
    -u $(id -u):$(id -g) \
    -e USER=yama07 \
    -e PASSWD=mypasswd \
    -e RESOLUTION=1024x768x24 \
    yama07/docker-ubuntu-lxde:20.04-vnc_ja
```

VNC クライアント（VNC Viewer）で`<DockerホストのIPアドレス>:5900`に接続して下さい。
あるいは、Web ブラウザで`http://<DockerホストのIPアドレス>:8080/vnc.html`にアクセスして下さい。
パスワードは`mypasswd`です。

接続後にデスクトップ画面が表示されない場合、`--privileged`オプションを付けることで成功する可能性があります。

パラメータの詳細などは、[README | VNC/noVNC Docker image](https://github.com/yama07/docker-ubuntu-lxde/blob/master/vnc/README.md)を参照して下さい。

## Screenshots

### XRDP

![XRDP screenshot](https://raw.githubusercontent.com/yama07/docker-ubuntu-lxde/master/screenshot/XRDP-ubuntu20.04_ja.png)

### VNC

![VNC screenshot](https://raw.githubusercontent.com/yama07/docker-ubuntu-lxde/master/screenshot/VNC-ubuntu20.04_ja.png)

### noVNC

![noVNC screenshot](https://raw.githubusercontent.com/yama07/docker-ubuntu-lxde/master/screenshot/noVNC-ubuntu20.04_ja.png)
