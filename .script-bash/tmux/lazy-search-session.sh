#!/usr/bin/env bash
tmux_sessions=$(tmux list-sessions -F "#{session_name}")

tmux_switch_to_session() {
  session="$1"
  if [[ $tmux_sessions = *"$session"* ]]; then
    tmux switch-client -t "$session"
  fi
}

choice=$(sort -rfu <<<"$tmux_sessions" |
  fzf |
  tr -d '\n')
tmux_switch_to_session "$choice"
