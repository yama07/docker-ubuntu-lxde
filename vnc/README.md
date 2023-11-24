# docker-ubuntu-lxde VNC

[![Docker Pulls](https://img.shields.io/docker/pulls/yama07/docker-ubuntu-lxde?style=for-the-badge)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde)
[![GitHub](https://img.shields.io/github/license/yama07/docker-ubuntu-lxde?style=for-the-badge)](https://github.com/yama07/docker-ubuntu-lxde)

## What is this?

Docker による Ubuntu の LXDE デスクトップ環境です。
リモートデスクトップとして VNC(x11vnc, noVNC)を使用します。

日本語環境(ibus-mozc による日本語入力可能)かつ、`-u`による一般ユーザ起動においても`sudo`コマンドが使用可能です。

![スクリーンショット](https://raw.githubusercontent.com/yama07/docker-ubuntu-lxde/master/screenshot/VNC-ubuntu20.04_ja.png)
![スクリーンショット](https://raw.githubusercontent.com/yama07/docker-ubuntu-lxde/master/screenshot/noVNC-ubuntu20.04_ja.png)

### Supported tags

- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/20.04-vnc_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=20.04-vnc_ja)
  `20.04-vnc_ja`, `focal-vnc_ja`: Ubuntu20.04 ベース [(vnc/Dockerfile.ubuntu20.04)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/vnc/Dockerfile.ubuntu20.04)
- [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yama07/docker-ubuntu-lxde/20.04-vnc-slim_ja?style=flat-square)](https://hub.docker.com/r/yama07/docker-ubuntu-lxde/tags?name=20.04-vnc-slim_ja)
  `20.04-vnc-slim_ja`, `focal-vnc-slim_ja`: サイズを軽量化した Ubuntu20.04 ベース [(vnc/Dockerfile.ubuntu20.04_slim)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/vnc/Dockerfile.ubuntu20.04)

## How to use

### Docker コンテナの起動

Docker コンテナの起動方法は以下の通りです。

```
$ docker run --rm -it \
    -p 5900:5900 \
    -p 8080:80 \
    -u $(id -u):$(id -g) \
    -e USER=yama07 \
    -e PASSWD=mypasswd \
    -e RESOLUTION=1024x768x24 \
    yama07/docker-ubuntu-lxde:20.04-vnc_ja
```

オプションは以下の通りです。

- `-p vnc_port:5900`
  VNC クライアントから接続されるポートを`vnc_port`に設定してください。
  VNC クライアントから接続しない場合（noVNC のみ利用する場合）は、設定不要です。
- `-p novnc_port:80`
  Web ブラウザから接続されるポートを`novnc_port`に設定してください。
  noVNC を利用しない場合（VNC クライアント接続のみ利用する場合）は、設定不要です。
- `-u user:group`
  コンテナを起動する UID を`user`に、GID を`group`に設定してください。
  指定しない場合は、root ユーザ(UID=0,GID=0)として起動します。
  なお、root ユーザとして起動した場合は、日本語入力(mozc)が利用できません。
- `-e USER=loginUser`
  RDP によるログインユーザを`loginUser`に設定してください。
  指定しない場合は、"developer"となります。ただし、root ユーザとしてコンテナを起動した際は"root"となります。
- `-e PASSWD=loginPasswd`
  RDP によるログインパスワードを`loginPasswd`に設定してください。
  指定しない場合は、"vncpasswd"となります。
- `-e RESOLUTION=WxHxD`
  スクリーンの幅を`W`、高さを`H`、深さを`D`に設定してください。
  指定しない場合は、"1280x720x24"となります。

接続後にログイン画面やデスクトップ画面が表示されない場合、`--privileged`オプションを付けることで成功する可能性があります。

コンテナ内のデスクトップ環境において、ほとんどの個人設定はホームディレクトリに保存されるため、 `-v ${HOME}/container_home:/home/yama07` のようにホームディレクトリをマウントするオプションを追加すれば、コンテナを停止＆起動しても個人の設定が維持されます。
ただし、マウントするディレクトリを**起動前に**作成しておかないと、Permission エラーが発生するため注意してください。

### クライアントからの接続

#### VNC クライアント

docker run 後に、RealVNC や UltraVNC 等の VNC クライアント（VNC Viewer）で接続して下さい。

この際、接続先は<Docker ホストの IP>:<`-p`オプションで指定した`vnc_port`>、パスワードは`-e PASSWD`で指定した`loginPasswd`を指定してください。

#### noVNC

docker run 後に、Web ブラウザで接続して下さい。

この際、接続先は http://<Docker ホストの IP>:<`-p`オプションで指定した`novnc_port`>/vnc.html (e.g. `http://localhost:8080/vnc.html`)、パスワードは`-e PASSWD`で指定した`loginPasswd`を指定してください。

## How to build

Docker イメージのビルド方法は以下の通りです。
（イメージの名前やタグは適宜変更してください。）

```
$ git clone https://github.com/yama07/docker-ubuntu-lxde.git
$ docker build \
    -t lxde_vnc:ubuntu20.04_ja \
    -f ./vnc/Dockerfile.ubuntu20.04 \
    ./vnc
```
