#!/bin/bash

# Script to sum up the "Used" column from df -k output
# Usage: ./df-k-usage-sum.sh

# No conversion function needed since df -k outputs in kilobytes

# Function to convert kilobytes to human-readable format
kb_to_human() {
    local kb="$1"
    
    if (( kb >= 1073741824 )); then      # 1 TiB in KB
        echo "$kb" | awk '{printf "%.1fT", $1/1073741824}'
    elif (( kb >= 1048576 )); then       # 1 GiB in KB  
        echo "$kb" | awk '{printf "%.1fG", $1/1048576}'
    elif (( kb >= 1024 )); then          # 1 MiB in KB
        echo "$kb" | awk '{printf "%.1fM", $1/1024}'
    else
        echo "${kb}K"
    fi
}

# Get df -k output and process it
total_kb=$(df -k | awk '
    BEGIN { total = 0 }
    NR > 1 && $3 ~ /^[0-9]+$/ { total += $3 }
    END { print total }
')

total_kb_human=$(kb_to_human $total_kb)

sketchybar --set "$NAME" icon="" label="$total_kb_human"
