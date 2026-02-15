#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGES=(git bash alacritty zellij fish gh mise spotify-player starship nvim)
FISH_PATH="/opt/homebrew/bin/fish"

# --- Install Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- Install packages from Brewfile ---
echo "Running brew bundle..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# --- Backup conflicting files and stow packages ---
backup_if_exists() {
  local target="$1"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup="${target}.backup.$(date +%s)"
    echo "Backing up $target -> $backup"
    mv "$target" "$backup"
  fi
}

for pkg in "${PACKAGES[@]}"; do
  echo "Stowing $pkg..."

  # Find all files in the package and backup any conflicting non-symlink files
  while IFS= read -r -d '' file; do
    # Get the relative path from the package directory
    rel="${file#"$DOTFILES_DIR/$pkg/"}"
    target="$HOME/$rel"
    backup_if_exists "$target"
  done < <(find "$DOTFILES_DIR/$pkg" -type f -print0)

  stow -t "$HOME" -d "$DOTFILES_DIR" "$pkg"
done

# --- Set fish as default shell ---
if [ -x "$FISH_PATH" ]; then
  if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "Adding fish to /etc/shells (requires sudo)..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  if [ "$SHELL" != "$FISH_PATH" ]; then
    echo "Setting fish as default shell..."
    chsh -s "$FISH_PATH"
  fi
fi

echo "Done! All configs are stowed."
