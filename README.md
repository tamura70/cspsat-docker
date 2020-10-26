## Docker image

#### カレントディレクトリのDockerfileからdocker imageを作成

```
docker build -t cspsat:1.0 .
```

- `cspsat:1.0` というタグを付ける

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

- タグ `cspsat:1.0` が付いたdocker imageからcontainerを作成され，bashシェルが実行される
- `cspsat1` というcontainer名を付ける
- `--rm`  オプションにより，bashシェルが終了すればcontainerが削除される
- `-it` オプションはインタラクティブモードを指定している
- `-v`  オプションにより，カレント`work` フォルダをcontainerの `/work` フォルダにマウントしている

bashシェルのプロンプトが表示されれば，以下のようにして実行できる．

```
sugar -vv -solver minisat nqueens-8.csp
```

- `/work` フォルダ中にファイルを作成した場合，実際にはホスト側の `work` フォルダに作成される
  (UID=1000, GID=1000)．
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

