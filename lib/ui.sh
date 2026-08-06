#!/bin/bash

TITLE="${1:-Project Jessica}"
VERSION="${2:-0.5.5}"

ui_header() {

    echo
    echo "╭────────────────────────────────────────────────────╮"
    echo "│ 🤖 $TITLE                                        │"
    echo "│ Personal AI Development Lab                      │"
    echo "│ Version $VERSION                                 │"
    echo "╰────────────────────────────────────────────────────╯"
    echo

}
