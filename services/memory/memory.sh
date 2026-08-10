#!/bin/bash

remember_value_service() {
    KEY="$1"
    VALUE="$2"

    if [ -z "$KEY" ] || [ -z "$VALUE" ]; then
        echo "⚠️  Usage: jessica remember <key> <value>"
        return 1
    fi

    MEMORY_FILE="$PROJECT_ROOT/data/state/memory.conf"

    echo "$KEY=$VALUE" >> "$MEMORY_FILE"
}

recall_value_service() {
    KEY="$1"

    if [ -z "$KEY" ]; then
        echo "⚠️  Usage: jessica recall <key>"
        return 1
    fi

    MEMORY_FILE="$PROJECT_ROOT/data/state/memory.conf"

    if [ ! -f "$MEMORY_FILE" ]; then
        echo "🧠 No memory file found."
        return 0
    fi

    VALUE="$(
        grep "^${KEY}=" "$MEMORY_FILE" \
        | tail -n 1 \
        | cut -d'=' -f2-
    )"

    if [ -z "$VALUE" ]; then
        echo "🤷 I don't remember anything for: $KEY"
        return 0
    fi

    echo "$VALUE"
}

show_memories_service() {
    MEMORY_FILE="$PROJECT_ROOT/data/state/memory.conf"

    if [ ! -f "$MEMORY_FILE" ]; then
        echo "🧠 I don't have any saved memories yet."
        return 0
    fi

    echo
    echo "🧠 Jessica's Memory"
    echo

    awk -F'=' '
    {
        memory[$1] = substr($0, index($0, "=") + 1)
    }
    END {
        for (key in memory) {
            print "• " key ": " memory[key]
        }
    }
' "$MEMORY_FILE"
}

forget_value_service() {
    KEY="$1"
    MEMORY_FILE="$PROJECT_ROOT/data/state/memory.conf"

    if [ -z "$KEY" ]; then
        echo "⚠️  Usage: jessica forget <key>"
        return 1
    fi

    if [ ! -f "$MEMORY_FILE" ]; then
        echo "🧠 No memory file found."
        return 0
    fi

    if ! grep -q "^${KEY}=" "$MEMORY_FILE"; then
        echo "🤷 I don't remember anything for: $KEY"
        return 0
    fi

    TEMP_FILE="$(mktemp)"

    grep -v "^${KEY}=" "$MEMORY_FILE" > "$TEMP_FILE"
    mv "$TEMP_FILE" "$MEMORY_FILE"

    echo "🗑️  Forgot: $KEY"
}