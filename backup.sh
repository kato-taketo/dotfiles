#!/bin/bash -e

# Backup script for dotfiles installation
# This script backs up your current configuration files before they get replaced by symlinks

TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
BACKUP_DIR="$HOME/dotfiles_backup_$TIMESTAMP"

echo "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Files that will be symlinked to $HOME/
FILES_TO_BACKUP=(
  ".gitconfig"
  ".gitignore_global"
  ".p10k.zsh"
  ".tigrc"
  ".tmux.conf"
  ".zshenv"
  ".asdfrc"
)

# Directories that will be symlinked to $HOME/
DIRS_TO_BACKUP=(
  ".git_template"
  ".hammerspoon"
)

# Directories that will be symlinked to $HOME/.config/
CONFIG_DIRS_TO_BACKUP=(
  ".config/gh"
  ".config/karabiner"
  ".config/nvim"
)

# Files that will be symlinked to $HOME/.claude/
CLAUDE_FILES_TO_BACKUP=(
  ".claude/CLAUDE.md"
  ".claude/settings.json"
)

# Directories that will be symlinked to $HOME/.claude/
CLAUDE_DIRS_TO_BACKUP=(
  ".claude/commands"
)

# VSCode settings files (macOS only)
VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
VSCODE_FILES_TO_BACKUP=(
  "settings.json"
  "keybindings.json"
)

backup_file() {
  local source_path="$1"
  local relative_path="$2"
  
  if [ -e "$source_path" ]; then
    local backup_path="$BACKUP_DIR/$relative_path"
    local backup_dir=$(dirname "$backup_path")
    
    mkdir -p "$backup_dir"
    cp -r "$source_path" "$backup_path"
    echo "✓ Backed up: $relative_path"
  else
    echo "- Not found: $relative_path"
  fi
}

echo "Backing up configuration files..."
echo "=================================="

# Backup files in $HOME/
for file in "${FILES_TO_BACKUP[@]}"; do
  backup_file "$HOME/$file" "$file"
done

# Backup directories in $HOME/
for dir in "${DIRS_TO_BACKUP[@]}"; do
  backup_file "$HOME/$dir" "$dir"
done

# Backup directories in $HOME/.config/
for config_dir in "${CONFIG_DIRS_TO_BACKUP[@]}"; do
  backup_file "$HOME/$config_dir" "$config_dir"
done

# Backup Claude files
for claude_file in "${CLAUDE_FILES_TO_BACKUP[@]}"; do
  backup_file "$HOME/$claude_file" "$claude_file"
done

# Backup Claude directories
for claude_dir in "${CLAUDE_DIRS_TO_BACKUP[@]}"; do
  backup_file "$HOME/$claude_dir" "$claude_dir"
done

# Backup VSCode settings (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo ""
  echo "Backing up VSCode settings..."
  for vscode_file in "${VSCODE_FILES_TO_BACKUP[@]}"; do
    backup_file "$VSCODE_SETTINGS_DIR/$vscode_file" "vscode/$vscode_file"
  done
fi

echo ""
echo "=================================="
echo "✓ Backup completed!"
echo "Your files are backed up in: $BACKUP_DIR"
echo ""
echo "To restore your files later, you can:"
echo "  cp -r $BACKUP_DIR/.* ~/"
echo "  cp -r $BACKUP_DIR/.config/* ~/.config/"
echo "  cp -r $BACKUP_DIR/.claude/* ~/.claude/"
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "  cp -r $BACKUP_DIR/vscode/* '$VSCODE_SETTINGS_DIR/'"
fi
echo ""