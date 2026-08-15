# shellcheck shell=bash

ollama_generate_service() {
    PROMPT="$1"

    SYSTEM_PROMPT="You are Jessica OS, Justin's personal AI assistant. Be concise, helpful, calm, and practical. You are part of a local home and development system. Do not pretend to have completed actions unless a Jessica service actually performed them."

    PAYLOAD="$(
        SYSTEM_PROMPT="$SYSTEM_PROMPT" PROMPT="$PROMPT" python3 -c '
import os, json

print(json.dumps({
    "model": "qwen3:0.6b",
    "prompt": os.environ["SYSTEM_PROMPT"] + "\n\nUser: " + os.environ["PROMPT"] + "\nJessica:",
    "think": False,
    "stream": False,
    "options": {
        "num_ctx": 2048
    }
}))
'
    )"

    curl -s http://127.0.0.1:11434/api/generate \
        -H "Content-Type: application/json" \
        -d "$PAYLOAD" \
        | python3 -c 'import sys, json; data=json.load(sys.stdin); print(data["response"] if "response" in data else "Jessica brain error: " + data.get("error", "unknown error"))'
}