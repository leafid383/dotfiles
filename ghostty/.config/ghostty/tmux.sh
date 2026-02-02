#!/bin/bash
# Tmux auto-start script for Ghostty
# VSCode-like 4-pane layout with FileTree, Keifu, Editor, Terminal

# Homebrewのパスを追加（--noprofile --norcで起動されるため必要）
export PATH="/opt/homebrew/bin:$HOME/.cargo/bin:$PATH"

SESSION_NAME="main"

# 既存セッションがあれば接続
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    tmux attach-session -t $SESSION_NAME
    exit 0
fi

# ========================================
# 新規セッション: VSCode風レイアウト構築
# ========================================
# 目標レイアウト:
# ┌──────────┬─────────────────────┐
# │ FileTree │  Claude Code/Editor │
# │          │                     │
# │──────────│─────────────────────│
# │  Keifu   │     Terminal        │
# │ (Git)    │                     │
# └──────────┴─────────────────────┘

# セッション作成（左上ペイン）
tmux new-session -d -s $SESSION_NAME -x "$(tput cols)" -y "$(tput lines)"
LEFT_TOP=$(tmux display-message -p -t $SESSION_NAME '#{pane_id}')

# 左右分割（左30%, 右70%）
tmux split-window -h -l 70% -t "$LEFT_TOP"
RIGHT_TOP=$(tmux display-message -p -t $SESSION_NAME:1.{right} '#{pane_id}')

# 右ペインを上下分割（上70%, 下30%）
tmux split-window -v -l 30% -t "$RIGHT_TOP"

# 左ペインを上下分割（上60%, 下40%）
tmux split-window -v -l 40% -t "$LEFT_TOP"
LEFT_BOTTOM=$(tmux display-message -p -t $SESSION_NAME:1.{bottom-left} '#{pane_id}')

# FileTree起動（左上）
if command -v ft &> /dev/null; then
    tmux send-keys -t "$LEFT_TOP" 'ft' C-m
fi

# Keifu起動（左下）
if command -v keifu &> /dev/null; then
    tmux send-keys -t "$LEFT_BOTTOM" 'keifu' C-m
fi

# Claude Code起動（右上）
tmux send-keys -t "$RIGHT_TOP" 'claude' C-m

# 右上ペイン（メイン作業領域）にフォーカス
tmux select-pane -t "$RIGHT_TOP"

# セッションに接続
tmux attach-session -t $SESSION_NAME
