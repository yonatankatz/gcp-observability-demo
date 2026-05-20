#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Checking environment..."

# 1. Check GEMINI_API_KEY
if [ -z "$GEMINI_API_KEY" ]; then
    echo -e "${RED}❌ Error: GEMINI_API_KEY is not set.${NC}"
    echo "---------------------------------------------------------"
    echo "To use Gemini CLI, you need an API Key."
    echo "1. Get a key from: https://aistudio.google.com/app/apikey"
    echo "2. Run: export GEMINI_API_KEY='your-key-here'"
    echo "---------------------------------------------------------"
    exit 1
fi
echo -e "${GREEN}✅ GEMINI_API_KEY is set.${NC}"

# 2. Install Gemini CLI
if ! command -v gemini &> /dev/null; then
    echo "Installing Gemini CLI..."
    npm install -g @google/gemini-cli
else
    echo -e "${GREEN}✅ Gemini CLI is already installed.${NC}"
fi

# 3. Install Observability Skill
if ! gemini skills list 2>/dev/null | grep -q "google-cloud-networking-observability"; then
    echo "Installing Google Cloud Networking Observability skill..."
    npx --yes skills add google/skills@google-cloud-networking-observability --yes
else
    echo -e "${GREEN}✅ Networking Observability skill is already installed.${NC}"
fi

# 4. Setup Auto-Approval Policy
mkdir -p ~/.gemini/policies
POLICY_FILE="$HOME/.gemini/policies/rules.toml"

if [ ! -f "$POLICY_FILE" ]; then
    echo "Creating auto-approval policy..."
    cat <<EOF > "$POLICY_FILE"
[[rule]]
decision = "allow"
priority = 999
toolName = "run_shell_command"
commandPrefix = [ "gcloud", "bq", "gcloud logging read" ]
EOF
    echo -e "${GREEN}✅ Policy created.${NC}"
else
    echo -e "${GREEN}✅ Policy file already exists.${NC}"
fi

echo -e "\n${GREEN}🚀 Environment verified! You can now start using Gemini CLI.${NC}"
