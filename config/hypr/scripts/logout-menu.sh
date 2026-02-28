#!/bin/sh

entry_list=""

# create_entry() {
# 	name="$1"
# 	icon="$2"
# 	printf '%s\\0icon\\x1f%s' "$name" "$icon"
# }

add_entry() {
	name="$1"
	icon="$2"
	new_entry="$name\0icon\x1f$icon"

	if [ -z "$entry_list" ]; then
		entry_list="$new_entry"
		return
	fi

	entry_list="$entry_list\n$new_entry"
}


# poweroff="$(create_entry 'Power Off' 'system-shut-down')"
# restart="$(create_entry 'Reboot' 'system-reboot')"
# logout="$(create_entry 'Log Out' 'system-log-out')"
# lock="$(create_entry 'Lock Session' 'system-lock-screen')"

add_entry 'Power Off' 'system-shut-down'
add_entry 'Reboot' 'system-reboot'
add_entry 'Log Out' 'system-log-out'
add_entry 'Lock Session' 'system-lock-screen'

# selected="$(echo -en "$poweroff\n$restart\n$logout\n$lock" | fuzzel -d --lines 4)"
selected="$(echo -en "$entry_list" | fuzzel -d --lines 4)"

case "$selected" in
	"Power Off") 
		systemctl poweroff
		;;
	"Reboot") 
		reboot
		;;
	"Log Out") 
		uwsm stop
		;;
	"Lock Session")
		hyprlock
		;;
	*)
		;;
esac
