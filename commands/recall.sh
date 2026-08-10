#!/bin/bash

recall() {
    source "$PROJECT_ROOT/services/memory/memory.sh"
    recall_value_service "$1"
}