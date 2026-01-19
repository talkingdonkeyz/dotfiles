#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

echo "Linking config folders from $DOTFILES_DIR to $CONFIG_DIR..."

# ensure ~/.config exists
mkdir -p "$CONFIG_DIR"

# loop over all directories inside dotfiles (assumes structure matches ~/.config)
for dir in "$DOTFILES_DIR"/*/; do
  name=$(basename "$dir")
  target="$CONFIG_DIR/$name"

  # skip if it's not a directory
  [ ! -d "$dir" ] && continue

  # backup existing config if present
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up existing $target to $target.backup"
    mv "$target" "$target.backup"
  fi

  # create symlink
  ln -snf "$dir" "$target"
  echo "Linked $target → $dir"
done

# Install TPM if not present
if [ ! -d "$CONFIG_DIR/tmux/plugins/tpm" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$CONFIG_DIR/tmux/plugins/tpm"
fi

echo "✅ All config folders linked!"
