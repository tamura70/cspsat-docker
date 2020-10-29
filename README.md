## Docker image

これらの作業はサーバー管理者が行う．

#### dockerコマンドを実行できるユーザの登録

```
sudo adduser xxx docker
sudo adduser xxx users
```

- `xxx` はユーザ名

#### カレントディレクトリのDockerfileからdocker imageを作成

```
docker build -t cspsat-ubuntu ubuntu/
```

- ネットワーク環境の良好な場所で実行すること．
- `Dockerfile` の内容にしたがってdocker imageが作成され，`cspsat-ubuntu` というタグが付けられる．
    - docker imageのタグは，サーバー上で一意でなければならない
    - サーバー管理者以外がdocker imageにタグを付ける場合は，自分のユーザ名を利用すること
- 詳細は `Dockerfile` の内容を参照

軽量なイメージの alpine を用いる場合は以下の通り．

```
docker build -t cspsat-alpine alpine/
```

- shared libraryであるglibcなどが含まれていない．
  Cのプログラムを実行したい場合はstatic linkで実行ファイルを作成しておくこと．

#### Docker imageの一覧を表示

```
docker images
```

#### Docker imageの削除

```
docker rmi cspsat-ubuntu
```

- 必要があればタグでなくimage IDで削除する

## Docker container

これらの作業は利用者各自が行う．

#### 準備

Dockerの動作テスト

```
docker run --rm hello-world
```

作業用フォルダの作成と設定

```
mkdir work
chgrp -R users work
chmod -R g+x work
```

- `work` フォルダを作成するのは，任意のフォルダ内で良い
- `work` フォルダのgroupをusers (GID=100)に設定
- `work` フォルダにusers groupでの書き込み権限を与える

#### Docker containerの作成と実行

```
cd work
docker run --rm -it -v `pwd`:/work cspsat-ubuntu
```

- タグ `cspsat-ubuntu` が付いたdocker imageからcontainerが作成され，bashシェルが実行される．
- `--rm`  オプションにより，bashシェルが終了すればcontainerが削除される．
- `-it` オプションは，インタラクティブモードを指定している．
- `-v`  オプションにより，カレントフォルダをcontainerの `/work` フォルダにマウントしている．
- 他のオプションは `docker run --help` で調べられる．
    - `--cpus 1` : CPUコア数を1個に制限 (未確認)
    - `--memory 4g` : メモリサイズを4GBに制限 (未確認)
    - `--ulimit` : ulimitの設定 (未確認)

bashシェルのプロンプトが表示されたのち，以下のようにしてコマンドを実行できる
(`csp-examples/nqueens-8.csp` が存在している場合)．

```
sugar -vv -solver minisat csp-examples/nqueens-8.csp
```

- 実行権限は `cspsat` ユーザ (UID=2000, GID=100, PW=`cspsat`)，最初のディレクトリは `/work` である
  (`Dockerfile` 中で指定)．
- ホスト側の `work` フォルダがGID=100でwritableであると仮定している．
- 管理者権限でコマンドを実行したい場合は `sudo` を用いる．
- `/work` フォルダ中にファイルを作成した場合，実際にはホスト側のカレントフォルダに作成される．
- `/work` フォルダ以外に作成したファイルなどは，containerを終了した時点で削除される．

以下のようにすれば，直接実行できる．

```
docker run --rm -it -v `pwd`:/work cspsat-ubuntu sugar -vv -solver minisat csp-examples/nqueens-8.csp
```

シェルスクリプト `drun` を利用しても良い．

#### Docker containerの一覧を表示

```
docker ps -a
```

- Container IDが表示される

#### Docker containerの削除

```
docker rm <container ID>
```

- 他人のdocker containerを削除しないように注意する必要がありそう

#### 不要なDocker volumeの削除

```
docker volume prune
```

