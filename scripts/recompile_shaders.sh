#!/bin/bash

cd "$(dirname "$0")"

for shader in ../shaders/*.glsl; do
    filename=$(basename "$shader" .glsl)
    
    ../tools/sokol-shdc.exe \
        --input "$shader" \
        --output "../src/shaders/$filename.c3" \
        --format sokol_c3 \
        --slang glsl430:hlsl5:metal_macos
done