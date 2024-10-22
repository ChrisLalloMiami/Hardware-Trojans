/** @module : tb_BRAM_byte_en
 *  @author : Adaptive & Secure Computing Systems (ASCS) Laboratory

 *  Copyright (c) 2021 STAM Center (ASCS Lab/CAES Lab/STAM Center/ASU)
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.

 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */

module tb_BRAM_byte_en();

parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 8;
parameter NUM_BYTES = DATA_WIDTH/8;

task print_signal_values;
  begin
    $display("Simulation time: %0t", $time);
    $display("Read: %b", readEnable);
    $display("Read address: %h", readAddress);
    $display("Read data: %h", readData);
    $display("Write: %h", writeEnable);
    $display("Byte En: %b", writeByteEnable);
    $display("Write address: %b", writeAddress);
    $display("Write data: %b", writeData);
  end
endtask


reg  clock;
reg  reset;
reg  readEnable;
reg  [ADDR_WIDTH-1:0] readAddress;
wire [DATA_WIDTH-1:0] readData;

reg [ADDR_WIDTH-1:0] writeAddress;
reg [DATA_WIDTH-1:0] writeData;
reg writeEnable;
reg [NUM_BYTES-1:0] writeByteEnable;

reg scan;

integer i;

BRAM_byte_en #(
  .DATA_WIDTH(DATA_WIDTH),
  .ADDR_WIDTH(ADDR_WIDTH)
) DUT (
  .clock(clock),
  .reset(reset),
  .readEnable(readEnable),
  .readAddress(readAddress),
  .readData(readData),
  .writeEnable(writeEnable),
  .writeByteEnable(writeByteEnable),
  .writeAddress(writeAddress),
  .writeData(writeData),
  .scan(scan)
);

always
  #1 clock = ~clock;

initial begin
  clock            = 0;
  reset            = 1;
  scan             = 0;
  repeat (1) @ (posedge clock);

  readAddress      = 0;
  readEnable       = 0;
  repeat (1) @ (posedge clock);

  writeAddress     = 0;
  writeData        = 0;
  writeEnable      = 0;
  writeByteEnable  = 4'b1111;
  repeat (1) @ (posedge clock);

  reset            = 0;
  DUT.BYTE_LOOP[0].ELSE_INIT.BRAM_byte.ram[2] = 8'h88;
  DUT.BYTE_LOOP[1].ELSE_INIT.BRAM_byte.ram[2] = 8'h88;
  DUT.BYTE_LOOP[2].ELSE_INIT.BRAM_byte.ram[2] = 8'hAA;
  DUT.BYTE_LOOP[3].ELSE_INIT.BRAM_byte.ram[2] = 8'hAA;
  DUT.BYTE_LOOP[0].ELSE_INIT.BRAM_byte.ram[4] = 8'h00;
  DUT.BYTE_LOOP[1].ELSE_INIT.BRAM_byte.ram[4] = 8'h00;
  DUT.BYTE_LOOP[2].ELSE_INIT.BRAM_byte.ram[4] = 8'h11;
  DUT.BYTE_LOOP[3].ELSE_INIT.BRAM_byte.ram[4] = 8'h11;
  repeat (1) @ (posedge clock);

  readAddress      = 2;
  readEnable       = 1;

  wait(readData == 32'hAAAA8888);
  $display("rd A: %h", readData);
  repeat (1) @ (posedge clock);

  writeAddress     = 2;
  writeData        = 100;
  writeEnable      = 1;
  repeat (1) @ (posedge clock);

  writeEnable      = 0;
  repeat (1) @ (posedge clock);

  readAddress      = 2;
  readEnable       = 1;

  wait(readData == 32'd100);
  $display("rd B: %h", readData);
  repeat (1) @ (posedge clock);

  readAddress      = 4;
  readEnable       = 1;


  wait(readData == 32'h11110000);
  $display("rd C: %h", readData);

  writeAddress     = 2;
  writeData        = 32'hCCCCBBBB;
  writeEnable      = 1;
  writeByteEnable  = 4'b1100;

  readAddress      = 2;
  readEnable       = 1;
  wait(readData == 32'hCCCC0064);
  $display("rd D: %h", readData);
  repeat (1) @ (posedge clock);

  writeAddress     = 2;
  writeData        = 32'hBBBBCCCC;
  writeEnable      = 1;
  writeByteEnable  = 4'b0011;

  wait(readData == 32'hCCCCCCCC);
  $display("rd E: %h", readData);
  repeat (1) @ (posedge clock);

  writeEnable      = 0;

  $display("\ntb_BRAM_byte_en --> Test Passed!\n\n");
  $stop;

end

initial begin
  #100;
  $display("\nError: Timeout");
  $display("\ntb_BRAM_byte_en --> Test Failed!\n\n");
  $stop;
end

endmodule
