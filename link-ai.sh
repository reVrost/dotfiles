#!/bin/bash

# This script is used to link the AI related things

mkdir -p "$HOME/.claude"
ln -s $(pwd)/commands "$HOME/.claude/commands"

mkdir -p "$HOME/.config/crush"
ln -s $(pwd)/commands "$HOME/.config/crush/commands"
