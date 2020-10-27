## Docker image

#### カレントディレクトリのDockerfileからdocker imageを作成

```
docker build -t cspsat:1.0 .
```

- ネットワーク環境の良好な場所で実行すること．
- `Dockerfile` の内容にしたがってdocker imageが作成され，`cspsat:1.0` というタグが付けられる．
- 詳細は `Dockerfile` の内容を参照

#### Docker imageの一覧を表示

```
docker images
```

#### Docker imageの削除

```
docker rmi cspsat:1.0
```

- 必要があればタグでなくimage IDで削除する

## Docker container

#### Docker containerの作成と実行

```
docker run --name cspsat1 --rm -it -v `pwd`/work:/work cspsat:1.0
```

- タグ `cspsat:1.0` が付いたdocker imageからcontainerが作成され，bashシェルが実行される．
- containerには `cspsat1` というcontainer名が付けられる．
- `--rm`  オプションにより，bashシェルが終了すればcontainerが削除される．
- `-it` オプションは，インタラクティブモードを指定している．
- `-v`  オプションにより，カレントフォルダ中の `work` フォルダをcontainerの `/work` フォルダにマウントしている．
- 追加で `--cpuset-cpus 0` と指定すればCPUコア0番を使用する (未確認)．
- 追加で `-m 2g` と指定すればメモリサイズが2GBに制限される (未確認)．

bashシェルのプロンプトが表示されたのち，以下のようにしてコマンドを実行できる．

```
sugar -vv -solver minisat csp-examples/nqueens-8.csp
```

- 実行権限は `cspsat` ユーザ (UID=1000, GID=1000, PW=`cspsat`)，最初のディレクトリは `/work` である
  (`Dockerfile` 中で指定)．
- ホスト側の `work` フォルダのownerがUID=1000であると仮定している．
- 管理者権限でコマンドを実行したい場合は `sudo` を用いる．
- `/work` フォルダ中にファイルを作成した場合，実際にはホスト側の `work` フォルダに作成される．
- `/work` フォルダ以外に作成したファイルなどは，containerを終了した時点で削除される．

#### Docker containerの一覧を表示

```
docker ps -a
```

- Container IDが表示される

#### Docker containerの削除

```
docker rm <container ID>
```

#### 不要なDocker volumeの削除

```
docker volume prune
```

