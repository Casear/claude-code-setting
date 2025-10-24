#!/bin/bash
# Quick MCP Setup Script - Basic Combo

set -euo pipefail

echo "🔌 Installing Basic MCP Servers..."
echo ""

# 1. Filesystem
echo "📁 Installing Filesystem Server..."
claude mcp add --transport stdio filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem .

# 2. Git
echo "🌿 Installing Git Server..."
claude mcp add --transport stdio git -- \
  npx -y @modelcontextprotocol/server-git

echo ""
echo "✅ Basic MCP servers installed!"
echo ""
echo "Verify with: claude → /mcp"
