#!/bin/bash

source "$PROJECT_ROOT/services/memory/storage_file.sh"

remember_value_service() {
    KEY="$1"
    VALUE="$2"

    if [ -z "$KEY" ] || [ -z "$VALUE" ]; then
        echo
        echo "⚠️  Usage: jessica remember <key> <value>"
        echo
        return 1
    fi

    memory_file_append "$KEY" "$VALUE"
}

recall_value_service() {
    KEY="$1"

    if [ -z "$KEY" ]; then
        echo
        echo "⚠️  Usage: jessica recall <key>"
        echo
        return 1
    fi

    VALUE="$(memory_file_get_latest "$KEY")"

    if [ -z "$VALUE" ]; then
        echo
        echo "🤷 I don't remember anything for: $KEY"
        echo
        return 0
    fi

    echo
    echo "$VALUE"
    echo
}

show_memories_service() {
    if ! memory_file_exists; then
        echo
        echo "🧠 I don't have any saved memories yet."
        echo
        return 0
    fi

    echo
    echo "🧠 Jessica's Memory"
    echo

    memory_file_list_latest | while IFS='=' read -r KEY VALUE; do
        echo "• $KEY: $VALUE"
        echo
    done
}

forget_value_service() {
    KEY="$1"
    MEMORY_FILE="$PROJECT_ROOT/data/state/memory.conf"

    if [ -z "$KEY" ]; then
        echo
        echo "⚠️  Usage: jessica forget <key>"
        echo
        return 1
    fi

    if ! memory_file_exists; then
        echo
        echo "🧠 No memory file found."
        echo 
        return 0
    fi

    if ! memory_file_has_key "$KEY"; then
        echo
        echo "🤷 I don't remember anything for: $KEY"
        echo
        return 0
    fi

    memory_file_delete_key "$KEY"

    echo
    echo "🗑️  Forgot: $KEY"
    echo
}
