# shellcheck shell=bash

cmd_ask() {
    PROMPT="$*"

    if [ -z "$PROMPT" ]; then
        echo "Usage: jessica ask <message>"
        return 1
    fi

    ollama_generate_service "$PROMPT"
}