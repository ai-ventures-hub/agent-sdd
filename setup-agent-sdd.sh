#!/bin/bash

# Agent-SDD Smart Setup Script
# Fresh install OR smart update that preserves user customizations

set -e

echo "🚀 Agent-SDD Setup & Update"
echo "=============================="
echo ""

# Define files that should NEVER be overwritten during updates (user customizations)
PRESERVE_FILES=(
  ".agent-sdd/standards/tech-stack.md"
  ".agent-sdd/standards/theme-standards.md"
  ".agent-sdd/product/overview.md"
  ".agent-sdd/product/roadmap.md"
  ".agent-sdd/product/decisions.md"
)

# Define system files that should ALWAYS be updated
SYSTEM_FILES=(
  ".agent-sdd/standards/task-schema.md"
  ".agent-sdd/standards/code-style.md"
  ".agent-sdd/standards/best-practices.md"
)

# Check if this is a fresh install or update
if [ ! -d ".agent-sdd" ]; then
  echo "📦 Fresh install detected - downloading Agent-SDD..."
  
  # Download from GitHub
  TEMP_DIR=$(mktemp -d)
  curl -L -o "$TEMP_DIR/agent-sdd.zip" https://github.com/ai-ventures-hub/agent-sdd/archive/refs/heads/main.zip
  
  # Extract
  unzip -q "$TEMP_DIR/agent-sdd.zip" -d "$TEMP_DIR"
  
  # Copy entire .agent-sdd directory
  cp -r "$TEMP_DIR/agent-sdd-main/.agent-sdd" .
  
  # Cleanup
  rm -rf "$TEMP_DIR"
  
  echo "✅ Fresh install complete!"
else
  echo "🔄 Existing installation detected - smart update mode..."
  echo "   (Your customizations will be preserved)"
  
  # Download to temp directory
  TEMP_DIR=$(mktemp -d)
  curl -L -o "$TEMP_DIR/agent-sdd.zip" https://github.com/ai-ventures-hub/agent-sdd/archive/refs/heads/main.zip
  
  # Extract
  unzip -q "$TEMP_DIR/agent-sdd.zip" -d "$TEMP_DIR"
  
  # Update system directories (always safe to update)
  echo "📥 Updating system files..."
  
  # Update instructions (always safe)
  if [ -d "$TEMP_DIR/agent-sdd-main/.agent-sdd/instructions" ]; then
    cp -r "$TEMP_DIR/agent-sdd-main/.agent-sdd/instructions" ".agent-sdd/"
    echo "   ✅ Updated instructions"
  fi
  
  # Update agents (always safe)
  if [ -d "$TEMP_DIR/agent-sdd-main/.agent-sdd/agents" ]; then
    cp -r "$TEMP_DIR/agent-sdd-main/.agent-sdd/agents" ".agent-sdd/"
    echo "   ✅ Updated agents"
  fi
  
  # Update specific system standards files
  for file in "${SYSTEM_FILES[@]}"; do
    if [ -f "$TEMP_DIR/agent-sdd-main/$file" ]; then
      cp "$TEMP_DIR/agent-sdd-main/$file" "$file"
      echo "   ✅ Updated $(basename $file)"
    fi
  done
  
  # Add any NEW files that don't exist (but never overwrite)
  for file in "$TEMP_DIR/agent-sdd-main/.agent-sdd/standards/"*.md; do
    basename=$(basename "$file")
    if [ ! -f ".agent-sdd/standards/$basename" ]; then
      cp "$file" ".agent-sdd/standards/"
      echo "   + Added new file: standards/$basename"
    fi
  done
  
  # Cleanup
  rm -rf "$TEMP_DIR"
  
  echo ""
  echo "📋 Preserved your customizations in:"
  for file in "${PRESERVE_FILES[@]}"; do
    if [ -f "$file" ]; then
      echo "   ✅ $file"
    fi
  done
  
  # Also preserve specs directory
  if [ -d ".agent-sdd/specs" ] && [ "$(ls -A .agent-sdd/specs)" ]; then
    echo "   ✅ .agent-sdd/specs/ (all spec files)"
  fi
fi

# Create necessary directories if they don't exist
echo "📁 Creating directories (if needed)..."
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

# Validate installation
echo ""
echo "🔍 Validating installation..."
VALID=true

# Check critical directories
if [ ! -d ".agent-sdd/instructions" ]; then
  echo "   ❌ Missing: .agent-sdd/instructions/"
  VALID=false
fi

if [ ! -d ".agent-sdd/agents" ]; then
  echo "   ❌ Missing: .agent-sdd/agents/"
  VALID=false
fi

if [ ! -d ".agent-sdd/standards" ]; then
  echo "   ❌ Missing: .agent-sdd/standards/"
  VALID=false
fi

# Check critical files
if [ ! -f ".agent-sdd/standards/task-schema.md" ]; then
  echo "   ❌ Missing: task-schema.md"
  VALID=false
fi

if [ "$VALID" = true ]; then
  echo "   ✅ All critical files present"
fi

echo ""
echo "✅ Agent-SDD setup complete!"
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

# Different messages for fresh install vs update
if [ ! -d ".agent-sdd" ]; then
  echo "💡 Next steps (fresh install):"
  echo "   1. Customize files marked with ✅ in .agent-sdd/update-guide.md"
  echo "   2. Update .agent-sdd/standards/theme-standards.md with your design system"
  echo "   3. Use /sdd-plan-product to define your project goals"
else
  echo "💡 What's new:"
  echo "   • System files updated to latest version"
  echo "   • Your customizations preserved"
  echo "   • Check .agent-sdd/update-guide.md for any new features"
fi

echo ""
echo "🔄 Run this script anytime to:"
echo "   • Update system files to latest version"
echo "   • Preserve your customizations"
echo "   • Refresh Claude commands"