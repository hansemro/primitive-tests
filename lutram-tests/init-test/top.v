// SPDX-License-Identifier: MIT
// Copyright (c) 2024 Hansem Ro <hansemro@outlook.com>

// LUTRAM INIT Parameter Test

`default_nettype none

// comment DIFF_CLK define to use single-ended clock
`define DIFF_CLK

// uncomment one of the TEST_* comments to instantiate the LUTRAM for testing
//`define TEST_RAMS32
//`define TEST_RAMD32
//`define TEST_RAMS64E
//`define TEST_RAMD64E
//`define TEST_RAM32X1S
//`define TEST_RAM64X1S
//`define TEST_RAM128X1S
//`define TEST_RAM256X1S
//`define TEST_RAM32X1D
//`define TEST_RAM64X1D
//`define TEST_RAM128X1D
//`define TEST_RAM32M
//`define TEST_RAM64M

module top (
`ifdef DIFF_CLK
    input wire clk_p_i,
    input wire clk_n_i,
`else
    input wire clk_i,
`endif
    output wire [7:0] q_o
);

    parameter [255:0] INIT = 256'hDEADBEEF0150BAD0CAFEF00D0F0FFFFF0123456789ABCDEFFEDCBA9876543210;

    wire clk;
    wire clk_ibufg;
`ifdef DIFF_CLK
    IBUFDS ibuf_inst (.I(clk_p_i), .IB(clk_n_i), .O(clk_ibufg));
    BUFG bufg_inst (.I(clk_ibufg), .O(clk));
`else
    BUFG bufg_inst (.I(clk_i), .O(clk));
`endif

// Instantiate LUTRAM with address pins tied-high (to avoid tied-low input nextpnr optimization)
`ifdef TEST_RAMS32
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAMS32 #(
        .IS_CLK_INVERTED(1'b0),
        .INIT(INIT[31:0])
    ) rams32 (
        .CLK(clk),
        .WE(1'b1),
        .I(1'b1),
        .O(q_o[0]),
        .ADR4(1'b1),
        .ADR3(1'b1),
        .ADR2(1'b1),
        .ADR1(1'b1),
        .ADR0(1'b1)
    );
`elsif TEST_RAMD32
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAMD32 #(
        .IS_CLK_INVERTED(1'b0),
        .INIT(INIT[31:0])
    ) ramd32 (
        .CLK(clk),
        .WE(1'b1),
        .I(1'b1),
        .O(q_o[0]),
        .WADR4(1'b1),
        .WADR3(1'b1),
        .WADR2(1'b1),
        .WADR1(1'b1),
        .WADR0(1'b1),
        .RADR4(1'b1),
        .RADR3(1'b1),
        .RADR2(1'b1),
        .RADR1(1'b1),
        .RADR0(1'b1)
    );
`elsif TEST_RAMS64E
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAMS64E #(
        .IS_CLK_INVERTED(1'b0),
        .INIT(INIT[63:0])
    ) rams64e (
        .CLK(clk),
        .WE(1'b1),
        .I(1'b1),
        .O(q_o[0]),
        .WADR7(1'b1),
        .WADR6(1'b1),
        .WADR5(1'b1),
        .WADR4(1'b1),
        .WADR3(1'b1),
        .WADR2(1'b1),
        .WADR1(1'b1),
        .WADR0(1'b1),
        .RADR5(1'b1),
        .RADR4(1'b1),
        .RADR3(1'b1),
        .RADR2(1'b1),
        .RADR1(1'b1),
        .RADR0(1'b1)
    );
`elsif TEST_RAMD64E
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAMD64E #(
        .IS_CLK_INVERTED(1'b0),
        .INIT(INIT[63:0])
    ) ramd64e (
        .CLK(clk),
        .WE(1'b1),
        .I(1'b1),
        .O(q_o[0]),
        .WADR4(1'b1),
        .WADR3(1'b1),
        .WADR2(1'b1),
        .WADR1(1'b1),
        .WADR0(1'b1),
        .RADR4(1'b1),
        .RADR3(1'b1),
        .RADR2(1'b1),
        .RADR1(1'b1),
        .RADR0(1'b1)
    );
`elsif TEST_RAM32X1S
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAM32X1S #(
        .IS_WCLK_INVERTED(1'b0),
        .INIT(INIT[31:0])
    ) ram32x1s (
        .WCLK(clk),
        .WE(1'b1),
        .D(1'b1),
        .O(q_o[0]),
        .A4(1'b1),
        .A3(1'b1),
        .A2(1'b1),
        .A1(1'b1),
        .A0(1'b1)
    );
`elsif TEST_RAM64X1S
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAM64X1S #(
        .IS_WCLK_INVERTED(1'b0),
        .INIT(INIT[63:0])
    ) ram64x1s (
        .WCLK(clk),
        .WE(1'b1),
        .D(1'b1),
        .O(q_o[0]),
        .A5(1'b1),
        .A4(1'b1),
        .A3(1'b1),
        .A2(1'b1),
        .A1(1'b1),
        .A0(1'b1)
    );
`elsif TEST_RAM128X1S
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAM128X1S #(
        .IS_WCLK_INVERTED(1'b0),
        .INIT(INIT[127:0])
    ) ram128x1s (
        .WCLK(clk),
        .WE(1'b1),
        .D(1'b1),
        .O(q_o[0]),
        .A6(1'b1),
        .A5(1'b1),
        .A4(1'b1),
        .A3(1'b1),
        .A2(1'b1),
        .A1(1'b1),
        .A0(1'b1)
    );
`elsif TEST_RAM256X1S
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAM256X1S #(
        .IS_WCLK_INVERTED(1'b0),
        .INIT(INIT[255:0])
    ) ram256x1s (
        .WCLK(clk),
        .WE(1'b1),
        .D(1'b1),
        .O(q_o[0]),
        .A(8'b11111111)
    );
`elsif TEST_RAM32X1D
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAM32X1D #(
        .IS_WCLK_INVERTED(1'b0),
        .INIT(INIT[31:0])
    ) ram32x1d (
        .WCLK(clk),
        .WE(1'b1),
        .D(1'b1),
        .SPO(q_o[0]),
        .DPO(q_o[1]),
        .A4(1'b1),
        .A3(1'b1),
        .A2(1'b1),
        .A1(1'b1),
        .A0(1'b1),
        .DPRA4(1'b1),
        .DPRA3(1'b1),
        .DPRA2(1'b1),
        .DPRA1(1'b1),
        .DPRA0(1'b1)
    );
`elsif TEST_RAM64X1D
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAM64X1D #(
        .IS_WCLK_INVERTED(1'b0),
        .INIT(INIT[63:0])
    ) ram64x1d (
        .WCLK(clk),
        .WE(1'b1),
        .D(1'b1),
        .SPO(q_o[0]),
        .DPO(q_o[1]),
        .A5(1'b1),
        .A4(1'b1),
        .A3(1'b1),
        .A2(1'b1),
        .A1(1'b1),
        .A0(1'b1),
        .DPRA5(1'b1),
        .DPRA4(1'b1),
        .DPRA3(1'b1),
        .DPRA2(1'b1),
        .DPRA1(1'b1),
        .DPRA0(1'b1)
    );
`elsif TEST_RAM128X1D
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAM128X1D #(
        .IS_WCLK_INVERTED(1'b0),
        .INIT(INIT[127:0])
    ) ram128x1d (
        .WCLK(clk),
        .WE(1'b1),
        .D(1'b1),
        .SPO(q_o[0]),
        .DPO(q_o[1]),
        .A(6'b111111),
        .DPRA(6'b111111)
    );
`elsif TEST_RAM32M
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAM32M #(
        .IS_WCLK_INVERTED(1'b0),
        .INIT_A(INIT[31:0]),
        .INIT_B(INIT[63:32]),
        .INIT_C(INIT[95:64]),
        .INIT_D(INIT[127:96])
    ) ram32m (
        .WCLK(clk),
        .WE(1'b1),
        .DID(2'b11),
        .DIC(2'b11),
        .DIB(2'b11),
        .DIA(2'b11),
        .DOD(q_o[1:0]),
        .DOC(q_o[3:2]),
        .DOB(q_o[5:4]),
        .DOA(q_o[7:6]),
        .ADDRD(5'b11111),
        .ADDRC(5'b11111),
        .ADDRB(5'b11111),
        .ADDRA(5'b11111)
    );
`elsif TEST_RAM64M
`ifdef YOSYS
    (* keep *)
`elsif VIVADO
    (* KEEP, DONT_TOUCH *)
`endif
    RAM64M #(
        .IS_WCLK_INVERTED(1'b0),
        .INIT_A(INIT[63:0]),
        .INIT_B(INIT[127:64]),
        .INIT_C(INIT[191:128]),
        .INIT_D(INIT[255:192])
    ) ram64m (
        .WCLK(clk),
        .WE(1'b1),
        .DID(2'b11),
        .DIC(2'b11),
        .DIB(2'b11),
        .DIA(2'b11),
        .DOD(q_o[1:0]),
        .DOC(q_o[3:2]),
        .DOB(q_o[5:4]),
        .DOA(q_o[7:6]),
        .ADDRD(6'b111111),
        .ADDRC(6'b111111),
        .ADDRB(6'b111111),
        .ADDRA(6'b111111)
    );
`endif

endmodule
