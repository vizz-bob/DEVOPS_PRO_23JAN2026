#!/bin/zsh

# Colors for terminal
GREEN="%F{green}"
RED="%F{red}"
YELLOW="%F{yellow}"
NC="%f" # No Color

# Base URL
BASE_URL="http://localhost:8006"

# Array of endpoints
typeset -A ENDPOINTS
ENDPOINTS=(
  "Gateway" "$BASE_URL"
  "Catalog" "$BASE_URL/catalog/items"
  "Cart (GET)" "$BASE_URL/cart/items"
  "Cart (POST)" "POST|$BASE_URL/cart/add|{\"item_id\":1,\"quantity\":2,\"cart_id\":1}"
  "Order (POST)" "POST|$BASE_URL/order/create|{\"item_id\":1,\"quantity\":2,\"cart_id\":1}"
  "Inventory" "$BASE_URL/inventory/items"
)

# Print table header (terminal)
print -P "${YELLOW}%-20s | %-6s | %-50s${NC}" "SERVICE" "STATUS" "RESPONSE"
print -P "${YELLOW}---------------------+--------+---------------------------------------------------${NC}"

# Prepare Markdown table
MD_TABLE="| SERVICE | STATUS | RESPONSE |\n|---------|--------|---------|\n"

# Function to test each endpoint
test_endpoint() {
    local NAME=$1
    local INFO=$2

    local METHOD="GET"
    local URL
    local DATA=""

    if [[ "$INFO" == *"|"* ]]; then
        METHOD=${INFO%%|*}                    # Part before first |
        URL=${INFO#*|}; URL=${URL%%|*}        # Middle part
        DATA=${INFO##*|}                      # Part after last |
    else
        URL="$INFO"
    fi

    if [[ "$METHOD" == "GET" ]]; then
        RESPONSE=$(curl -s -w "\n%{http_code}" "$URL")
    else
        RESPONSE=$(curl -s -w "\n%{http_code}" -X $METHOD -H "Content-Type: application/json" -d "$DATA" "$URL")
    fi

    # Split response body and status code
    BODY=$(echo "$RESPONSE" | head -n -1)
    STATUS=$(echo "$RESPONSE" | tail -n 1)

    # Color status for terminal
    if [[ "$STATUS" == "200" || "$STATUS" == "201" ]]; then
        STATUS_DISPLAY="${GREEN}$STATUS${NC}"
    else
        STATUS_DISPLAY="${RED}$STATUS${NC}"
    fi

    # Print terminal table
    print -P "%-20s | %-6s | %-50s" "$NAME" "$STATUS_DISPLAY" "$BODY"

    # Append Markdown table
    MD_TABLE+="| $NAME | $STATUS | \`${BODY}\` |\n"
}

# Loop through all endpoints
for NAME in "${(@k)ENDPOINTS}"; do
    test_endpoint "$NAME" "${ENDPOINTS[$NAME]}"
done

# Save Markdown table to file
echo -e "$MD_TABLE" > api_test_results.md
print -P "${YELLOW}Markdown table saved to api_test_results.md${NC}"

