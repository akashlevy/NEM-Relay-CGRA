`timescale 1ns/1ps
`define NUM_TEST_VECTORS 4637
`define ASSIGNMENT_DELAY 0
`define CONFIG_CLK_PERIOD 10
`define CLK_PERIOD 8.6
`define ACTIVE_CYCLE_NUMBER 541

// Input slices
`define SLICE_CONFIG_ADDR 31:0
`define SLICE_CONFIG_DATA 63:32
`define SLICE_CONFIG_READ 64:64
`define SLICE_CONFIG_WRITE 80:80
`define SLICE_IN_BUS1_S0_T0 96:96
`define SLICE_IN_BUS1_S0_T1 112:112
`define SLICE_IN_BUS1_S0_T2 128:128
`define SLICE_IN_BUS1_S0_T3 144:144
`define SLICE_IN_BUS1_S0_T4 160:160
`define SLICE_IN_BUS1_S1_T0 176:176
`define SLICE_IN_BUS1_S1_T1 192:192
`define SLICE_IN_BUS1_S1_T2 208:208
`define SLICE_IN_BUS1_S1_T3 224:224
`define SLICE_IN_BUS1_S1_T4 240:240
`define SLICE_IN_BUS1_S2_T0 256:256
`define SLICE_IN_BUS1_S2_T1 272:272
`define SLICE_IN_BUS1_S2_T2 288:288
`define SLICE_IN_BUS1_S2_T3 304:304
`define SLICE_IN_BUS1_S2_T4 320:320
`define SLICE_IN_BUS1_S3_T0 336:336
`define SLICE_IN_BUS1_S3_T1 352:352
`define SLICE_IN_BUS1_S3_T2 368:368
`define SLICE_IN_BUS1_S3_T3 384:384
`define SLICE_IN_BUS1_S3_T4 400:400
`define SLICE_IN_BUS16_S0_T0 431:416
`define SLICE_IN_BUS16_S0_T1 447:432
`define SLICE_IN_BUS16_S0_T2 463:448
`define SLICE_IN_BUS16_S0_T3 479:464
`define SLICE_IN_BUS16_S0_T4 495:480
`define SLICE_IN_BUS16_S1_T0 511:496
`define SLICE_IN_BUS16_S1_T1 527:512
`define SLICE_IN_BUS16_S1_T2 543:528
`define SLICE_IN_BUS16_S1_T3 559:544
`define SLICE_IN_BUS16_S1_T4 575:560
`define SLICE_IN_BUS16_S2_T0 591:576
`define SLICE_IN_BUS16_S2_T1 607:592
`define SLICE_IN_BUS16_S2_T2 623:608
`define SLICE_IN_BUS16_S2_T3 639:624
`define SLICE_IN_BUS16_S2_T4 655:640
`define SLICE_IN_BUS16_S3_T0 671:656
`define SLICE_IN_BUS16_S3_T1 687:672
`define SLICE_IN_BUS16_S3_T2 703:688
`define SLICE_IN_BUS16_S3_T3 719:704
`define SLICE_IN_BUS16_S3_T4 735:720
`define SLICE_GIN_0 736:736
`define SLICE_GIN_1 752:752
`define SLICE_GIN_2 768:768
`define SLICE_GIN_3 784:784
`define SLICE_TILE_ID 815:800
`define SLICE_RESET 816:816

