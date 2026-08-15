#!/bin/bash

source "$PROJECT_ROOT/lib/ui.sh"
source "$PROJECT_ROOT/lib/bootstrap.sh"
source "$PROJECT_ROOT/services/session/session.sh"
source "$PROJECT_ROOT/services/brain/ollama.sh"
source "$PROJECT_ROOT/services/brain/router.sh"

initialize_kernel() {
    load_commands
}
