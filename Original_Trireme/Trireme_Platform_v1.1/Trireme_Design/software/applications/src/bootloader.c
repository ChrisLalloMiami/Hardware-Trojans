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

// 18 address bits
#define RX_ADDR 0x000C0010
#define TX_ADDR 0x000C0020
// 12 address bits
//#define RX_ADDR 0x00003010
//#define TX_ADDR 0x00003020

#define BOOTLOADER_SIZE 0x00000300
#define LOCAL_ADDRESS_BITS 18
int main(void) {

  unsigned char *instr;
  unsigned char *tx = (void*) TX_ADDR;
  unsigned short *rx = (void*) RX_ADDR;

  unsigned int counter     = BOOTLOADER_SIZE;
  unsigned int max_counter = 1 << LOCAL_ADDRESS_BITS;

  unsigned int c;
  unsigned char msg1[27] = "\n\n\rWaiting for program... ";
  unsigned char msg2[20] = "Upload complete!\n\n\r";
  // The address that the loaded program will start at
  void *program_start = (void*)BOOTLOADER_SIZE;

  // A byte recieved from the serial port
  unsigned short data = 0;

  c = 0;
  while(msg1[c] != '\0') {
    *tx = msg1[c];
    c++;
  }

  while(counter < max_counter) {
    // Read status bit and data;
    data = *rx;
    // check status bit
    if(data&0xFF00) {
      // Send data if valid
      instr = (void*) counter;
      *instr = (char) data;
      counter++;
    }
  }

  c = 0;
  while(msg2[c] != '\0') {
    *tx = msg2[c];
    c++;
  }

  goto *program_start;
}


