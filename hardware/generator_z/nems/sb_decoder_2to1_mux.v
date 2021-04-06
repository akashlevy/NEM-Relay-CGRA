module sb_decoder_2to1_mux (
    input wire in,
    output wire out,
    output wire out_bar
);

    assign out = in;
    assign out_bar = ~in;

endmodule

