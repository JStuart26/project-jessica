#!bin/bash

show_greeting() {

    HOUR=$(date +%H)

    if [ "$HOUR" -lt 12 ]; then
        GREETING="Good morning"
    elif [ "$HOUR" -lt 18 ]; then
        GREETING="Good afternoon"
    else
        GREETING="Good evening"
    fi

    echo "👋 $GREETING, Justin!"
    echo
}

show_system_info() {
    echo "Checking development environment..."
    echo

    echo "🖥️  Operating System : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
    echo "👤 User             : $(whoami)"
    echo "🕒 Time             : $(date '+%A %b %d %I:%M %p')"
    echo
}

check_git() {
    echo "Checking Git..."

    if command -v git >/dev/null; then
        echo "✅ Git Installed"
    else
        echo "❌ Git Missing"
    fi

    echo
}

check_docker() {
    echo "Checking Docker..."

    if command -v docker >/dev/null; then
        echo "✅ Docker Installed"
    else
        echo "❌ Docker Missing"
    fi
    echo
}

finish() {
    echo "╭──────────────────────────────────────────────────╮"
    echo "             Ready to start coding! 🚀"
    echo "╰──────────────────────────────────────────────────╯"
}

dashboard() {
    ui_header
    show_greeting
    show_system_info
    check_git
    check_docker
    show_projects
    finish
}
