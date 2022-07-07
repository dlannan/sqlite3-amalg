#!/usr/bin/env bash

PLATFORM=$1

echo "Building for platform ${PLATFORM}"

if [ "${PLATFORM}" = "win64" ]; then
	cl /EHsc -I./src src/shell.c src/sqlite3.c -Felibsqlite3.obj
    lib src/libsqlite3.obj 
elif [ "${PLATFORM}" = "linux" ]; then
    gcc -c -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm 
    ar rcs src/libsqlite3.a src/sqlite3.o src/shell.o
elif [ "${PLATFORM}" = "macosx" ]; then
    gcc -c -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm 
    ar rcs src/libsqlite3.a src/sqlite3.o src/shell.o
fi

