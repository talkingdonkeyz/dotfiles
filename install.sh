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

echo "✅ All config folders linked!"
