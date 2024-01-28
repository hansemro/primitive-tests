`default_nettype none   //do not allow undeclared wires

module blinky (
    input  wire clk_p,
    input  wire clk_n,
    output wire led,
    output wire [6:0] clkout
    );

    wire [6:0] pll_clkout;
    wire feedback;

    wire clk_ibufgds;
    IBUFDS ibuf_inst (.I(clk_p), .IB(clk_n), .O(clk_ibufgds));

    MMCME2_ADV #(
        .BANDWIDTH            ("OPTIMIZED"),
        .CLKOUT4_CASCADE      ("FALSE"),
        .COMPENSATION         ("ZHOLD"),
        .STARTUP_WAIT         ("FALSE"),
        .DIVCLK_DIVIDE        (1),
        .CLKFBOUT_MULT_F      (5.000),  // f_vco = 200 MHz * 5.0 = 1000 MHz
        .CLKFBOUT_PHASE       (0.000),
        .CLKFBOUT_USE_FINE_PS ("FALSE"),
        .CLKOUT0_DIVIDE_F     (20.000), // f_vco / 20.0 = 50 MHz
        .CLKOUT0_PHASE        (0.000),
        .CLKOUT0_DUTY_CYCLE   (0.500),
        .CLKOUT0_USE_FINE_PS  ("FALSE"),
        .CLKOUT1_DIVIDE       (40.000), // f_vco / 40.0 = 25 MHz
        .CLKOUT1_PHASE        (0.000),
        .CLKOUT1_DUTY_CYCLE   (0.500),
        .CLKOUT2_DIVIDE       (80.000), // f_vco / 80.0 = 12.5 MHz
        .CLKOUT2_PHASE        (0.000),
        .CLKOUT2_DUTY_CYCLE   (0.500),
        .CLKOUT3_DIVIDE       (100.000), // f_vco / 100.0 = 10 MHz
        .CLKOUT3_PHASE        (0.000),
        .CLKOUT3_DUTY_CYCLE   (0.500),
        .CLKOUT4_DIVIDE       (100.000), // 10 MHz
        .CLKOUT4_PHASE        (0.000),
        .CLKOUT4_DUTY_CYCLE   (0.500),
        .CLKOUT5_DIVIDE       (100.000), // 10 MHz
        .CLKOUT5_PHASE        (0.000),
        .CLKOUT5_DUTY_CYCLE   (0.500),
        .CLKOUT6_DIVIDE       (100.000), // 10 MHz
        .CLKOUT6_PHASE        (0.000),
        .CLKOUT6_DUTY_CYCLE   (0.500),
        .CLKIN1_PERIOD        (5.000)
    ) MMCME2_ADV (
        .PSINCDEC(1'b0),
        .CLKFBIN(feedback),
        .CLKIN1(clk_ibufgds),
        .CLKIN2(1'b0),
        .CLKINSEL(1'b1),
        .PWRDWN(1'b0),
        .RST(1'b0),
        .CLKFBOUT(feedback),
        .CLKOUT0(pll_clkout[0]),
        .CLKOUT1(pll_clkout[1]),
        .CLKOUT2(pll_clkout[2]),
        .CLKOUT3(pll_clkout[3]),
        .CLKOUT4(pll_clkout[4]),
        .CLKOUT5(pll_clkout[5]),
        .CLKOUT6(pll_clkout[6]),
        .LOCKED()
    );

    genvar i;
    generate
        for (i = 0; i < 7; i = i + 1) begin : bufg_gen
            BUFG bufg_inst (.I(pll_clkout[i]), .O(clkout[i]));
        end
    endgenerate

    reg [24:0] r_count = 0;

    always @(posedge(clkout[0])) r_count <= r_count + 1;

    assign led = r_count[24];
endmodule
