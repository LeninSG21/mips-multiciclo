module sign_extend (
        input [15:0] signal_in,
        output reg [31:0] signal_out
    );
    
    assign signal_out = signal_in[15] ? 16'hFFFF <<16 | signal_in: signal_in;

endmodule