#!/bin/bash

memory_file_path() {
    echo "$PROJECT_ROOT/data/state/memory.conf"
}

memory_file_append() {
    KEY="$1"
    VALUE="$2"

    MEMORY_FILE="$(memory_file_path)"

    echo "$KEY=$VALUE" >> "$MEMORY_FILE"
}

memory_file_get_latest() {
    KEY="$1"
    MEMORY_FILE="$(memory_file_path)"

    grep "^${KEY}=" "$MEMORY_FILE" \
        | tail -n 1 \
        | cut -d'=' -f2-
}

memory_file_delete_key() {
    KEY="$1"
    MEMORY_FILE="$(memory_file_path)"

    TEMP_FILE="$(mktemp)"

    grep -v "^${KEY}=" "$MEMORY_FILE" > "$TEMP_FILE"
    mv "$TEMP_FILE" "$MEMORY_FILE"
}

memory_file_list_latest() {
    MEMORY_FILE="$(memory_file_path)"

    awk -F'=' '
        {
            memory[$1] = substr($0, index($0, "=") + 1)
        }
        END {
            for (key in memory) {
                print key "=" memory[key]
            }
        }
    ' "$MEMORY_FILE"
}

memory_file_exists() {
    MEMORY_FILE="$(memory_file_path)"

    [ -f "$MEMORY_FILE" ]
}

memory_file_has_key() {
    KEY="$1"
    MEMORY_FILE="$(memory_file_path)"

    grep -q "^${KEY}=" "$MEMORY_FILE"
}