# docker-ubuntu-lxde XRDP

## What is this?

DockerによるUbuntuのLXDEデスクトップ環境です。
リモートデスクトップとしてRDP(xrdp)を使用します。

日本語環境(ibus-mozcによる日本語入力可能)かつ、`-u`による一般ユーザ起動においても`sudo`コマンドが使用可能です。

![スクリーンショット](https://raw.githubusercontent.com/yama07/docker-ubuntu-lxde/master/screenshot/XRDP-ubuntu18.04_ja.png)

### Supported tags

- `ubuntu16.04_ja`: Ubuntu16.04ベース [(xrdp/Dockerfile.ubuntu16.04)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/Dockerfile.ubuntu16.04)
- `ubuntu18.04_ja`, `latest`: Ubuntu18.04ベース [(xrdp/Dockerfile.ubuntu18.04)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/Dockerfile.ubuntu18.04)
- `ubuntu18.04-pulseaudio_ja`: 音声転送可能なUbuntu18.04ベース [(xrdp/Dockerfile.ubuntu18.04_pulseaudio)](https://github.com/yama07/docker-ubuntu-lxde/blob/master/xrdp/Dockerfile.ubuntu18.04_pulseaudio)

## How to use

### Dockerコンテナの起動

Dockerコンテナの起動方法は以下の通りです。

```
$ docker run --rm -it \
    -p 3389:3389 \
    -u $(id -u):$(id -g) \
    -e USER=yama07 \
    -e PASSWD=mypasswd \
    yama07/docker-ubuntu-lxde:ubuntu18.04_ja
```

オプションは以下の通りです。

- `-p port:3389`
クライアントから接続されるポートを`port`に設定してください。
- `-u user:group`
コンテナを起動するUIDを`user`に、GIDを`group`に設定してください。
指定しない場合は、rootユーザ(UID=0,GID=0)として起動します。
なお、rootユーザとして起動した場合は、日本語入力(mozc)が利用できません。
- `-e USER=loginUser`
RDPによるログインユーザを`loginUser`に設定してください。
指定しない場合は、“developer”となります。ただし、rootユーザとしてコンテナを起動した際は“root”となります。
- `-e PASSWD=loginPasswd`
RDPによるログインパスワードを`loginPasswd`に設定してください。
指定しない場合は、“xrdppasswd”となります。

mozcで「変換エンジンプログラムの起動に失敗しました。」とエラーが発生した場合は、`--privileged`オプションを付けることで成功する可能性があります。

### クライアントからの接続

docker run後に、リモートデスクトップアプリケーション（Macの場合は「Microsoft Remote Desktop」、Linuxの場合は「xfreerdp」や「Remmina」等）で接続してください。

この際、接続先は(DockerホストのIP):(`-p`オプションで指定した`port`)、ユーザは`-e USER`で指定した`loginUser`、パスワードは`-e PASSWD`で指定した`loginPasswd`を指定してください。

## How to build

Dockerイメージのビルド方法は以下の通りです。
（イメージの名前やタグは適宜変更してください。）

```
$ git clone https://github.com/yama07/docker-ubuntu-lxde.git
$ docker build \
    -t lxde_xrdp:ubuntu18.04_ja \
    -f ./xrdp/Dockerfile.ubuntu18.04 \
    ./xrdp
```
