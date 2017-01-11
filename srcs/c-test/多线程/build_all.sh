#!/bin/sh

if [ -z "$2" ] && [ "$1" = "clean" ]; then
CLEAN_ALL=1
elif [ "$1" != "clean" ]; then
BUILD_SINGLE=1
fi

if [ ${CLEAN_ALL:-0} -gt 0 ]; then
for i in $(find . -maxdepth 1  -type d | sed '1d'); do
	make -C ${i} clean
	# [ "$1" != "clean" ] && make -C ${i}
done
elif [ ${BUILD_SINGLE:-0} -gt 0 ]; then
	make -C ${1}
else
for i in $(find . -maxdepth 1  -type d | sed '1d'); do
	make -C ${i} clean
	make -C ${i}
done
fi
