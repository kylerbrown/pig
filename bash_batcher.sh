#!/bin/bash

machines="lab7-1
lab7-2
lab7-3
lab7-4
lab7-5
lab7-6
lab7-8
lab7-9
lab7-10
lab7-11
lab7-12
lab7-13
lab7-14
lab7-15
lab7-16
lab7-17
lab7-18
lab7-19
lab7-20
lab7-21
lab7-22
lab7-23
lab7-24"

for i in $machines
do
echo $i started
(ssh -o "StrictHostKeyChecking no" $i "matlab -r batch_run") &
echo $i done
done

