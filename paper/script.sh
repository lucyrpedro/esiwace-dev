#!/bin/bash

# export CYLC_TASK_CYCLE_POINT=2012-08
OF=$(cylc cycle-point --offset-month=1 --template=/home/k202020/experiment1/cycle-temperature-CCYY-MM.nc)

IF1=$(cylc cycle-point --offset-month=-1 --template=/home/k202020/experiment1/athmosphere-CCYY-MM.nc)
IF2=$(cylc cycle-point --offset-month=-2 --template=/home/k202020/experiment1/athmosphere-CCYY-MM.nc)
IF3=$(cylc cycle-point --offset-month=-3 --template=/home/k202020/experiment1/athmosphere-CCYY-MM.nc)
IF4=$(cylc cycle-point --offset-month=-4 --template=/home/k202020/experiment1/athmosphere-CCYY-MM.nc)


# Model needs input data wind speeds for athmosphere (start data) and topology
# What do I need 5 files athmosphere Cycle now up to -5
# I generate one output file current cycle-temperate.nc

echo """
SIMULATED_TIME=1 month
CURRENT_TIME=$CYLC_TASK_CYCLE_POINT
DRIVER_ATHMOSPHERE=[$IF1, $IF2, $IF3, $IF4]
TOPOLOGY_FILE=/work/pool/echam/topology15degree.nc
OUTPUT_FILE=$OF
""" > model.conf

mpiexec -np 10 ./model model.conf
