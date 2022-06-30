#!/bin/bash

run() {
  if [ mons | grep "[0-9]$" -o == 2 ] then
    mons -e left
    mons --primary $(mons | grep "HDMI-[0-9]-[0-9]" -o)
  fi
}
