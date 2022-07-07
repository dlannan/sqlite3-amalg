#!/usr/bin/env bash

PLATFORM=$1

echo "Building for platform ${PLATFORM}"

if [ "${PLATFORM}" = "win64" ]; then
	cl /c /EHsc -I./src src/shell.c src/sqlite3.c -Fesqlite3.obj
    lib /out:libsqlite3.lib sqlite3.obj 
elif [ "${PLATFORM}" = "linux" ]; then
    gcc -c -o sqlite3.o -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm 
    ar rcs libsqlite3.a sqlite3.o
elif [ "${PLATFORM}" = "macosx" ]; then
    gcc -c -o sqlite3.o -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm 
    ar rcs libsqlite3.a sqlite3.o
fi

