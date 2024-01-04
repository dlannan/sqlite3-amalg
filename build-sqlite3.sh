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
elif [ "${PLATFORM}" = "ios64" ]; then
    gcc -c -I./src src/shell.c src/sqlite3.c -lpthread -ldl -lm -arch arm64
    ar rcs libsqlite3.a sqlite3.o shell.o
elif [ "${PLATFORM}" = "android" ]; then
    export PATH="android-ndk-r26b/toolchains/llvm/prebuilt/linux-x86_64/bin/:$PATH"
    export PATH="android-ndk-r26b/toolchains/llvm/prebuilt/linux-x86_64/:$PATH"
    aarch64-linux-android30-clang -c -I./src -Iandroid-ndk-r26b/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include src/shell.c src/sqlite3.c -D__ANDROID__  -fPIC -static
    llvm-ar rcs libsqlite3.a sqlite3.o shell.o    
    rm sqlite3.o shell.o
    armv7a-linux-androideabi30-clang -c -I./src src/shell.c -Iandroid-ndk-r26b/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include src/sqlite3.c -D__ANDROID__ -target armv7a-none-linux-android19 -fPIC -static
    llvm-ar rcs libsqlite3-armv7.a sqlite3.o shell.o    
fi

