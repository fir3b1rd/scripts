#!/bin/bash


# just run it like this:
# sh jstackseries.sh [pid] [cq5serveruser] [count] [delay]
#
# For example:
# sh jstackSeries.sh 1234 cq5serveruser 10 3

if [ $# -eq 0 ]; then
    echo >&2 "Usage: jstackSeries <pid> <run_user> [ <count> [ <delay> ] ]"
    echo >&2 "    Defaults: count = 10, delay = 0.5 (seconds)"
    exit 1
fi
pid=$1          # required
user=$2         # required
count=${3:-10}  # defaults to 10 times
delay=${4:-0.5} # defaults to 0.5 seconds
while [ $count -gt 0 ]
do
    timestamp=$(date +%H%M%S.%N)
    sudo -u $user jstack -l $pid >jstack.$pid.$timestamp
    sudo -u $user jmap -histo $pid|head -n 50 >>jstack.$pid.$timestamp
    sleep $delay
    let count--
    echo -n "."
done