// Output slices
`define SLICE_OUT_BUS1_S0_T0 0:0
`define SLICE_OUT_BUS1_S0_T1 16:16
`define SLICE_OUT_BUS1_S0_T2 32:32
`define SLICE_OUT_BUS1_S0_T3 48:48
`define SLICE_OUT_BUS1_S0_T4 64:64
`define SLICE_OUT_BUS1_S1_T0 80:80
`define SLICE_OUT_BUS1_S1_T1 96:96
`define SLICE_OUT_BUS1_S1_T2 112:112
`define SLICE_OUT_BUS1_S1_T3 128:128
`define SLICE_OUT_BUS1_S1_T4 144:144
`define SLICE_OUT_BUS1_S2_T0 160:160
`define SLICE_OUT_BUS1_S2_T1 176:176
`define SLICE_OUT_BUS1_S2_T2 192:192
`define SLICE_OUT_BUS1_S2_T3 208:208
`define SLICE_OUT_BUS1_S2_T4 224:224
`define SLICE_OUT_BUS1_S3_T0 240:240
`define SLICE_OUT_BUS1_S3_T1 256:256
`define SLICE_OUT_BUS1_S3_T2 272:272
`define SLICE_OUT_BUS1_S3_T3 288:288
`define SLICE_OUT_BUS1_S3_T4 304:304
`define SLICE_OUT_BUS16_S0_T0 335:320
`define SLICE_OUT_BUS16_S0_T1 351:336
`define SLICE_OUT_BUS16_S0_T2 367:352
`define SLICE_OUT_BUS16_S0_T3 383:368
`define SLICE_OUT_BUS16_S0_T4 399:384
`define SLICE_OUT_BUS16_S1_T0 415:400
`define SLICE_OUT_BUS16_S1_T1 431:416
`define SLICE_OUT_BUS16_S1_T2 447:432
`define SLICE_OUT_BUS16_S1_T3 463:448
`define SLICE_OUT_BUS16_S1_T4 479:464
`define SLICE_OUT_BUS16_S2_T0 495:480
`define SLICE_OUT_BUS16_S2_T1 511:496
`define SLICE_OUT_BUS16_S2_T2 527:512
`define SLICE_OUT_BUS16_S2_T3 543:528
`define SLICE_OUT_BUS16_S2_T4 559:544
`define SLICE_OUT_BUS16_S3_T0 575:560
`define SLICE_OUT_BUS16_S3_T1 591:576
`define SLICE_OUT_BUS16_S3_T2 607:592
`define SLICE_OUT_BUS16_S3_T3 623:608
`define SLICE_OUT_BUS16_S3_T4 639:624
`define SLICE_GOUT 640:640
`define SLICE_READ_DATA 687:656

