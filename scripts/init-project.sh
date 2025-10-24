#!/bin/bash
# Smart project initialization script
# Detects project language and applies appropriate Claude Code configuration

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$(dirname "$SCRIPT_DIR")"
TARGET_DIR="${1:-.}"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Claude Code Smart Initialization${NC}"
echo ""

# Function to detect project language
detect_language() {
  local dir="$1"

  # TypeScript/JavaScript
  if [[ -f "$dir/package.json" ]]; then
    if grep -q "typescript" "$dir/package.json" 2>/dev/null; then
      echo "typescript"
    else
      echo "javascript"
    fi
    return
  fi

  # Python
  if [[ -f "$dir/pyproject.toml" ]] || [[ -f "$dir/requirements.txt" ]] || [[ -f "$dir/setup.py" ]]; then
    echo "python"
    return
  fi

  # Go
  if [[ -f "$dir/go.mod" ]]; then
    echo "go"
    return
  fi

  # Rust
  if [[ -f "$dir/Cargo.toml" ]]; then
    echo "rust"
    return
  fi

  # Java
  if [[ -f "$dir/pom.xml" ]] || [[ -f "$dir/build.gradle" ]] || [[ -f "$dir/build.gradle.kts" ]]; then
    echo "java"
    return
  fi

  # Elixir
  if [[ -f "$dir/mix.exs" ]]; then
    echo "elixir"
    return
  fi

  # Erlang
  if [[ -f "$dir/rebar.config" ]]; then
    echo "erlang"
    return
  fi

  echo "unknown"
}

# Detect language
DETECTED_LANG=$(detect_language "$TARGET_DIR")

echo -e "${BLUE}📊 Detection Results:${NC}"
echo -e "  Target directory: ${GREEN}$TARGET_DIR${NC}"
echo -e "  Detected language: ${GREEN}$DETECTED_LANG${NC}"
echo ""

# Ask for confirmation or manual override
if [[ "$DETECTED_LANG" == "unknown" ]]; then
  echo -e "${YELLOW}⚠️  Could not auto-detect project language${NC}"
  echo "Please specify language manually: typescript, python, go, rust, java, elixir, erlang"
  read -p "Language: " MANUAL_LANG
  DETECTED_LANG="$MANUAL_LANG"
fi

# Create .claude directory
echo -e "${BLUE}📁 Creating .claude directory...${NC}"
mkdir -p "$TARGET_DIR/.claude"

# Copy core configuration
echo -e "${BLUE}🔧 Installing core configuration...${NC}"
cp -r "$TEMPLATES_DIR/core/agents" "$TARGET_DIR/.claude/"
cp -r "$TEMPLATES_DIR/core/commands" "$TARGET_DIR/.claude/"
mkdir -p "$TARGET_DIR/.claude/hooks"
cp "$TEMPLATES_DIR/core/hooks"/*.sh "$TARGET_DIR/.claude/hooks/"

# Apply language-specific configuration
if [[ "$DETECTED_LANG" != "unknown" ]] && [[ -d "$TEMPLATES_DIR/languages/$DETECTED_LANG" ]]; then
  echo -e "${BLUE}🎯 Applying $DETECTED_LANG-specific configuration...${NC}"

  # Merge language-specific agents
  if [[ -d "$TEMPLATES_DIR/languages/$DETECTED_LANG/agents" ]]; then
    cp -r "$TEMPLATES_DIR/languages/$DETECTED_LANG/agents"/* "$TARGET_DIR/.claude/agents/" 2>/dev/null || true
  fi

  # Merge language-specific commands
  if [[ -d "$TEMPLATES_DIR/languages/$DETECTED_LANG/commands" ]]; then
    cp -r "$TEMPLATES_DIR/languages/$DETECTED_LANG/commands"/* "$TARGET_DIR/.claude/commands/" 2>/dev/null || true
  fi

  # Merge language-specific hooks
  if [[ -d "$TEMPLATES_DIR/languages/$DETECTED_LANG/hooks" ]]; then
    cp "$TEMPLATES_DIR/languages/$DETECTED_LANG/hooks"/*.sh "$TARGET_DIR/.claude/hooks/" 2>/dev/null || true
  fi

  # Copy language-specific CLAUDE.md
  if [[ -f "$TEMPLATES_DIR/languages/$DETECTED_LANG/CLAUDE.md" ]]; then
    cp "$TEMPLATES_DIR/languages/$DETECTED_LANG/CLAUDE.md" "$TARGET_DIR/.claude/CLAUDE.md"
  fi

  # Copy language-specific config.json
  if [[ -f "$TEMPLATES_DIR/languages/$DETECTED_LANG/config.json" ]]; then
    cp "$TEMPLATES_DIR/languages/$DETECTED_LANG/config.json" "$TARGET_DIR/.claude/config.json"
  fi
else
  # Use template if no language-specific config
  cp "$TEMPLATES_DIR/core/CLAUDE.md.template" "$TARGET_DIR/.claude/CLAUDE.md"
fi

# Copy .claudeignore
if [[ ! -f "$TARGET_DIR/.claudeignore" ]]; then
  cp "$TEMPLATES_DIR/core/.claudeignore.template" "$TARGET_DIR/.claudeignore"
  echo -e "${GREEN}✅${NC} Created .claudeignore"
fi

# Make hooks executable
chmod +x "$TARGET_DIR/.claude/hooks"/*.sh 2>/dev/null || true

# Copy steering.md if exists
if [[ -f "$TEMPLATES_DIR/steering.md" ]]; then
  cp "$TEMPLATES_DIR/steering.md" "$TARGET_DIR/"
  echo -e "${GREEN}✅${NC} Copied steering.md (Modern CLI tools guide)"
fi

echo ""
echo -e "${GREEN}✅ Configuration installed successfully!${NC}"
echo ""
echo -e "${BLUE}📋 What's next:${NC}"
echo "  1. Review .claude/CLAUDE.md and customize for your project"
echo "  2. Install SDD tools: ${YELLOW}npx cc-sdd@latest${NC}"
echo "  3. Install modern CLI tools: ${YELLOW}bash setup-tool.sh${NC}"
echo "  4. Start Claude Code: ${YELLOW}claude${NC}"
echo ""
echo -e "${BLUE}📚 Available commands:${NC}"
echo "  /lint-fix       - Auto-fix linting issues"
echo "  /test-all       - Run all tests"
echo "  /analyze-deps   - Analyze dependencies"
echo "  /kiro:spec-init - Start SDD workflow"
echo ""
echo -e "${GREEN}Happy coding! 🎉${NC}"
