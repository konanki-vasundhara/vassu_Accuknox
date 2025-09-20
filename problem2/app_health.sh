#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

URL=$1
TIMEOUT=5

if [ -z "$URL" ]; then
  echo "Usage: $0 <application_url>"
  exit 1
fi

STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time "$TIMEOUT" "$URL" || echo "000")

if [[ "$STATUS_CODE" =~ ^[2|3] ]]; then
  echo "Application is UP (HTTP $STATUS_CODE)"
elif [[ "$STATUS_CODE" == "000" ]]; then
  echo "Application is DOWN (No response within $TIMEOUT seconds)"
else
  echo "Application might be DOWN (HTTP $STATUS_CODE)"
fi

"app_health.sh" 27L, 506B
