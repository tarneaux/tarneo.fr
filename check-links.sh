#!/bin/bash

links=$(find content/ -type f -name "*.md" -exec cat '{}' \; | grep -oE "https?://[a-zA-Z0-9./?=_-]*")

check_url() {
	http_code=$(curl -s -m 20 -o /dev/null -w "%{http_code}" "$line")
	if [ "$http_code" -eq 200 ]; then
		echo -e "\e[32m[OK]\e[0m $line"
	elif [ "$http_code" -eq 301 ] || [ "$http_code" -eq 302 ]; then
		echo -e "\e[33m[REDIRECT]\e[0m $line -> $(curl -s -o /dev/null -w "%{redirect_url}" "$line")"
	elif [ "$http_code" -eq 000 ]; then
		# We probably timed out. Maybe the site is down?
		# Anyway, we'll print a warning and continue
		echo -e "\e[33m[WARN]\e[0m $line timed out"
	else
		echo -e "\e[31m[FAIL]\e[0m $line: $http_code"
	fi
}

# Because we can't get a variable from a subshell, we need to grep the output, which is a bit hacky
out=$(
	while read -r line; do
		check_url &
	done <<< "$links" | tee /dev/stderr
)

ok=$(echo "$out" | grep -c "OK")
redir=$(echo "$out" | grep -c "REDIRECT")
fail=$(echo "$out" | grep -c "FAIL")
warn=$(echo "$out" | grep -c "WARN")

if [ "$warn" -gt 0 ]; then
	echo -e "\e[33m[WARN]\e[0m $warn links timed out"
fi

wait

echo -e "\e[34m[INFO]\e[0m Checked $((ok + redir + fail)) links, $redir redirects, $fail failed"

if [ "$fail" -gt 0 ]; then
	exit 1
fi
