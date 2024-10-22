#=================================================================================
#  Copyright (c) 2021 STAM Center (ASCS Lab/CAES Lab/STAM Center/ASU)
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.

#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
#=================================================================================

#!/bin/bash

# Concatenate padded binaries together to form single memory image. Enter each
# program name as an argument to the script in the order they should be placed
# in the cores, i.e. Core 0 is the first argument, core 1 is the second, and so
# on. A core number prefix is added to each program name. Each of the prefixed
# program names is concatenated to form the image file name. The ".img"
# extention is added to the written file.
#
# Example Usage:
# $ ./img_cat.sh uart primes mandelbrot
# Core 0 Program: uart
# Core 1 Program: primes
# Core 2 Program: mandelbrot
# Writing to: C0_uart_C1_primes_C2_mandelbrot.img
#

CORE_NUM=0
FILE_NAME=""
for i in ${@}; do
  echo "Core $CORE_NUM Program: $i";
  FILE_NAME="${FILE_NAME}C${CORE_NUM}_${i}_"
  CORE_NUM=$((CORE_NUM+1))
done

FILE_NAME="${FILE_NAME::-1}.img"
echo "Writing to: ${FILE_NAME}"
cat $@ > $FILE_NAME

