#!/usr/bin/env bash

PLATFORM=$1

echo "Building for platform ${PLATFORM}"

make clean
make ${PLATFORM} LUAC_STR_SIZE_TYPE=size_t
if [ "${PLATFORM}" = "win64" ]; then
	mv src/splite3.exe sqlite3-64.exe
else
	mv src/sqlite3 sqlite3-64
fi