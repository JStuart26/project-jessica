#!bin/bash

load_commands() {
    for command_file in "$PROJECT_ROOT"/commands/*.sh; do
        source "$command_file"
    done    
}
