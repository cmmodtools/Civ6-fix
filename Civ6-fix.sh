#!/bin/sh
[ "$1" ] || set -- /Applications/Civ6.app
[ -w "$1" ] && unset sudo || sudo=sudo
find "$1"/Contents/Assets -depth \( -type d \( -name platforms -o -name windows -o -name audio \) -exec sh -c "$sudo "'mv -v "{}" "`echo "{}" | awk -v FS=/ -v OFS=/ \"{ \\$NF=toupper(substr(\\$NF,1,1)) substr(\\$NF,2); print }\"`"' \; \) -o \( -type f -name \*.modinfo -execdir sh -c 'fix() { dir=`dirname "$1"`; ( [ -d "$dir" ] || fix "$dir" ) && ( [ -e "$1" ] || find "$dir" -mindepth 1 -maxdepth 1 -iname "`basename "$1"`" -exec '"$sudo "'mv -v \{\} "$1" \; 2>/dev/null ) }; sed -n "s:.*<File\([[:space:]][^>]*\)*>\(.*\)</File>.*:\2:p" "{}" | while read file; do [ -f "$file" ] || fix "$file"; done' \; \)
