module sb_decoder_4to1_mux (
    input wire [1:0] in,
    output wire [3:0] out
);

    assign out = (1 << in);

endmodule

