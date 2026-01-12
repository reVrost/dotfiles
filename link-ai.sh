#!/bin/bash

# This script is used to link the AI related things

mkdir -p "$HOME/.claude"
ln -sf "$HOME/dotfiles/ai/commands" "$HOME/.claude/commands"

mkdir -p "$HOME/.config/crush"
ln -sf "$HOME/dotfiles/ai/commands" "$HOME/.config/crush/commands"
