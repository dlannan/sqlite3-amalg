#!/usr/bin/env bash

PLATFORM=$1

echo "Building for platform ${PLATFORM}"

if [ "${PLATFORM}" = "win64" ]; then
	cl shell.c sqlite3.c -Fesqlite3.exe
else if [ "${PLATFORM}" = "linux" ]; then
    gcc shell.c sqlite3.c -lpthread -ldl -lm -o sqlite3
else if [ "${PLATFORM}" = "macosx" ]; then
    gcc shell.c sqlite3.c -lpthread -ldl -lm -o sqlite3	
fi