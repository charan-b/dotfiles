#!/bin/sh

day=$(date +%e)
week=$(date +%a)
hour=$(date +%H)
month=$(date +%b)
min=$(date +%M)

echo "{\"day\": \"$day\",\"week\":\"$week\",\"hour\":\"$hour\",\"month\":\"$month\",\"min\":\"$min\"}"