module testbench;
    // Address width
    localparam ADDR_WIDTH = $clog2(`NUM_TEST_VECTORS);
   
    reg [ADDR_WIDTH - 1 : 0] test_vector_addr;
 
    reg [832-1: 0] test_vectors [`NUM_TEST_VECTORS - 1 : 0];
    reg [832-1: 0] test_vector;

    reg [688-1: 0] test_outputs [`NUM_TEST_VECTORS - 1 : 0];
    reg [688-1: 0] test_output;

    // Input wires
    wire [31:0] config_addr = test_vectors[test_vector_addr][`SLICE_CONFIG_ADDR];
    wire [31:0] config_data = test_vectors[test_vector_addr][`SLICE_CONFIG_DATA];
    wire [0:0] config_read = test_vectors[test_vector_addr][`SLICE_CONFIG_READ];
    wire [0:0] config_write = test_vectors[test_vector_addr][`SLICE_CONFIG_WRITE];
    wire [0:0] in_BUS1_S0_T0 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S0_T0];
    wire [0:0] in_BUS1_S0_T1 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S0_T1];
    wire [0:0] in_BUS1_S0_T2 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S0_T2];
    wire [0:0] in_BUS1_S0_T3 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S0_T3];
    wire [0:0] in_BUS1_S0_T4 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S0_T4];
    wire [0:0] in_BUS1_S1_T0 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S1_T0];
    wire [0:0] in_BUS1_S1_T1 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S1_T1];
    wire [0:0] in_BUS1_S1_T2 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S1_T2];
    wire [0:0] in_BUS1_S1_T3 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S1_T3];
    wire [0:0] in_BUS1_S1_T4 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S1_T4];
    wire [0:0] in_BUS1_S2_T0 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S2_T0];
    wire [0:0] in_BUS1_S2_T1 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S2_T1];
    wire [0:0] in_BUS1_S2_T2 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S2_T2];
    wire [0:0] in_BUS1_S2_T3 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S2_T3];
    wire [0:0] in_BUS1_S2_T4 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S2_T4];
    wire [0:0] in_BUS1_S3_T0 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S3_T0];
    wire [0:0] in_BUS1_S3_T1 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S3_T1];
    wire [0:0] in_BUS1_S3_T2 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S3_T2];
    wire [0:0] in_BUS1_S3_T3 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S3_T3];
    wire [0:0] in_BUS1_S3_T4 = test_vectors[test_vector_addr][`SLICE_IN_BUS1_S3_T4];
    wire [15:0] in_BUS16_S0_T0 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S0_T0];
    wire [15:0] in_BUS16_S0_T1 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S0_T1];
    wire [15:0] in_BUS16_S0_T2 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S0_T2];
    wire [15:0] in_BUS16_S0_T3 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S0_T3];
    wire [15:0] in_BUS16_S0_T4 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S0_T4];
    wire [15:0] in_BUS16_S1_T0 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S1_T0];
    wire [15:0] in_BUS16_S1_T1 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S1_T1];
    wire [15:0] in_BUS16_S1_T2 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S1_T2];
    wire [15:0] in_BUS16_S1_T3 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S1_T3];
    wire [15:0] in_BUS16_S1_T4 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S1_T4];
    wire [15:0] in_BUS16_S2_T0 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S2_T0];
    wire [15:0] in_BUS16_S2_T1 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S2_T1];
    wire [15:0] in_BUS16_S2_T2 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S2_T2];
    wire [15:0] in_BUS16_S2_T3 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S2_T3];
    wire [15:0] in_BUS16_S2_T4 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S2_T4];
    wire [15:0] in_BUS16_S3_T0 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S3_T0];
    wire [15:0] in_BUS16_S3_T1 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S3_T1];
    wire [15:0] in_BUS16_S3_T2 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S3_T2];
    wire [15:0] in_BUS16_S3_T3 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S3_T3];
    wire [15:0] in_BUS16_S3_T4 = test_vectors[test_vector_addr][`SLICE_IN_BUS16_S3_T4];
    wire [0:0] gin_0 = test_vectors[test_vector_addr][`SLICE_GIN_0];
    wire [0:0] gin_1 = test_vectors[test_vector_addr][`SLICE_GIN_1];
    wire [0:0] gin_2 = test_vectors[test_vector_addr][`SLICE_GIN_2];
    wire [0:0] gin_3 = test_vectors[test_vector_addr][`SLICE_GIN_3];
    wire [15:0] tile_id = test_vectors[test_vector_addr][`SLICE_TILE_ID];
    wire reset = test_vectors[test_vector_addr][`SLICE_RESET];

    // Output wires
    wire [0:0] out_BUS1_S0_T0;
    wire [0:0] out_BUS1_S0_T1;
    wire [0:0] out_BUS1_S0_T2;
    wire [0:0] out_BUS1_S0_T3;
    wire [0:0] out_BUS1_S0_T4;
    wire [0:0] out_BUS1_S1_T0;
    wire [0:0] out_BUS1_S1_T1;
    wire [0:0] out_BUS1_S1_T2;
    wire [0:0] out_BUS1_S1_T3;
    wire [0:0] out_BUS1_S1_T4;
    wire [0:0] out_BUS1_S2_T0;
    wire [0:0] out_BUS1_S2_T1;
    wire [0:0] out_BUS1_S2_T2;
    wire [0:0] out_BUS1_S2_T3;
    wire [0:0] out_BUS1_S2_T4;
    wire [0:0] out_BUS1_S3_T0;
    wire [0:0] out_BUS1_S3_T1;
    wire [0:0] out_BUS1_S3_T2;
    wire [0:0] out_BUS1_S3_T3;
    wire [0:0] out_BUS1_S3_T4;
    wire [15:0] out_BUS16_S0_T0;
    wire [15:0] out_BUS16_S0_T1;
    wire [15:0] out_BUS16_S0_T2;
    wire [15:0] out_BUS16_S0_T3;
    wire [15:0] out_BUS16_S0_T4;
    wire [15:0] out_BUS16_S1_T0;
    wire [15:0] out_BUS16_S1_T1;
    wire [15:0] out_BUS16_S1_T2;
    wire [15:0] out_BUS16_S1_T3;
    wire [15:0] out_BUS16_S1_T4;
    wire [15:0] out_BUS16_S2_T0;
    wire [15:0] out_BUS16_S2_T1;
    wire [15:0] out_BUS16_S2_T2;
    wire [15:0] out_BUS16_S2_T3;
    wire [15:0] out_BUS16_S2_T4;
    wire [15:0] out_BUS16_S3_T0;
    wire [15:0] out_BUS16_S3_T1;
    wire [15:0] out_BUS16_S3_T2;
    wire [15:0] out_BUS16_S3_T3;
    wire [15:0] out_BUS16_S3_T4;
    wire [0:0] gout;
    wire [31:0] read_data;

    // Clock
    reg clk_in;

    // Power Supplies
    

    // DUT
    pe_tile_new_unq1 dut (
        .config_addr(config_addr),
        .config_data(config_data),
        .config_read(config_read),
        .config_write(config_write),
        .in_BUS1_S0_T0(in_BUS1_S0_T0),
        .in_BUS1_S0_T1(in_BUS1_S0_T1),
        .in_BUS1_S0_T2(in_BUS1_S0_T2),
        .in_BUS1_S0_T3(in_BUS1_S0_T3),
        .in_BUS1_S0_T4(in_BUS1_S0_T4),
        .in_BUS1_S1_T0(in_BUS1_S1_T0),
        .in_BUS1_S1_T1(in_BUS1_S1_T1),
        .in_BUS1_S1_T2(in_BUS1_S1_T2),
        .in_BUS1_S1_T3(in_BUS1_S1_T3),
        .in_BUS1_S1_T4(in_BUS1_S1_T4),
        .in_BUS1_S2_T0(in_BUS1_S2_T0),
        .in_BUS1_S2_T1(in_BUS1_S2_T1),
        .in_BUS1_S2_T2(in_BUS1_S2_T2),
        .in_BUS1_S2_T3(in_BUS1_S2_T3),
        .in_BUS1_S2_T4(in_BUS1_S2_T4),
        .in_BUS1_S3_T0(in_BUS1_S3_T0),
        .in_BUS1_S3_T1(in_BUS1_S3_T1),
        .in_BUS1_S3_T2(in_BUS1_S3_T2),
        .in_BUS1_S3_T3(in_BUS1_S3_T3),
        .in_BUS1_S3_T4(in_BUS1_S3_T4),
        .in_BUS16_S0_T0(in_BUS16_S0_T0),
        .in_BUS16_S0_T1(in_BUS16_S0_T1),
        .in_BUS16_S0_T2(in_BUS16_S0_T2),
        .in_BUS16_S0_T3(in_BUS16_S0_T3),
        .in_BUS16_S0_T4(in_BUS16_S0_T4),
        .in_BUS16_S1_T0(in_BUS16_S1_T0),
        .in_BUS16_S1_T1(in_BUS16_S1_T1),
        .in_BUS16_S1_T2(in_BUS16_S1_T2),
        .in_BUS16_S1_T3(in_BUS16_S1_T3),
        .in_BUS16_S1_T4(in_BUS16_S1_T4),
        .in_BUS16_S2_T0(in_BUS16_S2_T0),
        .in_BUS16_S2_T1(in_BUS16_S2_T1),
        .in_BUS16_S2_T2(in_BUS16_S2_T2),
        .in_BUS16_S2_T3(in_BUS16_S2_T3),
        .in_BUS16_S2_T4(in_BUS16_S2_T4),
        .in_BUS16_S3_T0(in_BUS16_S3_T0),
        .in_BUS16_S3_T1(in_BUS16_S3_T1),
        .in_BUS16_S3_T2(in_BUS16_S3_T2),
        .in_BUS16_S3_T3(in_BUS16_S3_T3),
        .in_BUS16_S3_T4(in_BUS16_S3_T4),
        .gin_0(gin_0),
        .gin_1(gin_1),
        .gin_2(gin_2),
        .gin_3(gin_3),
        .tile_id(tile_id),
        .reset(reset),
        .out_BUS1_S0_T0(out_BUS1_S0_T0),
        .out_BUS1_S0_T1(out_BUS1_S0_T1),
        .out_BUS1_S0_T2(out_BUS1_S0_T2),
        .out_BUS1_S0_T3(out_BUS1_S0_T3),
        .out_BUS1_S0_T4(out_BUS1_S0_T4),
        .out_BUS1_S1_T0(out_BUS1_S1_T0),
        .out_BUS1_S1_T1(out_BUS1_S1_T1),
        .out_BUS1_S1_T2(out_BUS1_S1_T2),
        .out_BUS1_S1_T3(out_BUS1_S1_T3),
        .out_BUS1_S1_T4(out_BUS1_S1_T4),
        .out_BUS1_S2_T0(out_BUS1_S2_T0),
        .out_BUS1_S2_T1(out_BUS1_S2_T1),
        .out_BUS1_S2_T2(out_BUS1_S2_T2),
        .out_BUS1_S2_T3(out_BUS1_S2_T3),
        .out_BUS1_S2_T4(out_BUS1_S2_T4),
        .out_BUS1_S3_T0(out_BUS1_S3_T0),
        .out_BUS1_S3_T1(out_BUS1_S3_T1),
        .out_BUS1_S3_T2(out_BUS1_S3_T2),
        .out_BUS1_S3_T3(out_BUS1_S3_T3),
        .out_BUS1_S3_T4(out_BUS1_S3_T4),
        .out_BUS16_S0_T0(out_BUS16_S0_T0),
        .out_BUS16_S0_T1(out_BUS16_S0_T1),
        .out_BUS16_S0_T2(out_BUS16_S0_T2),
        .out_BUS16_S0_T3(out_BUS16_S0_T3),
        .out_BUS16_S0_T4(out_BUS16_S0_T4),
        .out_BUS16_S1_T0(out_BUS16_S1_T0),
        .out_BUS16_S1_T1(out_BUS16_S1_T1),
        .out_BUS16_S1_T2(out_BUS16_S1_T2),
        .out_BUS16_S1_T3(out_BUS16_S1_T3),
        .out_BUS16_S1_T4(out_BUS16_S1_T4),
        .out_BUS16_S2_T0(out_BUS16_S2_T0),
        .out_BUS16_S2_T1(out_BUS16_S2_T1),
        .out_BUS16_S2_T2(out_BUS16_S2_T2),
        .out_BUS16_S2_T3(out_BUS16_S2_T3),
        .out_BUS16_S2_T4(out_BUS16_S2_T4),
        .out_BUS16_S3_T0(out_BUS16_S3_T0),
        .out_BUS16_S3_T1(out_BUS16_S3_T1),
        .out_BUS16_S3_T2(out_BUS16_S3_T2),
        .out_BUS16_S3_T3(out_BUS16_S3_T3),
        .out_BUS16_S3_T4(out_BUS16_S3_T4),
        .gout(gout),
        .read_data(read_data),
        .clk_in(clk_in)
        );

    // Toggle clock
    always begin
        if (test_vector_addr < `ACTIVE_CYCLE_NUMBER-500-5) begin
            #(`CONFIG_CLK_PERIOD/2) clk_in =~clk_in;
        end else begin
            #(`CLK_PERIOD/2) clk_in =~clk_in;
        end
    end

    // Read vectors
    initial begin
      $readmemh("inputs/test_vectors.txt", test_vectors);
      $readmemh("inputs/test_outputs.txt", test_outputs);
      clk_in <= 0;
      test_vector_addr <= 0;
    end
  
    // Stimulate DUT using input vectors
    always @(negedge clk_in) begin
        // Don't change the inputs right after the clock edge because that will cause problems in GLS
        test_vector_addr <= # `ASSIGNMENT_DELAY (test_vector_addr + 1);
        test_vector <= test_vectors[test_vector_addr];
        test_output <= test_outputs[test_vector_addr];

        // Start toggling after active_cycle_number
        if (test_vector_addr == `ACTIVE_CYCLE_NUMBER) begin
            $set_toggle_region(testbench);
            $toggle_start;
            $display("Started toggle measurement at %d...", `ACTIVE_CYCLE_NUMBER);
        end

        // Stop toggling after last output and finish
        if (test_vector_addr >= `NUM_TEST_VECTORS) begin
            $toggle_stop;
            $toggle_report("outputs/out.saif", 1e-12, testbench);
            $finish(2);
        end

        // Output checks
        if (out_BUS1_S0_T0 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S0_T0] || ($isunknown(out_BUS1_S0_T0) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S0_T0: got %x, expected %x", test_vector_addr, out_BUS1_S0_T0, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S0_T0]);
        end

        if (out_BUS1_S0_T1 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S0_T1] || ($isunknown(out_BUS1_S0_T1) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S0_T1: got %x, expected %x", test_vector_addr, out_BUS1_S0_T1, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S0_T1]);
        end

        if (out_BUS1_S0_T2 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S0_T2] || ($isunknown(out_BUS1_S0_T2) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S0_T2: got %x, expected %x", test_vector_addr, out_BUS1_S0_T2, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S0_T2]);
        end

        if (out_BUS1_S0_T3 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S0_T3] || ($isunknown(out_BUS1_S0_T3) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S0_T3: got %x, expected %x", test_vector_addr, out_BUS1_S0_T3, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S0_T3]);
        end

        if (out_BUS1_S0_T4 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S0_T4] || ($isunknown(out_BUS1_S0_T4) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S0_T4: got %x, expected %x", test_vector_addr, out_BUS1_S0_T4, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S0_T4]);
        end

        if (out_BUS1_S1_T0 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S1_T0] || ($isunknown(out_BUS1_S1_T0) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S1_T0: got %x, expected %x", test_vector_addr, out_BUS1_S1_T0, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S1_T0]);
        end

        if (out_BUS1_S1_T1 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S1_T1] || ($isunknown(out_BUS1_S1_T1) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S1_T1: got %x, expected %x", test_vector_addr, out_BUS1_S1_T1, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S1_T1]);
        end

        if (out_BUS1_S1_T2 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S1_T2] || ($isunknown(out_BUS1_S1_T2) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S1_T2: got %x, expected %x", test_vector_addr, out_BUS1_S1_T2, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S1_T2]);
        end

        if (out_BUS1_S1_T3 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S1_T3] || ($isunknown(out_BUS1_S1_T3) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S1_T3: got %x, expected %x", test_vector_addr, out_BUS1_S1_T3, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S1_T3]);
        end

        if (out_BUS1_S1_T4 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S1_T4] || ($isunknown(out_BUS1_S1_T4) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S1_T4: got %x, expected %x", test_vector_addr, out_BUS1_S1_T4, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S1_T4]);
        end

        if (out_BUS1_S2_T0 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S2_T0] || ($isunknown(out_BUS1_S2_T0) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S2_T0: got %x, expected %x", test_vector_addr, out_BUS1_S2_T0, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S2_T0]);
        end

        if (out_BUS1_S2_T1 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S2_T1] || ($isunknown(out_BUS1_S2_T1) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S2_T1: got %x, expected %x", test_vector_addr, out_BUS1_S2_T1, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S2_T1]);
        end

        if (out_BUS1_S2_T2 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S2_T2] || ($isunknown(out_BUS1_S2_T2) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S2_T2: got %x, expected %x", test_vector_addr, out_BUS1_S2_T2, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S2_T2]);
        end

        if (out_BUS1_S2_T3 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S2_T3] || ($isunknown(out_BUS1_S2_T3) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S2_T3: got %x, expected %x", test_vector_addr, out_BUS1_S2_T3, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S2_T3]);
        end

        if (out_BUS1_S2_T4 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S2_T4] || ($isunknown(out_BUS1_S2_T4) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S2_T4: got %x, expected %x", test_vector_addr, out_BUS1_S2_T4, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S2_T4]);
        end

        if (out_BUS1_S3_T0 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S3_T0] || ($isunknown(out_BUS1_S3_T0) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S3_T0: got %x, expected %x", test_vector_addr, out_BUS1_S3_T0, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S3_T0]);
        end

        if (out_BUS1_S3_T1 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S3_T1] || ($isunknown(out_BUS1_S3_T1) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S3_T1: got %x, expected %x", test_vector_addr, out_BUS1_S3_T1, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S3_T1]);
        end

        if (out_BUS1_S3_T2 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S3_T2] || ($isunknown(out_BUS1_S3_T2) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S3_T2: got %x, expected %x", test_vector_addr, out_BUS1_S3_T2, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S3_T2]);
        end

        if (out_BUS1_S3_T3 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S3_T3] || ($isunknown(out_BUS1_S3_T3) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S3_T3: got %x, expected %x", test_vector_addr, out_BUS1_S3_T3, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S3_T3]);
        end

        if (out_BUS1_S3_T4 != test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S3_T4] || ($isunknown(out_BUS1_S3_T4) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS1_S3_T4: got %x, expected %x", test_vector_addr, out_BUS1_S3_T4, test_outputs[test_vector_addr][`SLICE_OUT_BUS1_S3_T4]);
        end

        if (out_BUS16_S0_T0 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S0_T0] || ($isunknown(out_BUS16_S0_T0) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S0_T0: got %x, expected %x", test_vector_addr, out_BUS16_S0_T0, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S0_T0]);
        end

        if (out_BUS16_S0_T1 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S0_T1] || ($isunknown(out_BUS16_S0_T1) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S0_T1: got %x, expected %x", test_vector_addr, out_BUS16_S0_T1, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S0_T1]);
        end

        if (out_BUS16_S0_T2 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S0_T2] || ($isunknown(out_BUS16_S0_T2) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S0_T2: got %x, expected %x", test_vector_addr, out_BUS16_S0_T2, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S0_T2]);
        end

        if (out_BUS16_S0_T3 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S0_T3] || ($isunknown(out_BUS16_S0_T3) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S0_T3: got %x, expected %x", test_vector_addr, out_BUS16_S0_T3, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S0_T3]);
        end

        if (out_BUS16_S0_T4 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S0_T4] || ($isunknown(out_BUS16_S0_T4) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S0_T4: got %x, expected %x", test_vector_addr, out_BUS16_S0_T4, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S0_T4]);
        end

        if (out_BUS16_S1_T0 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S1_T0] || ($isunknown(out_BUS16_S1_T0) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S1_T0: got %x, expected %x", test_vector_addr, out_BUS16_S1_T0, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S1_T0]);
        end

        if (out_BUS16_S1_T1 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S1_T1] || ($isunknown(out_BUS16_S1_T1) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S1_T1: got %x, expected %x", test_vector_addr, out_BUS16_S1_T1, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S1_T1]);
        end

        if (out_BUS16_S1_T2 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S1_T2] || ($isunknown(out_BUS16_S1_T2) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S1_T2: got %x, expected %x", test_vector_addr, out_BUS16_S1_T2, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S1_T2]);
        end

        if (out_BUS16_S1_T3 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S1_T3] || ($isunknown(out_BUS16_S1_T3) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S1_T3: got %x, expected %x", test_vector_addr, out_BUS16_S1_T3, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S1_T3]);
        end

        if (out_BUS16_S1_T4 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S1_T4] || ($isunknown(out_BUS16_S1_T4) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S1_T4: got %x, expected %x", test_vector_addr, out_BUS16_S1_T4, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S1_T4]);
        end

        if (out_BUS16_S2_T0 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S2_T0] || ($isunknown(out_BUS16_S2_T0) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S2_T0: got %x, expected %x", test_vector_addr, out_BUS16_S2_T0, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S2_T0]);
        end

        if (out_BUS16_S2_T1 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S2_T1] || ($isunknown(out_BUS16_S2_T1) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S2_T1: got %x, expected %x", test_vector_addr, out_BUS16_S2_T1, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S2_T1]);
        end

        if (out_BUS16_S2_T2 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S2_T2] || ($isunknown(out_BUS16_S2_T2) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S2_T2: got %x, expected %x", test_vector_addr, out_BUS16_S2_T2, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S2_T2]);
        end

        if (out_BUS16_S2_T3 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S2_T3] || ($isunknown(out_BUS16_S2_T3) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S2_T3: got %x, expected %x", test_vector_addr, out_BUS16_S2_T3, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S2_T3]);
        end

        if (out_BUS16_S2_T4 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S2_T4] || ($isunknown(out_BUS16_S2_T4) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S2_T4: got %x, expected %x", test_vector_addr, out_BUS16_S2_T4, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S2_T4]);
        end

        if (out_BUS16_S3_T0 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S3_T0] || ($isunknown(out_BUS16_S3_T0) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S3_T0: got %x, expected %x", test_vector_addr, out_BUS16_S3_T0, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S3_T0]);
        end

        if (out_BUS16_S3_T1 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S3_T1] || ($isunknown(out_BUS16_S3_T1) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S3_T1: got %x, expected %x", test_vector_addr, out_BUS16_S3_T1, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S3_T1]);
        end

        if (out_BUS16_S3_T2 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S3_T2] || ($isunknown(out_BUS16_S3_T2) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S3_T2: got %x, expected %x", test_vector_addr, out_BUS16_S3_T2, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S3_T2]);
        end

        if (out_BUS16_S3_T3 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S3_T3] || ($isunknown(out_BUS16_S3_T3) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S3_T3: got %x, expected %x", test_vector_addr, out_BUS16_S3_T3, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S3_T3]);
        end

        if (out_BUS16_S3_T4 != test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S3_T4] || ($isunknown(out_BUS16_S3_T4) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: out_BUS16_S3_T4: got %x, expected %x", test_vector_addr, out_BUS16_S3_T4, test_outputs[test_vector_addr][`SLICE_OUT_BUS16_S3_T4]);
        end

        if (gout != test_outputs[test_vector_addr][`SLICE_GOUT] || ($isunknown(gout) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: gout: got %x, expected %x", test_vector_addr, gout, test_outputs[test_vector_addr][`SLICE_GOUT]);
        end

        if (read_data != test_outputs[test_vector_addr][`SLICE_READ_DATA] || ($isunknown(read_data) && test_vector_addr != 0)) begin
            $display("mismatch cycle %d: read_data: got %x, expected %x", test_vector_addr, read_data, test_outputs[test_vector_addr][`SLICE_READ_DATA]);
        end
    end
  
    // Elaboration tasks
    initial begin
        // Annotate delays
        $sdf_annotate("design/design.sdf", testbench.dut, ,"testbench_sdf.log", "MAXIMUM");

        // Dump to VCD
        $dumpfile("outputs/out.vcd");
        $dumpvars(0, dut);
    end
endmodule