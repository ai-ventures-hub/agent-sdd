#!/usr/bin/env bash
# Wrapper: just prints guidance for using presets packaged in this archive.
set -euo pipefail
echo "Presets are located under .agent-sdd/standards/theme-files/(minimal|classic|vibrant)/theme.css"
echo 'Add this to your globals.css:'
echo '@import "../../.agent-sdd/standards/theme-files/<preset>/theme.css";'
