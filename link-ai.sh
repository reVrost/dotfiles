#!/bin/bash

# This script is used to link the AI related things

mkdir -p "$HOME/.claude"
ln -sfn $(pwd)/commands "$HOME/.claude/commands"
ln -sfn $(pwd)/skills "$HOME/.claude/skills"

mkdir -p "$HOME/.config/crush"
ln -sfn $(pwd)/commands "$HOME/.config/crush/commands"
ln -sfn $(pwd)/skills "$HOME/.config/crush/skills"

mkdir -p "$HOME/.codex"
ln -sfn $(pwd)/codex/config.toml "$HOME/.codex/config.toml"
