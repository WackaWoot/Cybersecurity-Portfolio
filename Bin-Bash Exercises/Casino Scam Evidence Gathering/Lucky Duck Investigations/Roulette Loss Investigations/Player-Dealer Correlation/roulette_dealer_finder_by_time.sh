#!/bin/bash

date=$1
clock=$2 
AMPM=$3

grep -i $2* $1_Dealer_schedule.txt | awk -F'[	]' '{print $1, $3}'| grep -i $3

echo 'is the dealer working Roulette'

