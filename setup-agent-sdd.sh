#!/bin/bash

# Agent-SDD Minimal Setup Script
# Activates Agent-SDD commands in Claude Code without overwriting files

set -e

echo "🚀 Agent-SDD Command Activation"
echo "=============================="
echo ""

# Check if .agent-sdd exists
if [ ! -d ".agent-sdd" ]; then
  echo "❌ .agent-sdd directory not found!"
  echo "💡 Make sure you have the complete .agent-sdd folder in your project."
  echo "   You can copy it from the Agent-SDD repository."
  exit 1
fi

# Create necessary directories if they don't exist
echo "📁 Creating directories (if needed)..."
mkdir -p .agent-sdd/specs
mkdir -p .agent-sdd/standards
echo "✅ Directories ready"

# Copy instructions and agents to Claude
echo "📥 Activating Claude Code commands..."
mkdir -p ~/.claude/commands

# Check if instruction files exist
if [ -d ".agent-sdd/instructions" ] && [ "$(ls -A .agent-sdd/instructions)" ]; then
  cp .agent-sdd/instructions/*.md ~/.claude/commands/
  echo "✅ Copied $(ls .agent-sdd/instructions/*.md | wc -l | tr -d ' ') instruction files"
else
  echo "⚠️  No instruction files found in .agent-sdd/instructions/"
fi

# Check if agent files exist
if [ -d ".agent-sdd/agents" ] && [ "$(ls -A .agent-sdd/agents)" ]; then
  cp .agent-sdd/agents/*.md ~/.claude/commands/
  echo "✅ Copied $(ls .agent-sdd/agents/*.md | wc -l | tr -d ' ') agent files"
else
  echo "⚠️  No agent files found in .agent-sdd/agents/"
fi

# Note: All functionality now handled by Claude Code commands (no external scripts needed)

echo ""
echo "✅ Agent-SDD activation complete!"
echo ""
echo "📍 Available commands in Claude Code:"
echo "   /sdd-plan-product"
echo "   /sdd-next-phase"
echo "   /sdd-create-spec [--lite | --ui-only]"
echo "   /sdd-execute-task [--fix-style]" 
echo "   /sdd-vibe-task"
echo "   /sdd-review-code"
echo "   /sdd-analyze"
echo "   /sdd-check-task"
echo "   /sdd-update"
echo ""
echo "💡 Next steps:"
echo "   1. Customize files marked with ✅ in .agent-sdd/update-guide.md"
echo "   2. Update .agent-sdd/standards/theme-standards.md with your design system"
echo "   3. Use /sdd-plan-product to define your project goals"
echo ""
echo "🔄 Run this script anytime to refresh Claude commands"