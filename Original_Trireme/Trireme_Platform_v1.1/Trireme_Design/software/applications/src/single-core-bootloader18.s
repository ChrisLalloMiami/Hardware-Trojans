# This file is modified from the C version of the multi-core bootloader.
	.file	"multi-core-bootloader.asm"
	.option nopic
	.text
	.globl	lock
	.section	.sdata,"aw"
	.align	2
	.type	lock, @object
	.size	lock, 4
lock:
	.word	1
	.section	.rodata
	.align	2
.LC0:
	.string	"\n\n\rWaiting for program... "
	.align	2
.LC1:
	.string	"Upload complete!\n\n\r"
	.text
	.align	2
	.globl	main
	.type	main, @function

.global _start
_start:
main:
boot:
	addi	zero,zero,0
	addi	ra,zero,0
  # No stack pointer because the bootloader does not use a stack. Variables are
  # stored in registers.
	addi	sp,zero,0
	addi	gp,zero,0
	addi	tp,zero,0
	addi	t0,zero,0
	addi	t1,zero,0
	addi	t2,zero,0
	addi	s0,zero,0
  # a0: NUM_CORES
	#addi	a0,zero,8
	#addi	a0,zero,3
	addi	a0,zero,1
  # a1: LOCK_ADDRESS
	addi	a1,zero,%lo(lock)
  # a2: BOOTLOADER_SIZE
	addi	a2,zero,0x300
  # a3: LOCAL_ADDRESS_BITS
	addi	a3,zero,18
  # a4: RX_ADDR 0xC0010
  lui   a4,0x000C0
	addi	a4,a4,0x10
  # a5: TX_ADDR 0xC0020
  lui   a5,0x000C0
	addi	a5,a5,0x20
  # a6:
	addi	a6,zero,0
	addi	a7,zero,0
	addi	s2,zero,0
	addi	s3,zero,0
	addi	s4,zero,0
	addi	s5,zero,0
	addi	s6,zero,0
	addi	s7,zero,0
	addi	s8,zero,0
	addi	s9,zero,0
	addi	s10,zero,0
	addi	s11,zero,0
	addi	t3,zero,0
	addi	t4,zero,0
	addi	t5,zero,0
	addi	t6,zero,0


# Write the first string out the UART
print_ready:
  # Set string pointer variable
	addi	t5,zero,%lo(.LC0)
  # Load first charachter in string
  lbu   t6,0(t5)
  jal   zero,rdy_while_condition
rdy_while_top:
  # Write to UART tx
  sb    t6,0(a5)
  # Increment string pointer
  addi  t5,t5,1
  # Load next charachter
  lbu   t6,0(t5)
rdy_while_condition:
  bne   t6,zero,rdy_while_top




# Read the UART data and write it to the instruction memory
instr_writing:
  # Set core loop control variable to 0
  addi t0,zero,0
  # Compute local address size
  addi t1,zero,1
  sll  t1,t1,a3
  # Set counter offset variable to 0
  addi t6,zero,0

instr_for_top:
  # set counter while control variable to BOOTLOADER_SIZE
  addi t2,a2,0
  jal  zero, instr_while_condition

instr_while_top:
  # Read from the UART
  lhu  t3,0(a4)
  # Compute valid mask
  srli t4,t3,8
valid_if:
  beq  t4,t3,instr_while_condition
  # Compute next instruction pointer
  add  t4,t2,t6
  # Store instruction byte
  andi t3,t3,255
  sb   t3,0(t4)
  # Increment counter while control variable
  addi t2,t2,1
instr_while_condition:
  blt t2,t1, instr_while_top
  # End of while loop

  # increment counter offset variable
  add t6,t6,t1
  #increment the core for loop control variable
  addi t0,t0,1
  # Check the for loop condition (core<NUM_CORES)
  blt t0,a0,instr_for_top
  # End of instruction foor loop



# Write the second string out the UART
print_complete:
  # Set string pointer variable
	addi	t5,zero,%lo(.LC1)
  # Load first charachter in string
  lbu   t6,0(t5)
  jal   zero,complete_while_condition
complete_while_top:
  # Write to UART tx
  sb    t6,0(a5)
  # Increment string pointer
  addi  t5,t5,1
  # Load next charachter
  lbu   t6,0(t5)
complete_while_condition:
  bne   t6,zero,complete_while_top


# Unlock Cores
unlock:
  # write 0 to lock variable
  sw   zero,0(a1)

# call main program
goto_program_start:
  jalr zero,0(a2)


################################################################################
# The following C code is roughly equvilany to the assembly above. It is
# included here to help users understand the assembly faster.
#
# unsigned int lock = 1;
#
# int main(void) {
#
#    unsigned char *instr;
#    unsigned char *tx = (void*) TX_ADDR;
#    unsigned short *rx = (void*) RX_ADDR;
#
#    unsigned int counter;
#    unsigned int counter_offset;
#    unsigned int local_addr_size = 1 << LOCAL_ADDRESS_BITS;
#
#    unsigned int c;
#    unsigned char msg1[27] = "\n\n\rWaiting for program... ";
#    unsigned char msg2[20] = "Upload complete!\n\n\r";
#
#    // The address that the loaded program will start at
#    void *program_start = (void*)BOOTLOADER_SIZE;
#
#    // A byte recieved from the serial port
#    unsigned short data = 0;
#
#    c = 0;
#    while(msg1[c] != '\0') {
#      *tx = msg1[c];
#      c++;
#    }
#
#    // For each core, read UART data until 2^LOCAL_ADDR_BITS instructions have
#    // been written.
#    for(int core=0; core<NUM_CORES; core++) {
#      counter = BOOTLOADER_SIZE;
#      while(counter < local_addr_size ) {
#        // Read status bit and data;
#        data = *rx;
#        // check status bit
#        if(data&0xFF00) {
#          // Send data if valid
#          instr = (void*) (counter + counter_offset);
#          *instr = (char) data;
#          counter++;
#        }
#      }
#
#      counter_offset = counter_offset + (1<<LOCAL_ADDRESS_BITS);
#    }
#
#    c = 0;
#    while(msg2[c] != '\0') {
#      *tx = msg2[c];
#      c++;
#    }
#
#    // Unlock the lock variable. The core 0 main function should lock it again
#    // before exiting so the other cores wait when the device is reset.
#    lock = 1;
#
#    goto *program_start;
#  }
#
