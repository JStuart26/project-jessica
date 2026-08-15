# shellcheck shell=bash

brain_route_service() {
    PROMPT="$1"

    LOWER_PROMPT="$(
        printf '%s' "$PROMPT" | tr '[:upper:]' '[:lower:]'
    )"

    case "$LOWER_PROMPT" in
		*"turn on"*|*"turn off"*|*"switch on"*|*"switch off"*|*"dim "*|*"brighten "*|*"unlock "*|*"lock "*|*"open "*|*"close "*)
   			echo "home_control"
    		;;

		*"front door"*|*"garage door"*|*"locks"*|*"unlocked"*|*"locked"*)
    		echo "locks"
    		;;

        *"temperature"*|*"temp"*|*"humidity"*|*"thermostat"*|*"ecobee"*|*"climate"*)
            echo "climate"
            ;;

        *"lights"*|*"living room light"*|*"kitchen light"*|*"bedroom lamp"*)
            echo "lights"
            ;;

        *"vacuum"*|*"robovac"*|*"robert"*|*"vanessa"*)
            echo "vacuums"
            ;;

        *"server"*|*"cpu"*|*"memory usage"*|*"disk usage"*|*"containers"*)
            echo "server"
            ;;

        *"house status"*|*"home status"*|*"what's going on at home"*|*"whats going on at home"*)
            echo "home"
            ;;

        *)
            echo "chat"
            ;;
    esac
}