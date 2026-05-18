#!/bin/bash
# Fibonacci-style auto-nesting hook for AeroSpace's on-window-detected callback.
# On the 2nd window, force the workspace root to a horizontal split so the
# first split sits side-by-side even if the workspace had drifted to vertical.
# From the 3rd window onward, nest with the previously-focused sibling; the
# direction must match the parent container's orientation so we always find
# the immediately-previous sibling regardless of nesting depth.
c=$(aerospace list-windows --workspace focused --count 2>/dev/null)
case "$c" in
  2)
    aerospace layout tiles horizontal
    ;;
  [3-9]|[1-9][0-9]*)
    p=$(aerospace list-windows --focused --format '%{window-parent-container-layout}' 2>/dev/null)
    case "$p" in
      h_tiles) aerospace join-with left ;;
      v_tiles) aerospace join-with up ;;
    esac
    ;;
esac
