#!bin/bash

add() {

    echo
    echo "What would you liek to add?"
    echo
    echo "1) Note"
    echo "2) Next Step"
    echo

    read -r -p "Selection: " CHOICE
    echo

case "$CHOICE" in

    1)
        add_note
	;;

    2)
        update_next_step
	;;

    *)
	echo "Invalid selection."
	;;

esac

}
