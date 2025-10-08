#!/bin/bash

# Agent-SDD Platform Switching Script
# Usage: ./switch-platform.sh [current] [target]
# Example: ./switch-platform.sh claude grok

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Validate arguments
if [ $# -ne 2 ]; then
    print_error "Usage: $0 [current] [target]"
    print_error "Example: $0 claude grok"
    print_error "Supported platforms: claude, grok, codex"
    exit 1
fi

CURRENT_PLATFORM=$(echo "$1" | tr '[:upper:]' '[:lower:]')
TARGET_PLATFORM=$(echo "$2" | tr '[:upper:]' '[:lower:]')

# Validate platform names
VALID_PLATFORMS=("claude" "grok" "codex")
if [[ ! " ${VALID_PLATFORMS[@]} " =~ " ${CURRENT_PLATFORM} " ]]; then
    print_error "Invalid current platform: $CURRENT_PLATFORM"
    print_error "Supported platforms: ${VALID_PLATFORMS[*]}"
    exit 1
fi

if [[ ! " ${VALID_PLATFORMS[@]} " =~ " ${TARGET_PLATFORM} " ]]; then
    print_error "Invalid target platform: $TARGET_PLATFORM"
    print_error "Supported platforms: ${VALID_PLATFORMS[*]}"
    exit 1
fi

if [ "$CURRENT_PLATFORM" = "$TARGET_PLATFORM" ]; then
    print_warning "Current and target platforms are the same. Nothing to do."
    exit 0
fi

print_status "Switching from $CURRENT_PLATFORM to $TARGET_PLATFORM"

# Check if current platform directory exists
if [ ! -d ".$CURRENT_PLATFORM" ]; then
    print_error "Current platform directory .$CURRENT_PLATFORM does not exist"
    exit 1
fi

# Check if target platform directory already exists
if [ -d ".$TARGET_PLATFORM" ]; then
    print_warning "Target platform directory .$TARGET_PLATFORM already exists"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Operation cancelled"
        exit 0
    fi
    print_warning "Removing existing .$TARGET_PLATFORM directory"
    rm -rf ".$TARGET_PLATFORM"
fi

# Step 1: Rename framework directory
print_step "Renaming framework directory: .$CURRENT_PLATFORM → .$TARGET_PLATFORM"
if ! mv ".$CURRENT_PLATFORM" ".$TARGET_PLATFORM"; then
    print_error "Failed to rename framework directory"
    exit 1
fi

# Step 2: Update .sddrc file
print_step "Updating .sddrc configuration"
if [ ! -f ".sddrc" ]; then
    print_error ".sddrc file not found"
    exit 1
fi

# Create backup
cp .sddrc .sddrc.backup

if ! sed -i.bak "s/FRAMEWORK=$CURRENT_PLATFORM/FRAMEWORK=$TARGET_PLATFORM/" .sddrc; then
    print_error "Failed to update .sddrc file"
    # Restore backup
    mv .sddrc.backup .sddrc
    exit 1
fi

# Clean up backup
rm .sddrc.bak

# Step 3: Rename instruction file
CURRENT_INSTRUCTION_FILE="$(echo $CURRENT_PLATFORM | tr '[:lower:]' '[:upper:]').md"
TARGET_INSTRUCTION_FILE="$(echo $TARGET_PLATFORM | tr '[:lower:]' '[:upper:]').md"

print_step "Renaming instruction file: $CURRENT_INSTRUCTION_FILE → $TARGET_INSTRUCTION_FILE"

if [ -f "$CURRENT_INSTRUCTION_FILE" ]; then
    if ! mv "$CURRENT_INSTRUCTION_FILE" "$TARGET_INSTRUCTION_FILE"; then
        print_error "Failed to rename instruction file"
        exit 1
    fi
else
    print_warning "Instruction file $CURRENT_INSTRUCTION_FILE not found. This is normal for new installations."
fi

# Step 4: Update platform variables in config
print_step "Updating platform variables in configuration"
if [ -f ".$TARGET_PLATFORM/config/variables.yml" ]; then
    # Update the top-level platform variables
    sed -i.bak "s/name: \"claude\"/name: \"$TARGET_PLATFORM\"/" ".$TARGET_PLATFORM/config/variables.yml"
    sed -i.bak "s/command_prefix: \"\/\"/command_prefix: \"@${TARGET_PLATFORM:0:1}\"/" ".$TARGET_PLATFORM/config/variables.yml"
    rm ".$TARGET_PLATFORM/config/variables.yml.bak"
fi

# Step 5: Validate the switch
print_step "Validating platform switch"

# Check if .sddrc was updated correctly
if ! grep -q "FRAMEWORK=$TARGET_PLATFORM" .sddrc; then
    print_error ".sddrc was not updated correctly"
    exit 1
fi

# Check if framework directory exists
if [ ! -d ".$TARGET_PLATFORM" ]; then
    print_error "Framework directory .$TARGET_PLATFORM was not created"
    exit 1
fi

print_status "✅ Platform switch completed successfully!"
echo
print_status "Summary of changes:"
echo "  • Directory: .$CURRENT_PLATFORM → .$TARGET_PLATFORM"
echo "  • Config: FRAMEWORK=$TARGET_PLATFORM"
echo "  • Instruction: $CURRENT_INSTRUCTION_FILE → $TARGET_INSTRUCTION_FILE"
echo
print_status "Next steps:"
echo "  1. Start a new chat session with your AI assistant"
if [ "$TARGET_PLATFORM" = "claude" ]; then
    echo "  2. Claude will automatically detect CLAUDE.md"
elif [ "$TARGET_PLATFORM" = "grok" ]; then
    echo "  2. Use @sdd-task commands (Grok prefix)"
elif [ "$TARGET_PLATFORM" = "codex" ]; then
    echo "  2. Use #sdd-task commands (Codex prefix)"
fi
echo "  3. Run /sdd-task --validate_system to verify the switch"
echo
print_status "Backup created: .sddrc.backup"
