#!/bin/bash
# Runs at session start. Installs npm dependencies in cloud sessions only.

if [ "$CLAUDE_CODE_REMOTE" != "true" ]; then
  exit 0
fi

if [ -f package.json ] && grep -qE '"(dependencies|devDependencies)"' package.json; then
  npm install
fi

exit 0
