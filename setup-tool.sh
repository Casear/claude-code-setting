#!/bin/bash
# Modern CLI Tools Installation Script for Claude Code
# Supports macOS, Linux (Ubuntu/Debian), and provides fallbacks

set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔧 Installing Modern CLI Tools for Claude Code${NC}"
echo ""

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  OS="linux"
else
  OS="unknown"
fi

echo -e "${BLUE}📊 Detected OS: ${GREEN}$OS${NC}"
echo ""

# Install tools based on OS
if [[ "$OS" == "macos" ]]; then
  echo -e "${BLUE}📦 Installing via Homebrew...${NC}"

  if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}⚠️  Homebrew not found. Installing Homebrew first...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Core modern CLI tools
  brew install ripgrep fd bat eza dust

  # Additional productivity tools
  brew install zoxide delta tokei hyperfine glow lazygit

  echo -e "${GREEN}✅ macOS tools installed!${NC}"

elif [[ "$OS" == "linux" ]]; then
  echo -e "${BLUE}📦 Installing via apt (Ubuntu/Debian)...${NC}"

  sudo apt update
  sudo apt install -y ripgrep fd-find bat

  # Tools not in apt - install via cargo
  if ! command -v cargo &> /dev/null; then
    echo -e "${YELLOW}⚠️  Cargo not found. Installing Rust first...${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
  fi

  cargo install eza dust zoxide tokei

  # Note: bat is installed as 'batcat' on Ubuntu/Debian
  if ! command -v bat &> /dev/null && command -v batcat &> /dev/null; then
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
  fi

  echo -e "${GREEN}✅ Linux tools installed!${NC}"
else
  echo -e "${RED}❌ Unsupported OS. Please install tools manually:${NC}"
  echo "  - ripgrep (rg): https://github.com/BurntSushi/ripgrep"
  echo "  - fd: https://github.com/sharkdp/fd"
  echo "  - bat: https://github.com/sharkdp/bat"
  echo "  - eza: https://github.com/eza-community/eza"
  echo "  - dust: https://github.com/bootandy/dust"
  exit 1
fi

echo ""
echo -e "${BLUE}🔍 Verifying installations...${NC}"

# Verify tools
tools=("rg" "fd" "bat" "eza" "dust")
all_installed=true

for tool in "${tools[@]}"; do
  if command -v "$tool" &> /dev/null; then
    version=$("$tool" --version 2>&1 | head -n1 || echo "installed")
    echo -e "${GREEN}✅${NC} $tool: $version"
  else
    echo -e "${RED}❌${NC} $tool: not found"
    all_installed=false
  fi
done

echo ""

if $all_installed; then
  echo -e "${GREEN}🎉 All modern CLI tools installed successfully!${NC}"
else
  echo -e "${YELLOW}⚠️  Some tools failed to install. Please install them manually.${NC}"
fi

echo ""
echo -e "${BLUE}📚 Next steps:${NC}"
echo "  1. Install SDD tools: ${YELLOW}npx cc-sdd@latest${NC}"
echo "  2. Initialize your project: ${YELLOW}bash scripts/init-project.sh${NC}"
echo "  3. Start Claude Code: ${YELLOW}claude${NC}"
echo ""
echo -e "${BLUE}📖 Documentation:${NC}"
echo "  - steering.md - Modern CLI tools usage guide"
echo "  - docs/QUICK_START.md - Get started in 5 minutes"
echo ""
echo -e "${GREEN}✨ Setup complete!${NC}"
