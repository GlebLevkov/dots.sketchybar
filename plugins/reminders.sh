LABEL="$(reminders show-all --due-date today | awk -F': ' '{print $3}')"
EVENT_NOW=$(icalBuddy -iep title,datetime -b "" --excludeAllDayEvents --noCalendarNames --propertySeparators " | " eventsNow | head -n 1) 

if [[ -n "$EVENT_NOW" ]]; then 
    IFS="|" read -r TITLE TIME <<<"$EVENT_NOW"

    sketchybar --animate tanh 20 --set $NAME drawing=on label="$(echo "${TITLE:0:29}") ($TIME)"
else
    sketchybar --animate tanh 20 --set $NAME drawing=on label=$(echo "${LABEL:0:29}")
fi

