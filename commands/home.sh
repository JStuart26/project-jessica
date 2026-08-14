cmd_home() {
    source "$PROJECT_ROOT/services/home/homeassistant.sh"

    SUBCOMMAND="$1"

    if [ "$SUBCOMMAND" = "locks" ]; then 
        echo
        echo "🔒 Locks"
        echo

        homeassistant_print_state_service \
            "Front Door" \
            "lock.bluetooth_gateway"

        homeassistant_print_state_service \
            "Garage Door" \
            "lock.garage_door"
        echo
        return 0
    fi

    if [ "$SUBCOMMAND" = "climate" ]; then 
        echo
        echo "🌡️ Climate"
        echo

        homeassistant_print_state_service \
            "Ecobee" \
            "climate.my_ecobee"

        homeassistant_print_state_service \
            "Indoor Temp" \
            "sensor.my_ecobee_temperature" \
            "°F"

        homeassistant_print_state_service \
            "Humidity" \
            "sensor.my_ecobee_humidity" \
            "%"
      
        homeassistant_print_state_service \
            "Sunroom" \
            "sensor.sunroom_temperature" \
            "°F"

        homeassistant_print_state_service \
            "Master Bedroom" \
            "sensor.master_bedroom_temperature" \
            "°F"

        homeassistant_print_state_service \
            "KJ's Bedroom" \
            "sensor.kjs_room_temperature" \
            "°F"

        homeassistant_print_state_service \
            "Gage's Bedroom" \
            "sensor.gages_room_temperature" \
            "°F"
      
        echo
        return 0
    fi

    if [ "$SUBCOMMAND" = "lights" ]; then 
        echo
        echo "💡 Lights"
        echo

        homeassistant_print_state_service \
            "Living Room Lights" \
            "light.living_room_can_lights"

        homeassistant_print_state_service \
            "Kitchen Lights" \
            "light.kitchen_lights"
        
        homeassistant_print_state_service \
            "Master Bedroom Lamp" \
            "light.master_bedroom_lamp"

        echo
        return 0
    fi

    if [ "$SUBCOMMAND" = "vacuums" ]; then 
        echo
        echo "🤖 Vacuums"
        echo

        homeassistant_print_state_service \
            "Robert" \
            "vacuum.living_room_robovac_robert"

        homeassistant_print_state_service \
            "Vanessa" \
            "vacuum.living_room_vacmop_vanessa"
      
        echo
        return 0
    fi

    if [ "$SUBCOMMAND" = "server" ]; then 
        echo
        echo "🖥️ Server"
        echo

        homeassistant_print_state_service \
            "Server CPU" \
            "sensor.192_168_1_200_cpu_usage" \
            "%"

        homeassistant_print_state_service \
            "Server Memory" \
            "sensor.192_168_1_200_memory_usage" \
            "%"

        homeassistant_print_state_service \
            "Server Disk" \
            "sensor.living_room_jessica_server_host_disk_usage" \
            "%"

        homeassistant_print_state_service \
            "Server Temp" \
            "sensor.192_168_1_200_package_id_0_temperature" \
            "°F"

        homeassistant_print_state_service \
            "Containers" \
            "sensor.192_168_1_200_containers_active" \
            " active"
      
        echo
        return 0
    fi



    echo
    echo "🏠 Jessica Home"
    echo

    homeassistant_print_state_service "Front Door" "lock.bluetooth_gateway"
    homeassistant_print_state_service "Garage Door" "lock.garage_door"

    echo

    homeassistant_print_state_service "Ecobee" "climate.my_ecobee"
    homeassistant_print_state_service "Indoor Temp" "sensor.my_ecobee_temperature" "°F"
    homeassistant_print_state_service "Humidity" "sensor.my_ecobee_humidity" "%"

    echo

    homeassistant_print_state_service "Living Room Lights" "light.living_room_can_lights"
    homeassistant_print_state_service "Kitchen Lights" "light.kitchen_lights"

    echo

    homeassistant_print_state_service "Robert" "vacuum.living_room_robovac_robert"
    homeassistant_print_state_service "Vanessa" "vacuum.living_room_vacmop_vanessa"

    echo

    homeassistant_print_state_service "Server CPU" "sensor.192_168_1_200_cpu_usage" "%"
    homeassistant_print_state_service "Server Memory" "sensor.192_168_1_200_memory_usage" "%"
    homeassistant_print_state_service "Server Disk" "sensor.living_room_jessica_server_host_disk_usage" "%"
    homeassistant_print_state_service "Server Temp" "sensor.192_168_1_200_package_id_0_temperature" "°F"
    homeassistant_print_state_service "Containers" "sensor.192_168_1_200_containers_active" " active"
}
