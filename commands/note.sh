#!/bin/bash

add_note() {
     REQUESTED_ID="$1"

     if [ -n "$REQUESTED_ID" ]; then
         shift
         NOTE_TEXT="$*"

         if ! find_project_by_id "$REQUESTED_ID"; then
             echo "❌ Unknown project: $REQUESTED_ID"
             echo
             echo "Known projects:"
             while IFS="|" read -r NAME PROJECT_PATH TYPE PROJECT_ID
             do
                 [ -z "$NAME" ] && continue
                 echo "   $PROJECT_ID - $NAME"
             done < "$PROJECT_ROOT/data/projects.conf"
             return 1
         fi
     else
         if ! select_project; then
             return 1
         fi
     fi

     NOTES_FILE="$PROJECT_ROOT/data/projects/$SELECTED_ID/notes.md"

     if [ -z "$NOTE_TEXT" ]; then
         echo
         read -r -p "Enter a note for $SELECTED_NAME: " NOTE_TEXT
     fi

     if [ -z "$NOTE_TEXT" ]; then
         echo "❌ Note cannot be empty."
         return 1
     fi

     printf -- '- %s: %s\n' "$(date '+%Y-%m-%d %H:%M')" "$NOTE_TEXT" >> "$NOTES_FILE"

     echo
     echo "✅ Note added for $SELECTED_NAME."
     echo "   $NOTE_TEXT"
 }
