#!/usr/bin/env bash

# --------------------------
# CONFIG
# --------------------------
MONITOR_DDC="HDMI-A-1"      # Supports DDC/CI
MONITOR_SOFT="HDMI-A-2"     # Software dim only
STEP_DDC=10                 # DDC brightness step (0-100)
STEP_SOFT=0.1               # Software brightness step (0-1)

# Unicode blocks for 5-level fill
BLOCKS=("○" "◔" "◑" "◕" "●")

# --------------------------
# FUNCTIONS
# --------------------------

# Hardware brightness via DDC
get_ddc_brightness() {
    cur=$(ddcutil getvcp 10 --display 1 2>/dev/null | grep -Po '(?<=current value = )\d+')
    [ -z "$cur" ] && cur=0
    echo "$cur"
}

set_ddc_brightness() {
    local change=$1
    cur=$(get_ddc_brightness)
    new=$((cur + change))
    ((new>100)) && new=100
    ((new<0)) && new=0
    ddcutil setvcp 10 $new --display 1
}

# Software brightness via wlr-randr
get_soft_brightness() {
    cur=$(wlr-randr | grep "$MONITOR_SOFT" | grep -Po '(?<=Brightness: )\d+(\.\d+)?')
    [ -z "$cur" ] && cur=1
    echo "$cur"
}

set_soft_brightness() {
    local change=$1
    cur=$(get_soft_brightness)
    new=$(awk "BEGIN{print $cur+$change}")
    # clamp
    new=$(awk "BEGIN{if($new>1) print 1; else if($new<0.1) print 0.1; else print $new}")
    wlr-randr --output $MONITOR_SOFT --brightness $new
}

# Draw icon based on brightness (0-100%)
draw_icon() {
    # Average both monitors
    ddc=$(get_ddc_brightness)
    soft=$(awk "BEGIN{print $(get_soft_brightness)*100}")
    avg=$(( (ddc + soft)/2 ))
    index=$((avg/20))
    [ $index -ge 5 ] && index=4
    echo "${BLOCKS[$index]}"
}

# --------------------------
# MAIN
# --------------------------

case "$1" in
    up)
        set_ddc_brightness $STEP_DDC
        set_soft_brightness $STEP_SOFT
        ;;
    down)
        set_ddc_brightness -$STEP_DDC
        set_soft_brightness -$STEP_SOFT
        ;;
esac

draw_icon

