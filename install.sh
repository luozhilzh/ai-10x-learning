#!/usr/bin/env bash
#
# AI 10x Learning Skill —— 一键安装脚本（跨工具通用）
#
# 支持的 AI 工具（用户级安装）：
#   workbuddy    ~/.workbuddy/skills/ai-10x-learning
#   claude       ~/.claude/skills/ai-10x-learning
#   codex        ~/.codex/skills/ai-10x-learning
#   cursor       ~/.cursor/skills/ai-10x-learning
#
# 用法：
#   ./install.sh                  # 安装到全部 4 款工具
#   ./install.sh --target claude  # 只装到 Claude Code
#   ./install.sh --project        # 装到当前目录的项目级 .workbuddy/skills/
#   ./install.sh --help           # 查看帮助
#
# Windows 用户：请用 Git Bash 运行（不要直接双击 .sh）。
#
set -euo pipefail

SKILL_NAME="ai-10x-learning"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 兼容 Windows Git Bash 的 HOME
HOME_DIR="${HOME:-$USERPROFILE}"

usage() {
  cat <<'EOF'
用法: ./install.sh [选项]

选项:
  --target <工具>   只安装到指定工具: workbuddy | claude | codex | cursor
  --project         安装到当前目录的项目级 skills/（自动选 WorkBuddy 目录）
  --all             安装到全部 4 款工具（默认）
  --help, -h        显示本帮助

示例:
  ./install.sh
  ./install.sh --target claude
  ./install.sh --project
EOF
}

TARGET="all"
PROJECT_MODE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target) TARGET="${2:-all}"; shift 2 ;;
    --project) PROJECT_MODE=1; shift ;;
    --all) TARGET="all"; shift ;;
    --help|-h) usage; exit 0 ;;
    *) echo "未知参数: $1" >&2; usage; exit 1 ;;
  esac
done

# 返回某工具的“用户级”目标目录
user_target_dir() {
  case "$1" in
    workbuddy) echo "$HOME_DIR/.workbuddy/skills/$SKILL_NAME" ;;
    claude)    echo "$HOME_DIR/.claude/skills/$SKILL_NAME" ;;
    codex)     echo "$HOME_DIR/.codex/skills/$SKILL_NAME" ;;
    cursor)    echo "$HOME_DIR/.cursor/skills/$SKILL_NAME" ;;
    *) echo "未知工具: $1" >&2; exit 1 ;;
  esac
}

install_to() {
  local dest="$1"
  mkdir -p "$dest"
  # 从脚本所在目录复制，排除 .git（安装位置不需要 git 元数据）
  (cd "$SCRIPT_DIR" && tar cf - --exclude='.git' . | (cd "$dest" && tar xf -))
  echo "  ✓ $dest"
}

echo "AI 10x 学习法 skill —— 安装中…"
echo "  源目录: $SCRIPT_DIR"

if [[ "$PROJECT_MODE" -eq 1 ]]; then
  DEST="$(pwd)/.workbuddy/skills/$SKILL_NAME"
  install_to "$DEST"
  echo ""
  echo "完成：已安装到项目级 $DEST（仅当前项目生效）。"
  exit 0
fi

if [[ "$TARGET" == "all" ]]; then
  for t in workbuddy claude codex cursor; do
    install_to "$(user_target_dir "$t")"
  done
else
  install_to "$(user_target_dir "$TARGET")"
fi

echo ""
echo "完成。在对应工具的新会话中输入 /$SKILL_NAME 即可调用。"
echo "（若工具正在运行，重启会话后才会识别该 skill。）"
