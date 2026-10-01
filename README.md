# term

iTerm2で、ペインの配置と各ペインで実行するコマンドをセットにしたプリセットを、1コマンドで呼び出すための小さなシェルスクリプト

```sh
term dev
```

これだけで、ペインが指定した形に分割され、それぞれで `cd` やコマンド実行まで自動的に行われます。

## Requirements

- macOS
- [iTerm2](https://iterm2.com)

## Install

```bash
git clone https://github.com/fantasma3rd/iterm-term.git
cd iterm-term
./install.sh
```

`~/.config/term/term.sh` にスクリプトがコピーされ、`~/.config/term/presets/` が作成されます。
その後、ユーザーの許可をとり、`~/.zshrc` に以下が追加されます。

```zsh
term() { ~/.config/term/term.sh "$@" }
```

[install.sh](./install.sh) の実行が完了したのち、`source ~/.zshrc` を実行してください。

## Usage

| コマンド | 動作 |
| --- | --- |
| `term <プリセット名>` | プリセットの配置とコマンドで起動する |
| `term <分割数>` | 空のペインを指定した数だけ作る |
| `TERM_DRY_RUN=1 term <...>` | 実行せず、生成されるAppleScriptだけを表示する |

## How to write preset

`~/.config/term/presets/` に、プリセット名をそのままファイル名にしたファイルを作ります。1行が1ペインに対応し、その行がそのままそのペインで実行されるコマンドになります。

```sh
# ~/.config/term/presets/dev
cd ~/project && claude -w feature-a
cd ~/project && claude -w feature-b
cd ~/project && ls
```

サンプルは [`presets.example/`](./presets.example) を参照してください。`~/.config/term/presets/` にコピーして使用できます。

ペインは、必要な数だけ均等に再帰的二分割されます。奇数のときは、最初にできる側(左/上)が分割されない大きいペインになり、残りの側がさらに分割されます。

数字はプリセットファイルの行番号です。

```txt
N=2            N=3               N=4
┌─────┬─────┐ ┌─────┬─────┐    ┌─────┬─────┐
│     │     │ │     │  2  │    │  1  │  3  │
│  1  │  2  │ │  1  ├─────┤    ├─────┼─────┤
│     │     │ │     │  3  │    │  2  │  4  │
└─────┴─────┘ └─────┴─────┘    └─────┴─────┘
```

開発における詳しい経緯は、こちらのブログ記事にまとめています。

- [iTerm2のペイン配置と実行コマンドをセットでプリセット化する自作コマンドtermを作った](https://fantasma3rd.hatenablog.jp/entry/20260930/1790722800)

## License

[MIT](./LICENSE)
