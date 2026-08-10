#!bin/bash

forget() {
    source "$PROJECT_ROOT/services/memory/memory.sh"
    forget_value_service "$1"
}