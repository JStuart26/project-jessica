cmd_mode() {
    source "$PROJECT_ROOT/services/session/session.sh"

    if [ -z "$1" ]; then
        echo "Usage: jessica mode <value>"
        return 1
    fi

    set_session_mode_service "$1"
}
