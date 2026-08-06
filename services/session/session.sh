#!/bin/bash

start_session_service() {
    SESSION_START_TIME="$(date '+%Y-%m-%d %H:%M:%S')"

    echo "SESSION_START_TIME=\"$SESSION_START_TIME\"" \
        > "$PROJECT_ROOT/data/state/session.conf"

    echo "✅ Session started at $SESSION_START_TIME"
}

show_session_status_service() {
    SESSION_FILE="$PROJECT_ROOT/data/state/session.conf"

    if [ ! -f "$SESSION_FILE" ]; then
        echo "🔴 No active session."
        return 0
    fi

    source "$SESSION_FILE"

    echo "🟢 Session active."
    echo "   Started: $SESSION_START_TIME"
}

end_session_service() {
    SESSION_FILE="$PROJECT_ROOT/data/state/session.conf"

    if [ ! -f "$SESSION_FILE" ]; then
        echo "🔴 No active session to end."
        return 0
    fi

    rm "$SESSION_FILE"
    echo "❎ Session ended."
}