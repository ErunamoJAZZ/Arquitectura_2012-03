#!/bin/sh

# Constructor para amd64.
#
# Necesita tener:
#  - nasm
#  - Along32
#  - gcc (Preferiblemente Buid-Essentials o similar)
#

nasm -f elf32 Linux_main.asm

gcc -m32 -o Linux_main Linux_main.o -lAlong32
