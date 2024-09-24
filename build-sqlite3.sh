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
    export PATH="android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/:$PATH"
    export PATH="android-ndk/toolchains/llvm/prebuilt/linux-x86_64/:$PATH"
    
    aarch64-linux-android21-clang++ -c -I./src -Iandroid-ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include src/shell.c src/sqlite3.c -D__ANDROID__ -D__ANDROID_MIN_SDK_VERSION__=21 -lpthread -lm -fPIC -static
    llvm-ar rcs libsqlite3.a sqlite3.o shell.o    
    rm sqlite3.o shell.o
    armv7a-linux-androideabi19-clang++ -c -I./src -Iandroid-ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include src/shell.c src/sqlite3.c src/mmap.c -D__ANDROID__ -D__ANDROID_MIN_SDK_VERSION__=19 -lpthread -lm -fPIC -static
    llvm-ar rcs libsqlite3-armv7.a sqlite3.o shell.o mmap.o
fi

