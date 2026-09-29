#!/usr/bin/env bash
# install.sh — install term into ~/.config/term/
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$HOME/.config/term"
ZSHRC="$HOME/.zshrc"
TERM_FUNC='term() { ~/.config/term/term.sh "$@" }'

mkdir -p "$INSTALL_DIR/presets"
cp "$SCRIPT_DIR/bin/term" "$INSTALL_DIR/term.sh"
chmod +x "$INSTALL_DIR/term.sh"

echo "Installed: $INSTALL_DIR/term.sh"
echo "Presets directory ready: $INSTALL_DIR/presets/"
echo "  (see $SCRIPT_DIR/presets.example/ for sample presets to copy in)"
echo

if [ -f "$ZSHRC" ] && grep -qF '~/.config/term/term.sh' "$ZSHRC"; then
  echo "$ZSHRC already defines term() — leaving it as-is."
else
  read -r -p "Add 'term() { ... }' to $ZSHRC now? [y/N] " reply
  case "$reply" in
    [yY]|[yY][eE][sS])
      {
        echo ""
        echo "# term — added by iterm-term/install.sh"
        echo "$TERM_FUNC"
      } >> "$ZSHRC"
      echo "Added to $ZSHRC. Run: source ~/.zshrc"
      ;;
    *)
      echo "Skipped. Add this to your ~/.zshrc manually, then run: source ~/.zshrc"
      echo
      echo "  $TERM_FUNC"
      ;;
  esac
fi