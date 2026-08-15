#!/bin/bash

show_help() {
    echo
    echo "PROJECT JESSICA COMMANDS"
    echo
    echo "  jessica              Show the project dashboard"
    echo "  jessica next         Update a project's next step"
    echo "  jessica note         Add a timestamped project note"
    echo "  jessica done         Complete and archive the next step"
    echo "  jessica history      Show project history"
    echo "  jessica projects     Show the project dashboard"
    echo "  jessica help         Show this command list"
    echo "  jessica start       Start a development session"
    echo "  jessica status      Show the active session status"
    echo "  jessica end [note]  End the session and optionally save a note"
    echo "  jessica shistory    Show completed session history"
    echo "  jessica remember <key> <value>  Save a value in memory"
    echo "  jessica recall <key>              Recall a value from memory"
    echo "  jessica forget <key>              Forget a value from memory"
    echo "  jessica memories                  Show all saved memories"
    echo "  jessica add <key> <value>          Add a value to memory"
    echo "  jessica mode <value>              Set the session mode"
    echo "  jessica context <value>           Set the session context"
    echo "  jessica home <value>              Set the session home directory"
    echo "  jessica ask <message>              Ask a question to the AI"
    echo

}
