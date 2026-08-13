cmd_context() {
    source "$PROJECT_ROOT/services/session/session.sh"

    if [ -z "$1" ]; then
        echo "Usage: jessica context <value>"
        return 1
    fi

    set_session_context_service "$1"
}