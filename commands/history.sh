#!bin/bash

show_history() {

    if ! select_project;  then
	return 1

    fi

    HISTORY_FILE="$PROJECT_ROOT/data/projects/$SELECTED_ID/history.md"

    if [ ! -s "$HISTORY_FILE" ]; then
	echo
	echo "🟡 No history found for $SELECTED_NAME."
	return 1

    fi

   echo
   echo "📜 History for $SELECTED_NAME"
   echo "______________________________________"
   echo

   cat "$HISTORY_FILE"

   echo
   echo "✅ End of History."
   echo

}
