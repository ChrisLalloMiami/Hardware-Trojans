/** @module : tb_fetch_receive
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

module tb_fetch_receive();

parameter DATA_WIDTH = 32;
parameter NOP        = 32'h00000013;


reg  [DATA_WIDTH-1  :0] i_mem_data;
reg  flush;
reg  scan;
wire [DATA_WIDTH-1  :0] instruction;

//instantiate fetch_receive module
fetch_receive #(
  .DATA_WIDTH(DATA_WIDTH)
) DUT (
  .flush(flush),
  .i_mem_data(i_mem_data),
  .instruction(instruction),
  .scan(scan)
);

initial begin
  flush      <= 0;
  i_mem_data <= 32'hFEFEFEFE;
  scan       <= 0;

  #1;
  if(instruction != 32'hFEFEFEFE)begin
    $display("Test 1 Error!");
    $display("\ntb_fetch_receive --> Test Failed!\n\n");
    $stop;
  end

  #5;
  i_mem_data <= 32'h55556666;
  flush      <= 1;

  #1;
  if(instruction != NOP)begin
    $display("Test 2 Error!");
    $display("\ntb_fetch_receive --> Test Failed!\n\n");
    $stop;
  end

  #5;
  i_mem_data <= 32'h11111111;
  #1;
  if(instruction != NOP)begin
    $display("Test 3 Error!");
    $display("\ntb_fetch_receive --> Test Failed!\n\n");
    $stop;
  end

  #5;
  flush <= 0;
  #1;
  if(instruction != 32'h11111111)begin
    $display("Test 4 Error!");
    $display("\ntb_fetch_receive --> Test Failed!\n\n");
    $stop;
  end

  $display("\ntb_fetch_receive --> Test Passed!\n\n");
  $stop;

end

endmodule
