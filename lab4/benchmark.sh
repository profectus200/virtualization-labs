#! /bin/bash

set -e

echo "CPU test!"
sysbench --test=cpu --cpu-max-prime=20000 run

echo "IO tests!"
sysbench --test=fileio --file-total-size=50M prepare
sysbench --test=fileio --file-total-size=50M --file-test-mode=rndrw --max-time=300 --max-requests=0 run
sysbench --test=fileio --file-total-size=50M cleanup

echo "Memory test!"
sysbench --test=memory --num-threads=4 run

echo "Threads test!"
sysbench --test=threads --thread-locks=1 --max-time=20 run
