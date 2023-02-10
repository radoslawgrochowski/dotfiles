#!/etc/profiles/per-user/radoslawgrochowski/bin/fish

SORTED_DEVICES=$(
  xrandr \
    | jc --xrandr \
    | jq '[.screens[].associated_device, .unassociated_devices[]]' \
    | jq '.[] | select(.is_connected == true)' \
    | jq -rs 'sort_by(.offset_width, .offset_height) | .[].device_name'
)

echo "reordering monitors to:"
echo $SORTED_DEVICES
bspc wm --reorder-monitors $SORTED_DEVICES
