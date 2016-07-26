# Makefile for NCSIM
# Usage: type "make" to compile all source and launch console-mode NCSIM on ${TARGET}
#        type "make gui" to launch the X version of NCSIM
#

INCICIVE_INST_DIR := /mnt/Disk_D/cadence/installs/INCICIV141/tools/bin
FILE_SRC := /home/ada/SV_Test_Work/task_1/src/*

TARGET := ${FILE_SRC}

NCSIM = ${INCICIVE_INST_DIR}/irun -sv -v93 -64bit -logfile ncvlog.log -errormax 15 -update -linedebug -incdir ./src

NCSIM_GUI = ${NCSIM} -gui -input restore.tcl

default: clean sim

gui:     clean simgui

sim:
	${NCSIM} ${TARGET}

simgui:
	${NCSIM_GUI} ${TARGET}

clean:
	rm -f *~ *.log hdl.var ncsim.key irun.key cds.lib
	rm -r -f INCA_libs .simvision waves.shm ./cov_work/scope/