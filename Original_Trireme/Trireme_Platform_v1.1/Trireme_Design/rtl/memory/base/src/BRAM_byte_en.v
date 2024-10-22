/** @module : BRAM_byte_en
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

module BRAM_byte_en #(
  parameter CORE = 0,
  parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = 8,
  parameter INIT_FILE_BASE = "",
  parameter SCAN_CYCLES_MIN = 0,
  parameter SCAN_CYCLES_MAX = 1000
) (
  input  clock,
  input  reset,
  input  readEnable,
  input  [ADDR_WIDTH-1:0] readAddress,
  output [DATA_WIDTH-1:0] readData,
  input  writeEnable,
  input  [DATA_WIDTH/8-1:0] writeByteEnable,
  input  [ADDR_WIDTH-1:0] writeAddress,
  input  [DATA_WIDTH-1:0] writeData,
  input  scan
);

localparam MEM_DEPTH = 1 << ADDR_WIDTH;
localparam NUM_BYTES = DATA_WIDTH/8;

genvar i;
generate
for(i=0; i<NUM_BYTES; i=i+1) begin : BYTE_LOOP
  if(INIT_FILE_BASE != "") begin : IF_INIT
    // Override the init file parameter by prepending the byte number to the
    // base file name
    BRAM #(
      .DATA_WIDTH(8),
      .ADDR_WIDTH(ADDR_WIDTH),
      .INIT_FILE({"0"+i,INIT_FILE_BASE})
    ) BRAM_byte (
      .clock(clock),
      .reset(reset),
      .readEnable(readEnable),
      .readAddress(readAddress),
      .readData(readData[(8*i)+7:8*i]),
      .writeEnable(writeEnable & writeByteEnable[i]),
      .writeAddress(writeAddress),
      .writeData(writeData[(8*i)+7:8*i]),
      .scan(scan)
    );
  end
  else begin : ELSE_INIT
    // Do not override the INIT_FILE parameter
    BRAM #(
      .DATA_WIDTH(8),
      .ADDR_WIDTH(ADDR_WIDTH)
    ) BRAM_byte (
      .clock(clock),
      .reset(reset),
      .readEnable(readEnable),
      .readAddress(readAddress),
      .readData(readData[(8*i)+7:8*i]),
      .writeEnable(writeEnable & writeByteEnable[i]),
      .writeAddress(writeAddress),
      .writeData(writeData[(8*i)+7:8*i]),
      .scan(scan)
    );
  end
end
endgenerate

reg [31: 0] cycles;
always @ (posedge clock) begin
    cycles <= reset? 0 : cycles + 1;
	if (scan & ((cycles >=  SCAN_CYCLES_MIN) & (cycles <= SCAN_CYCLES_MAX)))begin
        $display ("------ Core %d BRAM Byte En Unit - Current Cycle %d --------", CORE, cycles);
        $display ("| Read        [%b]", readEnable);
        $display ("| Read Address[%h]", readAddress);
        $display ("| Read Data   [%h]", readData);
        $display ("| Write       [%b]", writeEnable);
        $display ("| Write Addres[%h]", writeAddress);
        $display ("| Write Data  [%h]", writeData);
        $display ("----------------------------------------------------------------------");
    end
 end

endmodule
