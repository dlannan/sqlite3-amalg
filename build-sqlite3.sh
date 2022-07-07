#!/usr/bin/env bash

PLATFORM=$1

echo "Building for platform ${PLATFORM}"

if [ "${PLATFORM}" = "win64" ]; then
	cl /c /EHsc -I./src src/shell.c src/sqlite3.c -Felibsqlite3.obj
    lib libsqlite3.obj 
elif [ "${PLATFORM}" = "linux" ]; then
    gcc -c -o sqlite3.o -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm 
    ar rcs libsqlite3.a sqlite3.o
elif [ "${PLATFORM}" = "macosx" ]; then
    gcc -c -o sqlite3.o -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm 
    ar rcs libsqlite3.a sqlite3.o
fi

