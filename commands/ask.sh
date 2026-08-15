# shellcheck shell=bash

cmd_ask() {
    PROMPT="$*"

    if [ -z "$PROMPT" ]; then
        echo "Usage: jessica ask <message>"
        return 1
    fi

    ROUTE="$(brain_route_service "$PROMPT")"

    case "$ROUTE" in
        home)
            cmd_home
            ;;

        locks)
            cmd_home locks
            ;;

        climate)
            cmd_home climate
            ;;

        lights)
            cmd_home lights
            ;;

        vacuums)
            cmd_home vacuums
            ;;

        server)
            cmd_home server
            ;;

        home_control)
            echo "Jessica detected a home control request."
            echo "Home write actions are not enabled yet."
            ;;

        chat)
            ollama_generate_service "$PROMPT"
            ;;

        *)
            echo "Jessica routing error: unknown route '$ROUTE'"
            return 1
            ;;
    esac
}