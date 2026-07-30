#!/bin/bash

update_next_step() {
    echo
    echo "Choose a project:"
    echo

    PROJECT_IDS=()
    PROJECT_NAMES=()

    COUNT=1

    while IFS="|" read -r NAME PROJECT_PATH TYPE PROJECT_ID
    do
        echo "   $COUNT) $NAME"

        PROJECT_NAMES+=("$NAME")
        PROJECT_IDS+=("$PROJECT_ID")

        COUNT=$((COUNT + 1))
    done < "$PROJECT_ROOT/data/projects.conf"

    echo
    read -r -p "Project number: " SELECTION

    INDEX=$((SELECTION - 1))

    if [ "$INDEX" -lt 0 ] || [ "$INDEX" -ge "${#PROJECT_IDS[@]}" ]; then
        echo "❌ Invalid project selection."
        return 1
    fi

    SELECTED_NAME="${PROJECT_NAMES[$INDEX]}"
    SELECTED_ID="${PROJECT_IDS[$INDEX]}"
    NEXT_FILE="$PROJECT_ROOT/data/projects/$SELECTED_ID/next.md"

    echo
    read -r -p "Enter the next step for $SELECTED_NAME: " NEW_NEXT_STEP

    if [ -z "$NEW_NEXT_STEP" ]; then
        echo "❌ Next step cannot be empty."
        return 1
    fi

    printf '%s\n' "$NEW_NEXT_STEP" > "$NEXT_FILE"

    echo
    echo "✅ Next step updated for $SELECTED_NAME."
    echo "   $NEW_NEXT_STEP"
}
