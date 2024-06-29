// Copyright (c) 2024 openXC7
// SPDX-License-Identifier: BSD-3-Clause

// XC7 LUTRAM (Posedge +) Negedge Write Test (over JTAG)

`default_nettype none

`ifndef LUTRAM_INIT
`define LUTRAM_INIT 256'hDEADBEEF_0150BAD0_CAFEF00D_0F0FFFFF_01234567_89ABCDEF_FEDCBA98_76543210
`endif

module top (
    output wire [2:0] led_o
);
    localparam integer USER_IN_PORT = 3; // Valid options: 1-4
    localparam integer USER_IN_REG_WIDTH = 3;

    wire jtag_in_drck;
    wire jtag_in_capture;
    wire jtag_in_shift;
    wire jtag_in_tdi;
    wire jtag_in_tdo;

    reg [USER_IN_REG_WIDTH-1:0] instr = {USER_IN_REG_WIDTH{1'b0}};
    reg [USER_IN_REG_WIDTH-1:0] instr_buf = {USER_IN_REG_WIDTH{1'b0}};

    wire lutram_clk;
    wire lutram_we;
    wire lutram_di;
    wire [1:0] lutram_do;

    BSCANE2 #(
        .JTAG_CHAIN(USER_IN_PORT)
    ) bscan_in (
        .DRCK(jtag_in_drck),
        .CAPTURE(jtag_in_capture),
        .SHIFT(jtag_in_shift),
        .TDI(jtag_in_tdi),
        .TDO(jtag_in_tdo)
    );

    assign jtag_in_tdo = 1'b1;

    assign lutram_we = instr_buf[0];
    assign lutram_di = instr_buf[1];
    assign lutram_clk = instr_buf[2];

    always @(posedge jtag_in_drck)
        if (jtag_in_capture)
            instr_buf <= instr;
        else if (jtag_in_shift)
            instr <= {jtag_in_tdi,instr[USER_IN_REG_WIDTH-1:1]};

    // LUTRAM with non-inverted clock input
    RAM32X1D #(
        .IS_WCLK_INVERTED(1'b0),
        .INIT(32'b0)
    ) ram32x1d_pos (
        .WCLK(lutram_clk),
        .WE(lutram_we),
        .D(lutram_di),
        .SPO(lutram_do[0]),
        .DPO(),
        .A4(1'b0),
        .A3(1'b0),
        .A2(1'b0),
        .A1(1'b0),
        .A0(1'b0),
        .DPRA4(1'b0),
        .DPRA3(1'b0),
        .DPRA2(1'b0),
        .DPRA1(1'b0),
        .DPRA0(1'b0)
    );

    // LUTRAM with inverted clock input
    RAM32X1D #(
        .IS_WCLK_INVERTED(1'b1),
        .INIT(32'b0)
    ) ram32x1d_neg (
        .WCLK(lutram_clk),
        .WE(lutram_we),
        .D(lutram_di),
        .SPO(lutram_do[1]),
        .DPO(),
        .A4(1'b0),
        .A3(1'b0),
        .A2(1'b0),
        .A1(1'b0),
        .A0(1'b0),
        .DPRA4(1'b0),
        .DPRA3(1'b0),
        .DPRA2(1'b0),
        .DPRA1(1'b0),
        .DPRA0(1'b0)
    );

    // assuming active-low LEDs
    assign led_o[0] = !lutram_do[0];
    assign led_o[1] = !lutram_do[1];
    // If falling edge write is broken, then led_o[2] will always stay on
    assign led_o[2] = !(lutram_do[0] == lutram_do[1]);

endmodule
