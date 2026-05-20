#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Checking environment..."

# 1. Prompt for GCP Project ID and set as default (retry until success)
while true; do
    read -r -p "Enter your GCP Project ID: " PROJECT_ID
    if [ -z "$PROJECT_ID" ]; then
        echo -e "${RED}❌ Project ID cannot be empty. Please try again.${NC}"
        continue
    fi

    echo "Setting default project to '${PROJECT_ID}'..."
    if gcloud config set project "$PROJECT_ID"; then
        echo -e "${GREEN}✅ Default project set to ${PROJECT_ID}.${NC}"
        break
    else
        echo -e "${RED}❌ Failed to set project '${PROJECT_ID}'. Please try again.${NC}"
    fi
done

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
