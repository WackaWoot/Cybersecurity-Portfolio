#!/bin/bash

date=$1

awk -F'[	]' '{print $1 , $3}' $1_Dealer_schedule.txt >> Dealers_working_during_losses.txt
