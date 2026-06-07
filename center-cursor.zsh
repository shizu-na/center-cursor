# -------------------------------------------------------------------
# Center Cursor (Zsh)
# -------------------------------------------------------------------

# 1. 関数の定義
center-clear() {
    # 外部コマンドによる画面変更をZLE(Zsh Line Editor)へ通知し、表示崩れを防ぐ
    zle -I

    # ターミナルを物理的にクリア
    clear

    local half=$(( ${LINES:-24} / 2 ))

    # プロンプト再描画時の座標ズレを防ぐため、絶対座標指定（tput cup）は使用せず
    # Zsh組み込みのrepeatによる改行出力で物理的にカーソルを押し下げる
    repeat $half echo ""

    # 移動後のカーソル位置（画面中央）にプロンプトを再描画して入力を継続させる
    zle reset-prompt
}

center-push() {
    zle -I

    local half=$(( ${LINES:-24} / 2 ))

    # 画面の半分だけ改行を出力し、既存の表示内容を上に押し上げる
    repeat $half echo ""
    
    # tputコマンドでカーソルを出力分だけ上へ戻す
    # TERM=dumb などterminfoが存在しない環境でのエラー出力を破棄して正常終了させる
    tput cuu $half 2>/dev/null || true

    # 移動後のカーソル位置にプロンプトを再描画
    zle reset-prompt
}

# 2. Zshのウィジェットとして登録
zle -N center-clear
zle -N center-push

# 3. キーバインドの割り当て
# Ctrl + L: 画面をクリアして中央へ配置
bindkey '^L' center-clear
# Ctrl + G: 現在の行を中央へ押し上げる
bindkey '^G' center-push
