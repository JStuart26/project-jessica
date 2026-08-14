homeassistant_api_check_service() {
    source "$PROJECT_ROOT/config/secrets/homeassistant.env"

    curl -s \
        -H "Authorization: Bearer $HA_TOKEN" \
        -H "Content-Type: application/json" \
        "$HA_URL/api/"
}

homeassistant_get_entity_state_service() {
    source "$PROJECT_ROOT/config/secrets/homeassistant.env"

    ENTITY_ID="$1"

    curl -s \
        -H "Authorization: Bearer $HA_TOKEN" \
        -H "Content-Type: application/json" \
        "$HA_URL/api/states/$ENTITY_ID"
}

homeassistant_get_entity_state_value_service() {
    source "$PROJECT_ROOT/config/secrets/homeassistant.env"

    ENTITY_ID="$1"

    curl -s \
        -H "Authorization: Bearer $HA_TOKEN" \
        "$HA_URL/api/states/$ENTITY_ID" \
        | python3 -c 'import sys, json; print(json.load(sys.stdin)["state"])'
}

homeassistant_print_state_service() {
    LABEL="$1"
    ENTITY_ID="$2"
    SUFFIX="$3"

    STATE="$(homeassistant_get_entity_state_value_service "$ENTITY_ID")"

case "$STATE" in
    on) STATE="On" ;;
    off) STATE="Off" ;;
    locked) STATE="Locked" ;;
    unlocked) STATE="Unlocked" ;;
    docked) STATE="Docked" ;;
    cleaning) STATE="Cleaning" ;;
    cool) STATE="Cooling" ;;
    heat) STATE="Heating" ;;
    idle) STATE="Idle" ;;
    unavailable) STATE="Unavailable" ;;
esac

    echo "$LABEL: $STATE$SUFFIX"
}

