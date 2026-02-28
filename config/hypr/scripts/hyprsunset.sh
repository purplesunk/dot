#!/bin/bash

current_time="$(date '+%k%M')"

if [[ "${current_time}" -ge 2300 ]]; then
	hyprctl hyprsunset temperature 2300
	hyprctl hyprsunset gamma 75
elif [[ "${current_time}" -ge 2230 ]]; then
	hyprctl hyprsunset temperature 2300
	hyprctl hyprsunset gamma 78
elif [[ "${current_time}" -ge 2200 ]]; then
	hyprctl hyprsunset temperature 2800
	hyprctl hyprsunset gamma 80
elif [[ "$current_time" -ge 2100 ]]; then
	hyprctl hyprsunset temperature 3200
	hyprctl hyprsunset gamma 83
elif [[ "$current_time" -ge 2000 ]]; then
	hyprctl hyprsunset temperature 3500
	hyprctl hyprsunset gamma 88
elif [[ "$current_time" -ge 1920 ]]; then
	hyprctl hyprsunset temperature 4000
	hyprctl hyprsunset gamma 92
elif [[ "$current_time" -ge 1900 ]]; then
	hyprctl hyprsunset temperature 4200
	hyprctl hyprsunset gamma 92
elif [[ "$current_time" -ge 1845 ]]; then
	hyprctl hyprsunset temperature 4800
	hyprctl hyprsunset gamma 95
elif [[ "${current_time}" -ge 1800 ]]; then
	hyprctl hyprsunset temperature 5000
	hyprctl hyprsunset gamma 98
elif [[ "${current_time}" -ge 730 ]]; then
	hyprctl hyprsunset temperature 6500
	hyprctl hyprsunset gamma 100
fi
