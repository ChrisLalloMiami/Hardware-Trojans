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

/* Version of sbrk for no operating system.  */

#include <errno.h>
#include <_syslist.h>
#undef errno
extern int errno;

void *
_sbrk (int incr)
{
   extern char   end; /* Set by linker.  */
   extern char   stack_end; /* Set by linker. */
   static char * heap_end = 0; 
   char *        prev_heap_end = 0;

   if (heap_end == 0)
     heap_end = &end;
   // check if user is asking for a sane break value
   if ((heap_end + incr) > &stack_end) {
	   errno = ENOMEM;
	   return (void *) -1;
   }  
   if ((heap_end + incr) < &end) {
	   errno = EINVAL;
	   return (void *) -1;
   }
   prev_heap_end = heap_end;
   heap_end += incr;
   return (void *) prev_heap_end;
}
