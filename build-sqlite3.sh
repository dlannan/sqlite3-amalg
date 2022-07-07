#!/usr/bin/env bash

PLATFORM=$1

echo "Building for platform ${PLATFORM}"

if [ "${PLATFORM}" = "win64" ]; then
	cl -c src/shell.c src/sqlite3.c 
    lib -out:libsqlite3.lib shell.obj sqlite3.obj
elif [ "${PLATFORM}" = "linux" ]; then
    gcc -c -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm 
    ar rcs libsqlite3.a sqlite3.o shell.o
elif [ "${PLATFORM}" = "macosx" ]; then
    gcc -c -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm 
    ar rcs libsqlite3.a sqlite3.o shell.o
fi

