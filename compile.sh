#!/bin/bash
#===============================================================================
#
#          FILE: compile.sh
# 
#         USAGE: ./compile.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: James Zhu (000), jzhu@blizzard.com
#  ORGANIZATION: Blizzard Entertainment
#       CREATED: 01/14/2014 03:46:16 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

SRC=$1
nasm -f elf $SRC

DST=$(basename $1 .asm)
ld -m elf_i386 -s -o $DST ${DST}.o
