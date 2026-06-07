# Center Cursor

ターミナルのプロンプト（カーソル位置）を画面中央に配置するシェルスクリプトです。ZshおよびBashに対応しています。

## 機能

* `center-clear` (デフォルト: `Ctrl + L`): 画面をクリアし、プロンプトを画面中央に配置します。
* `center-push` (デフォルト: `Ctrl + G`): 現在の画面出力を保持したまま、プロンプトを画面中央へ移動させます。

## 対応環境

* Zsh
* Bash
* `tput` コマンドが利用可能な環境

## インストールと設定

任意のディレクトリにスクリプトを配置し、お使いのシェルの設定ファイル（`.zshrc` または `.bashrc`）で読み込んでください。

### Zshの場合

1. スクリプトをダウンロードします。

```sh
curl -O https://raw.githubusercontent.com/shizu-na/center-cursor/main/center-cursor.zsh

```

2. `.zshrc` に追記します。

```sh
source /path/to/center-cursor.zsh

```

### Bashの場合

1. スクリプトをダウンロードします。

```sh
curl -O https://raw.githubusercontent.com/shizu-na/center-cursor/main/center-cursor.bash

```

2. `.bashrc` に追記します。

```sh
# ウィンドウサイズの動的取得を有効化（推奨）
shopt -s checkwinsize
source /path/to/center-cursor.bash

```

## カスタマイズ

キーバインドは、デフォルトで `Ctrl + L` と `Ctrl + G` に割り当てられています。変更する場合は、ダウンロードしたスクリプト内の `bindkey` (Zsh) または `bind` (Bash) の設定箇所を直接編集してください。

## 既知の制限事項

本スクリプトの仕様として、以下の挙動が存在します。

* **Bash環境での複数行プロンプトの再描画**
Bash環境で複数行のプロンプトを使用している場合、本スクリプトを実行すると最下行のみが再描画され、上部の行が表示されない場合があります。これはBash（`bind -x` および Readline）の仕様によるものです。入力中の文字列やコマンドの実行自体に影響はありません。
* **画面上部での `center-push` の実行**
プロンプトが画面上部にある状態で `center-push` を実行すると、カーソルより下にある既存の出力履歴が空白行で上書きされます。本コマンドは、プロンプトが画面下部にある状態での使用を前提としています。
* **一部環境での `tput` の動作**
`TERM` 環境変数が適切に設定されていない環境などでは `tput` コマンドが機能せず、`center-push` 実行後にカーソルが中央に戻らない場合があります。なお、エラー出力は内部で破棄されるため、画面表示が崩れることはありません。

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
