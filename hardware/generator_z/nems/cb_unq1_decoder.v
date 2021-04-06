module cb_unq1_decoder (
    input wire [3:0] in,
    output wire [9:0] out
);

    assign out = (1 << in);

endmodule

