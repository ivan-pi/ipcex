#!/usr/bin/env bash

mkfifo fifo0 fifo1
./a < fifo1 | tee fifo0 & ./b < fifo0 | tee fifo1

rm -f fifo0 fifo1