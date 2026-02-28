#!/bin/bash

HDMI_MONITOR="alsa_output.pci-0000_01_00.1.hdmi-stereo"
HEADPHONES="alsa_output.usb-Razer_Razer_Nari-00.mono-fallback"

CURRENT_SINK=$(pactl get-default-sink)

if [[ "$CURRENT_SINK" == "$HDMI_MONITOR" ]]; then
	pactl set-default-sink "$HEADPHONES"
	notify-send "Default Sink set to Nari (Wireless) Mono"
else
	pactl set-default-sink "$HDMI_MONITOR"
	notify-send "Default Sink set to HDMI Audio"
fi
