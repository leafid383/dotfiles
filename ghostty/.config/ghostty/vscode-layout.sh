#!/bin/bash
# VSCode風レイアウトを新規ウィンドウで構築
# tmuxキーバインド (Prefix + V) から呼び出される

export PATH="/opt/homebrew/bin:$HOME/.cargo/bin:$PATH"

SESSION=$(tmux display-message -p '#S')
PANE_PATH=$(tmux display-message -p '#{pane_current_path}')

# ========================================
# Step 1: 新規ウィンドウ作成
# ========================================
tmux new-window -t "$SESSION" -c "$PANE_PATH"
WINDOW=$(tmux display-message -p '#I')
LEFT_TOP=$(tmux display-message -p '#{pane_id}')

# ========================================
# Step 2: VSCode風レイアウト展開
# ========================================
# 目標レイアウト:
# ┌──────────┬─────────────────────┐
# │ FileTree │  Editor/Claude Code │
# │          │                     │
# │──────────│─────────────────────│
# │  Keifu   │     Terminal        │
# │ (Git)    │                     │
# └──────────┴─────────────────────┘

# 左右分割（左30%, 右70%）
tmux split-window -h -l 70% -t "$LEFT_TOP" -c "$PANE_PATH"
RIGHT_TOP=$(tmux display-message -p -t "$SESSION:$WINDOW.{right}" '#{pane_id}')

# 右ペインを上下分割（上70%, 下30%）
tmux split-window -v -l 30% -t "$RIGHT_TOP" -c "$PANE_PATH"

# 左ペインを上下分割（上60%, 下40%）
tmux split-window -v -l 40% -t "$LEFT_TOP" -c "$PANE_PATH"
LEFT_BOTTOM=$(tmux display-message -p -t "$SESSION:$WINDOW.{bottom-left}" '#{pane_id}')

# ========================================
# Step 3: 各プログラム起動
# ========================================
# FileTree（左上）
if command -v ft &> /dev/null; then
    tmux send-keys -t "$LEFT_TOP" 'ft' C-m
fi

# Keifu（左下）
if command -v keifu &> /dev/null; then
    tmux send-keys -t "$LEFT_BOTTOM" 'keifu' C-m
fi

# Claude Code（右上）
tmux send-keys -t "$RIGHT_TOP" 'claude' C-m

# メイン作業領域（右上）にフォーカス
tmux select-pane -t "$RIGHT_TOP"
