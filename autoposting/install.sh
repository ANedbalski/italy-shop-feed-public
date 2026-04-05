#!/bin/bash
set -e

echo "=== AutoPosting MCP — Installer ==="
echo ""

if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 not found. Install Python 3.11+ first."
    exit 1
fi

INSTALL_DIR="${HOME}/.autoposting-mcp"
echo "Installing to: ${INSTALL_DIR}"

python3 -m venv "${INSTALL_DIR}"
source "${INSTALL_DIR}/bin/activate"

pip install "https://feed.italy-shop.eu/autoposting//autoposting_mcp-0.1.0-py3-none-any.whl" --quiet

echo ""
echo "=== Installed successfully ==="
echo ""
echo "Python path: ${INSTALL_DIR}/bin/python"
echo ""
echo "Add this to Claude Desktop config:"
echo "  ~/Library/Application Support/Claude/claude_desktop_config.json"
echo ""
cat << JSONEOF
{
  "mcpServers": {
    "autoposting": {
      "command": "${INSTALL_DIR}/bin/python",
      "args": ["-m", "autoposting"],
      "env": {
        "SKYSHOP_API_KEY": "YOUR_API_KEY"
      }
    }
  }
}
JSONEOF
echo ""
echo "Replace YOUR_API_KEY with your Sky-shop API key."
echo "Restart Claude Desktop after adding the config."
