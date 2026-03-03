#!/usr/bin/env bash

input=$(cat)

# ANSI colors
R=$'\033[0m'
DIM=$'\033[2m'
BOLD=$'\033[1m'
CYAN=$'\033[36m'
BCYAN=$'\033[96m'
YELLOW=$'\033[33m'
GREEN=$'\033[32m'
MAGENTA=$'\033[35m'
GRAY=$'\033[90m'
RED=$'\033[31m'

# Visible length: strip ANSI codes then count chars
vlen() {
  local s
  s=$(printf '%s' "$1" | sed $'s/\033\\[[0-9;]*[mK]//g')
  echo "${#s}"
}

# Extract fields
model=$(echo "$input" | jq -r '.model.id // "unknown"')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
input_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty')
output_tokens=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // empty')
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
transcript=$(echo "$input" | jq -r '.transcript_path // empty')

# Turn count
turns=0
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  turns=$(grep -c '"role"' "$transcript" 2>/dev/null || echo 0)
  turns=$(( turns / 2 ))
fi

# Color-coded progress bar (10 chars)
build_bar() {
  local pct=$1
  local filled=$(( pct * 10 / 100 ))
  [ $filled -gt 10 ] && filled=10
  local empty=$(( 10 - filled ))
  local bar_color="$GREEN"
  [ "$pct" -ge 70 ] && bar_color="$YELLOW"
  [ "$pct" -ge 90 ] && bar_color="$RED"
  local bar="${bar_color}"
  for i in $(seq 1 $filled); do bar="${bar}█"; done
  bar="${bar}${GRAY}"
  for i in $(seq 1 $empty); do bar="${bar}░"; done
  bar="${bar}${R}"
  printf '%s' "$bar"
}

fmt_tokens() {
  local n=$1
  if [ -z "$n" ] || [ "$n" = "null" ]; then printf ''; return; fi
  if [ "$n" -ge 1000 ] 2>/dev/null; then
    awk -v n="$n" 'BEGIN { printf "%.1fk", n/1000 }'
  else
    printf '%s' "$n"
  fi
}

# Context bar
ctx_str=""
if [ -n "$used_pct" ]; then
  pct_int=$(printf "%.0f" "$used_pct")
  bar=$(build_bar "$pct_int")
  pct_color="$GREEN"
  [ "$pct_int" -ge 70 ] && pct_color="$YELLOW"
  [ "$pct_int" -ge 90 ] && pct_color="$RED"
  ctx_str="${bar} ${pct_color}${pct_int}%${R}"
fi

# Token counts (plain for length, colored for display)
in_fmt=$(fmt_tokens "$input_tokens")
out_fmt=$(fmt_tokens "$output_tokens")
tok_str=""
tok_plain=""
if [ -n "$in_fmt" ] && [ -n "$out_fmt" ]; then
  tok_str="${GREEN}↑${in_fmt}${R} ${MAGENTA}↓${out_fmt}${R}"
  tok_plain="↑${in_fmt} ↓${out_fmt}"
fi

# Git info (raw data only; display strings built in footer with dynamic truncation)
branch=""
modified=0
if [ -n "$cwd" ]; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    modified=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  fi
fi

# Truncate cwd for footer
cwd_display="$cwd"
if [ ${#cwd_display} -gt 28 ]; then
  cwd_display="...${cwd_display: -25}"
fi

INNER=66

pad_line() {
  local content="$1"
  local vl=$(vlen "$content")
  local padding=$(( INNER - vl ))
  local padded="$content"
  for i in $(seq 1 $padding); do padded="${padded} "; done
  printf "${CYAN}│${R} %s ${CYAN}│${R}\n" "${padded}"
}

# Top border
printf "${CYAN}╭─ ${BOLD}${BCYAN}claude${R}${CYAN} "
printf '%0.s─' $(seq 1 $(( INNER - 7 )))
printf "╮${R}\n"

# Line 1: model (left) + context bar (right)
line1="${DIM}model${R} ${YELLOW}${model}${R}"
if [ -n "$ctx_str" ]; then
  right="${DIM}context${R} ${ctx_str}"
  gap=$(( INNER - $(vlen "$line1") - $(vlen "$right") ))
  spaces=""
  for i in $(seq 1 $gap); do spaces="${spaces} "; done
  pad_line "${line1}${spaces}${right}"
else
  pad_line "$line1"
fi

# Line 2: tokens (left) + turns (right)
line2=""
if [ -n "$tok_str" ]; then
  line2="$tok_str"
fi
if [ "$turns" -gt 0 ]; then
  turns_str="${DIM}turns${R} ${CYAN}${turns}${R}"
  turns_plain="turns ${turns}"
  if [ -n "$line2" ]; then
    gap=$(( INNER - ${#tok_plain} - ${#turns_plain} ))
    spaces=""
    for i in $(seq 1 $gap); do spaces="${spaces} "; done
    line2="${line2}${spaces}${turns_str}"
  else
    line2="$turns_str"
  fi
fi
if [ -n "$line2" ]; then
  pad_line "$line2"
fi

# Footer border with cwd and git
footer_left_plain=" ${cwd_display} "
footer_left_display="${DIM} ${cwd_display} ${R}"
footer_right_plain=""
footer_right_display=""
if [ -n "$branch" ]; then
  min_dashes=3
  available=$(( INNER + 1 - ${#footer_left_plain} - min_dashes ))
  # Format: " branch: <name><mod> " = 9 + branch_len + mod_len + 1
  mod_plain=""
  [ "$modified" -gt 0 ] && mod_plain=" ✎${modified}"
  max_branch_len=$(( available - 9 - ${#mod_plain} - 1 ))
  branch_display="$branch"
  if [ "${#branch_display}" -gt "$max_branch_len" ] && [ "$max_branch_len" -gt 3 ]; then
    branch_display="${branch_display:0:$(( max_branch_len - 3 ))}..."
  fi
  footer_right_plain=" branch: ${branch_display}${mod_plain} "
  footer_right_display=" ${DIM}branch:${R} ${GREEN}${branch_display}${R}"
  [ -n "$mod_plain" ] && footer_right_display="${footer_right_display}${YELLOW}${mod_plain}${R}"
  footer_right_display="${footer_right_display} "
fi

total_fill=$(( INNER - ${#footer_left_plain} - ${#footer_right_plain} + 1 ))
[ $total_fill -lt 0 ] && total_fill=0

printf "${CYAN}╰─${R}"
printf '%s' "$footer_left_display"
printf "${CYAN}"
printf '%0.s─' $(seq 1 $total_fill)
printf "${R}"
printf '%s' "$footer_right_display"
printf "${CYAN}╯${R}\n"
