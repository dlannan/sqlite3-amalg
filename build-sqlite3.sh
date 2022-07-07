#!/usr/bin/env bash

PLATFORM=$1

echo "Building for platform ${PLATFORM}"

if [ "${PLATFORM}" = "win64" ]; then
	cl -I./src src/shell.c src/sqlite3.c -Fesqlite3.exe
elif [ "${PLATFORM}" = "linux" ]; then
    gcc -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm -o sqlite3
elif [ "${PLATFORM}" = "macosx" ]; then
    gcc -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm -o sqlite3	
fi