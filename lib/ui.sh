#!/bin/bash

TITLE="${1:-Jessica OS}"
VERSION="${2:-0.6.0}"

ui_header() {

    echo
    echo "╭────────────────────────────────────────────────────╮"
    echo "│ 🤖 $TITLE                                        │"
    echo "│ Personal AI Development Lab                      │"
    echo "│ Version $VERSION                                 │"
    echo "╰────────────────────────────────────────────────────╯"
    echo

}
