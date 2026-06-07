# -------------------------------------------------------------------
# Center Cursor (Bash)
# -------------------------------------------------------------------

# 1. 関数の定義
center-clear() {
    # ターミナルをクリア
    clear

    # ウィンドウサイズを再取得して $LINES 変数を更新
    shopt -s checkwinsize

    local half=$(( ${LINES:-24} / 2 ))

    if (( half > 0 )); then
        # プロンプト再描画時の座標ズレを防ぐため、絶対座標指定（tput cup）は使用せず
        # Bash組み込みのforループによる改行出力で物理的にカーソルを押し下げる
        for ((i=0; i<half; i++)); do
            echo ""
        done
    fi
}

center-push() {
    shopt -s checkwinsize

    local half=$(( ${LINES:-24} / 2 ))

    if (( half > 0 )); then
        # 画面の半分だけ改行を出力し、既存の表示内容を上に押し上げる
        for ((i=0; i<half; i++)); do
            echo ""
        done
        
        # tputコマンドでカーソルを出力分だけ上へ戻す
        # TERM=dumb などterminfoが存在しない環境でのエラー出力を破棄して正常終了させる
        tput cuu "$half" 2>/dev/null || true
    fi
}

# 2. キーバインドの割り当て
# Ctrl + L: 画面をクリアして中央へ配置
bind -x '"\C-l": "center-clear"'
# Ctrl + G: 現在の行を中央へ押し上げる
bind -x '"\C-g": "center-push"'
