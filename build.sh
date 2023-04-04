#!/bin/bash

mkdir -p bin
for GOOS in $(go tool dist list | sed 's/\/.*//'); do
    if [ "$GOOS" == "linux" ] || [ "$GOOS" == "darwin" ] || [ "$GOOS" == "windows" ]; then
        for GOARCH in $(go tool dist list | grep "^$GOOS" | sed 's/.*\///'); do
            OUTPUT="bin/wghttp-$GOOS-$GOARCH"
            if [ "$GOOS" == "windows" ]; then
                OUTPUT="$OUTPUT.exe"
            fi
            CGO_ENABLED=0 GOOS=$GOOS GOARCH=$GOARCH go build -o $OUTPUT
        done
    fi
done



