/*=================================================================================
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
 ==================================================================================*/

#define RX_ADDR 0x00003010
#define TX_ADDR 0x00003020

int main(void)
{

  unsigned char *tx = (void*) TX_ADDR;
  unsigned short *rx = (void*) RX_ADDR;

  // A byte recieved from the serial port
  unsigned short data;

  // A string to send

  char array[12] = {'h','e','l','l','o',' ','w', 'o', 'r', 'l', 'd','\0'};

  for(int i=0; i<12; i++)
    *tx = array[i];

  data = 0;
  while(!(data&0xFF00) ) {
    data = *rx;
  }

  if(data != 0x0168) {
    return 1;
  }

  data = 0;
  while(!(data&0xFF00) ) {
    data = *rx;
  }

  if(data != 0x0165) {
    return 2;
  }

  data = 0;
  while(!(data&0xFF00) ) {
    data = *rx;
  }

  if(data != 0x016C) {
    return 3;
  }

  data = 0;
  while(!(data&0xFF00) ) {
    data = *rx;
  }

  if(data != 0x016C) {
    return data | 0x8000;
    //return 4;
  }
  return 5;
}
