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

## Docker container

#### Docker containerの作成と実行

```
docker run --name cspsat1 --rm -it cspsat:1.0

```

- タグ `cspsat:1.0` が付いたdocker imageからcontainerを作成され，bashシェルが実行される
- `cspsat1` というcontainer名を付ける
- `--rm` により，bashシェルが終了すればcontainerが削除される
- `-it` はインタラクティブモードの指定

