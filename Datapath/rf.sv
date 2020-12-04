module rf(
  //We are asuming always enabled RAM
  input clk, we, rst,
  input [4:0] rs_addr,
  input [4:0] rt_addr,
  input [4:0] rd_addr,
  input [31:0] rd_data,
  output reg [31:0] rs_data,
  output reg [31:0] rt_data
  );
  
  reg [31:0] mem[31:0];
  int i;
  
  always @ (posedge clk)
  begin
      if(rst)
        for(i = 0; i <= 31; i = i+1)
          mem[i] <= 0;
      else if(we)
          if(rd_addr != 0) //cannot write into $0.
            mem[rd_addr] <= rd_data;
  end
    //Out register. A and B in the diagram
    always @(posedge clk) begin
        rs_data <= mem[rs_addr];
        rt_data <= mem[rt_addr];  
    end
  
endmodule
