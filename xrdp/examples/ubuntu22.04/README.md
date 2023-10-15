# docker-ubuntu-lxde XRDP example

## What is this?

Docker Hub で公開している Docker イメージを利用した、カスタマイズ例です。

- ログイン画面のカスタマイズ
  ![カスタマイズ例 ログイン画面](https://raw.githubusercontent.com/yama07/docker-ubuntu-lxde/master/screenshot/XRDP-example-22.04-login.png)
- デスクトップテーマのカスタマイズ
  ![カスタマイズ例 テーマ](https://raw.githubusercontent.com/yama07/docker-ubuntu-lxde/master/screenshot/XRDP-example-22.04.png)
- アプリケーションのインストール
  ![カスタマイズ例 アプリ](https://raw.githubusercontent.com/yama07/docker-ubuntu-lxde/master/screenshot/XRDP-example-22.04-app.png)

## How to use

### Docker イメージのビルド

Docker イメージ名は任意の名前で構わないため、必要に応じて`docker-compose.yml`内の`image`を変更して、以下コマンドを実行してください。

```
$ docker compose build
```

### Docker コンテナの起動

`docker-compose.yml`内の`user`を自身の"ユーザ ID:グループ ID"に修正してください。
また、ログイン ID/PW、バインドするポート番号や、マウントするディレクトリの設定は適宜変更して、以下コマンドを実行してください。

```
$ docker compose up -d
```

接続後にログイン画面やデスクトップ画面が表示されない場合、`privileged: true`オプションを付けることで成功する可能性があります。
