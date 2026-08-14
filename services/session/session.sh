#!/bin/bash

start_session_service() {
    SESSION_FILE="$PROJECT_ROOT/data/state/session.conf"
    SESSION_START_TIME="$(date '+%m/%d/%Y %H:%M:%S')"
    LAST_INTERACTION_AT="$SESSION_START_TIME"
    ACTIVE_USER="${USER:-unknown}"
    CURRENT_MODE="coding"
    CURRENT_CONTEXT="Jessica OS development"

    if [ -f "$SESSION_FILE" ]; then
    echo "🟡 Session already active."
    return 0
    fi

{
    echo "SESSION_START_TIME=\"$SESSION_START_TIME\""
    echo "ACTIVE_USER=\"$ACTIVE_USER\""
    echo "CURRENT_MODE=\"$CURRENT_MODE\""
    echo "CURRENT_CONTEXT=\"$CURRENT_CONTEXT\""
    echo "LAST_INTERACTION_AT=\"$LAST_INTERACTION_AT\""
} > "$SESSION_FILE"

    echo "✅ Session started at $SESSION_START_TIME"
}

update_last_interaction_service() {
    SESSION_FILE="$PROJECT_ROOT/data/state/session.conf"

    if [ ! -f "$SESSION_FILE" ]; then
        return 0
    fi

    source "$SESSION_FILE"

    LAST_INTERACTION_AT="$(date '+%m/%d/%Y %H:%M:%S')"

    sed -i \
        "s|^LAST_INTERACTION_AT=.*|LAST_INTERACTION_AT=\"$LAST_INTERACTION_AT\"|" \
        "$SESSION_FILE"
}

show_session_status_service() {
    SESSION_FILE="$PROJECT_ROOT/data/state/session.conf"

    if [ ! -f "$SESSION_FILE" ]; then
        echo "🔴 No active session."
        return 0
    fi

    source "$SESSION_FILE"

    update_last_interaction_service

    echo "👤 Active User: $ACTIVE_USER"
    echo "🛠️  Current Mode: $CURRENT_MODE"
    echo "📂 Current Context: $CURRENT_CONTEXT"

    START_EPOCH="$(date -d "$SESSION_START_TIME" +%s)"
    NOW_EPOCH="$(date +%s)"
    ELAPSED_SECONDS=$((NOW_EPOCH - START_EPOCH))
    ELAPSED_MINUTES=$((ELAPSED_SECONDS / 60))

    echo "🟢 Session active."
    echo "   Started: $SESSION_START_TIME"
    echo "   Last Interaction: $LAST_INTERACTION_AT"
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

    SESSION_END_TIME="$(date '+%m/%d/%Y %H:%M:%S')"

    START_EPOCH="$(date -d "$SESSION_START_TIME" +%s)"
    END_EPOCH="$(date -d "$SESSION_END_TIME" +%s)"
    DURATION_SECONDS=$((END_EPOCH - START_EPOCH))
    DURATION_MINUTES=$((DURATION_SECONDS / 60))

    mkdir -p "$(dirname "$HISTORY_FILE")"

    echo "$SESSION_START_TIME | $SESSION_END_TIME | ${DURATION_MINUTES} minute(s) | $CURRENT_MODE | $CURRENT_CONTEXT | $SESSION_NOTE" >> "$HISTORY_FILE"

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

    tac "$HISTORY_FILE" | while IFS='|' read -r START_TIME END_TIME DURATION MODE CONTEXT NOTE; do
        START_TIME="$(echo "$START_TIME" | xargs)"
        END_TIME="$(echo "$END_TIME" | xargs)"
        DURATION="$(echo "$DURATION" | xargs)"
        MODE="$(echo "$MODE" | xargs)"
        CONTEXT="$(echo "$CONTEXT" | xargs)"
        NOTE="$(echo "$NOTE" | xargs)"

        echo "🗓️  Started:  $START_TIME"
        echo "🏁 Ended:    $END_TIME"
        echo "⏱️  Duration: $DURATION"
        echo "🛠️  Mode:     $MODE"
        echo "📂 Context:  $CONTEXT"

        if [ -n "$NOTE" ]; then
        echo "📝 Note:     $NOTE"
        fi

        echo
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo
    done

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

set_session_mode_service() {
    SESSION_FILE="$PROJECT_ROOT/data/state/session.conf"

    if [ ! -f "$SESSION_FILE" ]; then
        echo "No active session."
        return 1
    fi

    NEW_MODE="$1"

    sed -i \
        "s|^CURRENT_MODE=.*|CURRENT_MODE=\"$NEW_MODE\"|" \
        "$SESSION_FILE"

    echo "Session mode set to: $NEW_MODE"
}

set_session_context_service() {
    SESSION_FILE="$PROJECT_ROOT/data/state/session.conf"

    if [ ! -f "$SESSION_FILE" ]; then
        echo "No active session."
        return 1
    fi

    NEW_CONTEXT="$1"

    sed -i \
        "s|^CURRENT_CONTEXT=.*|CURRENT_CONTEXT=\"$NEW_CONTEXT\"|" \
        "$SESSION_FILE"

    echo "Session context set to: $NEW_CONTEXT"
}
