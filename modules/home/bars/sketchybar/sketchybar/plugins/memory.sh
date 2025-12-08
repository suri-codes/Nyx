#!/bin/bash

# Get total physical memory in bytes
total_ram=$(sysctl -n hw.memsize)

# Get used memory using vm_stat (convert page counts to bytes)
pages_free=$(vm_stat | awk '/Pages free/ {print $3}' | tr -d '.')
pages_speculative=$(vm_stat | awk '/Pages speculative/ {print $3}' | tr -d '.')
pages_purgeable=$(vm_stat | awk '/Pages purgeable/ {print $3}' | tr -d '.')
page_size=$(vm_stat | head -1 | awk '{print $8}')
page_size=${page_size%\.}  # remove any trailing period

# Calculate used RAM in bytes
free_ram=$(( (pages_free + pages_speculative + pages_purgeable) * page_size ))
used_ram=$(( total_ram - free_ram ))

# Calculate percentage used (rounded)
ram_usage_frac=$(awk "BEGIN {printf \"%.6f\", $used_ram / $total_ram}")

# Optional: format output for human readability
total_ram_human=$(bc <<< "$total_ram / (1024^3)")
used_ram_human=$(bc <<< "scale=2; $used_ram / (1024^3)")

sketchybar \
            --set mem.used_txt label="$used_ram_human/$total_ram_human GB" \
            --push mem.used $ram_usage_frac
