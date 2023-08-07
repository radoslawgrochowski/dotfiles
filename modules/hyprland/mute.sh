#!/bin/bash

if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
  pamixer --default-source -m && notify-send  -u low "Volume Switched OFF"
elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
  pamixer --default-source -u && notify-send  -u low "Volume Switched ON"
fi
