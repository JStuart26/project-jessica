#!bin/bash

show_project_status() {
    NAME="$1"
    PROJECT_PATH="$2"
    TYPE="$3"
    PROJECT_ID="$4"

    echo
    echo "📁 $NAME"
    echo "   Path   : $PROJECT_PATH"
    echo "   Type   : $TYPE"

    if [ ! -d "$PROJECT_PATH" ]; then
        echo "   Status : ❌ Folder not found"
        return
    fi

    if [ ! -d "$PROJECT_PATH/.git" ]; then
        echo "   Status : ⚪ Not a Git repository"
        return
    fi

    BRANCH=$(git -C "$PROJECT_PATH" branch --show-current)

    if [ -z "$(git -C "$PROJECT_PATH" status --porcelain)" ]; then
        STATUS="✅ Clean"
    else
        STATUS="🟡 Uncommitted changes"
    fi

    UPSTREAM=$(git -C "$PROJECT_PATH" rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>/dev/null)

    if [ -z "$UPSTREAM" ]; then
        REMOTE_STATUS="⚪ No upstream configured"
    else
        COUNTS=$(git -C "$PROJECT_PATH" rev-list --left-right --count "$UPSTREAM...HEAD")
        BEHIND=$(echo "$COUNTS" | awk '{print $1}')
        AHEAD=$(echo "$COUNTS" | awk '{print $2}')

        if [ "$AHEAD" -eq 0 ] && [ "$BEHIND" -eq 0 ]; then
            REMOTE_STATUS="✅ Up to date"
        elif [ "$AHEAD" -gt 0 ] && [ "$BEHIND" -eq 0 ]; then
            REMOTE_STATUS="⬆ $AHEAD commit(s) ahead"
        elif [ "$AHEAD" -eq 0 ] && [ "$BEHIND" -gt 0 ]; then
            REMOTE_STATUS="⬇ $BEHIND commit(s) behind"
        else
            REMOTE_STATUS="↕ $AHEAD ahead, $BEHIND behind"
        fi
    fi

    NEXT_FILE="$PROJECT_ROOT/data/projects/$PROJECT_ID/next.md"

    if [ -s "$NEXT_FILE" ]; then
        NEXT_STEP=$(head -n 1 "$NEXT_FILE")
    else
        NEXT_STEP="No next step recorded"
    fi

    echo "   Branch : $BRANCH"
    echo "   Status : $STATUS"
    echo "   Remote : $REMOTE_STATUS"
    echo "   Next   : $NEXT_STEP"
}

show_projects() {
     echo "============= PROJECTS ============="

     while IFS="|" read -r NAME PROJECT_PATH TYPE PROJECT_ID
     do
         show_project_status "$NAME" "$PROJECT_PATH" "$TYPE" "$PROJECT_ID"
     done < "$PROJECT_ROOT/data/projects.conf"

     echo
}
