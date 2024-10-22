/** @module : BSRAM_byte_en_flat
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

//Same cycle read memory access
module BSRAM_byte_en_flat  #(
  parameter CORE = 0,
  parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = 8,
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

reg  [DATA_WIDTH-1:0] sram [0:MEM_DEPTH-1];

assign readData = (readEnable & writeEnable & (readAddress == writeAddress)) ?
                  writeData   : readEnable  ? sram[readAddress] : 0;


genvar i;
generate
  for(i=0; i<NUM_BYTES; i=i+1) begin : RAM_WRITE
    always@(posedge clock) begin
      if(writeEnable & writeByteEnable[i])
        sram[writeAddress][(8*i)+7:8*i] <= writeData[(8*i)+7:8*i];
    end
  end // for
endgenerate

reg [31: 0] cycles;
always @ (posedge clock) begin
    cycles <= reset? 0 : cycles + 1;
	if (scan & ((cycles >=  SCAN_CYCLES_MIN) & (cycles <= SCAN_CYCLES_MAX)))begin
        $display ("------ Core %d SBRAM Byte En Unit - Current Cycle %d --------", CORE, cycles);
        $display ("| Read        [%b]", readEnable);
        $display ("| Read Address[%h]", readAddress);
        $display ("| Read Data   [%h]", readData);
        $display ("| Write       [%b]", writeEnable);
        $display ("| Write Byte  [%b]", writeByteEnable);
        $display ("| Write Addres[%h]", writeAddress);
        $display ("| Write Data  [%h]", writeData);
        $display ("----------------------------------------------------------------------");
    end
 end

endmodule

