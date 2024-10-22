/*=================================================================================
 # factorial.c

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

unsigned int multiply_by_add(unsigned int a, unsigned int b)
{
    unsigned int i, ans;
    ans = 0;
    for(i = 0; i < b; i++)
          ans += a;
    return ans;
}

unsigned int factorial(unsigned int a)
 {
   if (a == 0)
      return 0;
   if (a == 1)
      return 1;
   else
    {
      a = multiply_by_add(a, factorial(a-1));
      return a;
   }
 }

 int main(void)
 {
    int n, result;
    unsigned char *tx = (void*) TX_ADDR;
    unsigned char *result_string;
    unsigned char pass[14] = {'T','e','s','t',' ','P','a','s','s','e','d','!','\n','\r'};
    unsigned char fail[14] = {'T','e','s','t',' ','F','a','i','l','e','d','!','\n','\r'};

    n = 8;
    result = factorial(n);

    if(result == 40320)
      result_string = pass;
    else
      result_string = fail;

    for(int i=0; i<14; i++)
      *tx = result_string[i];

    return result;
 }
