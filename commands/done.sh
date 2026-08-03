#!/bin/bash

complete_next_step() {
    if ! select_project; then
        return 1
    fi

    NEXT_FILE="$PROJECT_ROOT/data/projects/$SELECTED_ID/next.md"
    HISTORY_FILE="$PROJECT_ROOT/data/projects/$SELECTED_ID/history.md"

    if [ ! -s "$NEXT_FILE" ]; then
        echo
        echo "🟡 No next step recorded for $SELECTED_NAME."
        return 1
    fi

    COMPLETED_STEP=$(head -n 1 "$NEXT_FILE")

    printf -- "- %s: %s\n" \
        "$(date '+%Y-%m-%d %H:%M')" \
        "$COMPLETED_STEP" >> "$HISTORY_FILE"

    : > "$NEXT_FILE"

    echo
    echo "✅ Completed next step for $SELECTED_NAME."
    echo "   $COMPLETED_STEP"
}
