#!/bin/bash

start_session() {
    source "$PROJECT_ROOT/services/session/session.sh"
    start_session_service
}

show_session_status() {
    source "$PROJECT_ROOT/services/session/session.sh"
    show_session_status_service
}

end_session_service() {
    source "$PROJECT_ROOT/services/session/session.sh"
    end_session_service
}

show_session_history() {
    source "$PROJECT_ROOT/services/session/session.sh"
    show_session_history_service
}