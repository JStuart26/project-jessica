#!/bin/bash

start_session_service() {
    SESSION_FILE="$PROJECT_ROOT/data/state/session.conf"
    SESSION_START_TIME="$(date '+%Y-%m-%d %H:%M:%S')"

    if [ -f "$SESSION_FILE" ]; then
    echo "🟡 Session already active."
    return 0
    fi


    echo "SESSION_START_TIME=\"$SESSION_START_TIME\"" > "$SESSION_FILE"

    echo "✅ Session started at $SESSION_START_TIME"
}

show_session_status_service() {
    SESSION_FILE="$PROJECT_ROOT/data/state/session.conf"

    if [ ! -f "$SESSION_FILE" ]; then
        echo "🔴 No active session."
        return 0
    fi

    source "$SESSION_FILE"

    START_EPOCH="$(date -d "$SESSION_START_TIME" +%s)"
    NOW_EPOCH="$(date +%s)"
    ELAPSED_SECONDS=$((NOW_EPOCH - START_EPOCH))
    ELAPSED_MINUTES=$((ELAPSED_SECONDS / 60))

    echo "🟢 Session active."
    echo "   Started: $SESSION_START_TIME"
    echo "   Elapsed: $ELAPSED_MINUTES minutes"
}

end_session_service() {
    SESSION_NOTE="$*"

    SESSION_FILE="$PROJECT_ROOT/data/state/session.conf"
    HISTORY_FILE="$PROJECT_ROOT/data/sessions/history.log"

    if [ ! -f "$SESSION_FILE" ]; then
        echo "🔴 No active session to end."
        return 0
    fi

    source "$SESSION_FILE"

    SESSION_END_TIME="$(date '+%Y-%m-%d %H:%M:%S')"

    START_EPOCH="$(date -d "$SESSION_START_TIME" +%s)"
    END_EPOCH="$(date -d "$SESSION_END_TIME" +%s)"
    DURATION_SECONDS=$((END_EPOCH - START_EPOCH))
    DURATION_MINUTES=$((DURATION_SECONDS / 60))

    mkdir -p "$(dirname "$HISTORY_FILE")"

    echo "$SESSION_START_TIME | $SESSION_END_TIME | ${DURATION_MINUTES} minute(s) | $SESSION_NOTE" \
    >> "$HISTORY_FILE"

    rm "$SESSION_FILE"

    echo "❎ Session ended at $SESSION_END_TIME"
}

show_session_history_service() {
    HISTORY_FILE="$PROJECT_ROOT/data/sessions/history.log"

    if [ ! -f "$HISTORY_FILE" ]; then
        echo "📭 No session history yet."
        return 0
    fi

    echo "📚 Session History"
    echo

    cat "$HISTORY_FILE"

    TOTAL_SESSIONS="$(wc -l < "$HISTORY_FILE")"

    TOTAL_MINUTES="$(
    awk -F'|' '
        {
            gsub(/[^0-9]/, "", $3)
            total += $3
        }
        END {
            print total
        }
    ' "$HISTORY_FILE"
)"

    TOTAL_HOURS=$((TOTAL_MINUTES / 60))
    REMAINING_MINUTES=$((TOTAL_MINUTES % 60))

    echo
    echo "📊 Summary"
    echo "   Sessions: $TOTAL_SESSIONS"
    echo "   Total time: ${TOTAL_HOURS} hour(s), ${REMAINING_MINUTES} minute(s)"
}
