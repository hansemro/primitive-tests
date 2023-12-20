`define DIFF_CLK

module ram32x1s (
`ifdef DIFF_CLK
        input clk_p_i, // 200 MHz for KC705
        input clk_n_i,
`else
        input clk_i,
`endif
        input rst_i,
        output q_o
    );

    parameter [31:0] DIV_COUNTER_END = {8'b0,{24{1'b1}}};
    localparam A_WIDTH = 5;
    localparam D_WIDTH = 1;

    wire clk;
`ifdef DIFF_CLK
    wire clk_ibufg;

    IBUFDS ibuf_inst (.I(clk_p_i), .IB(clk_n_i), .O(clk_ibufg));
    BUFG bufg_inst (.I(clk_ibufg), .O(clk));
`else
    assign clk = clk_i;
`endif

    reg clk_div;
    reg [31:0] div_counter;
    reg rst;
    reg temp;

    wire div_counter_end;
    assign div_counter_end = div_counter >= DIV_COUNTER_END;

    // Clock division + reset generation
    always @(posedge clk) begin
        if (rst_i) begin
            div_counter <= 32'b0;
            clk_div <= 1'b0;
            rst <= 1'b1;
            temp <= 1'b1;
        end else begin
            if (div_counter_end) begin
                clk_div <= ~clk_div;
                div_counter <= 32'b0;
                {rst,temp} <= {temp,1'b0};
            end else begin
                div_counter <= div_counter + 1'b1;
            end
        end
    end

    localparam INITIAL=3'b000;
    localparam CLEAR=3'b001;
    localparam WRITE=3'b010;
    localparam READ=3'b011;
    localparam FINISH=3'b100;

    reg [2:0] ps, ns;

    reg [(2**A_WIDTH)-1:0] counter;
    reg [(2**A_WIDTH):0] counter_next;

    wire counter_end;
    assign counter_end = counter == {A_WIDTH{1'b1}};

    wire we;
    assign we = (ps == WRITE) || (ps == CLEAR);

    reg data;

    // FSM
    always @(*) begin
        ns = ps;
        data = 1'b0;
        if (counter_end)
            counter_next = {(2**A_WIDTH){1'b0}};
        else
            counter_next = counter + 1'b1;
        case(ps)
            INITIAL: begin
                ns = CLEAR;
                counter_next = {(2**A_WIDTH){1'b0}};
            end
            CLEAR: begin
                if (counter_end) begin
                    ns = WRITE;
                end
            end
            WRITE: begin
                data = counter[0];
                if (counter_end) begin
                    ns = READ;
                end
            end
            READ: begin
                if (counter_end) begin
                    ns = FINISH;
                end
            end
            FINISH: begin
                counter_next = {(2**A_WIDTH){1'b0}};
            end
            default: begin
                ns = INITIAL;
                counter_next = {(2**A_WIDTH){1'b0}};
            end
        endcase
    end

    always @(posedge clk_div) begin
        if (rst) begin
            ps <= INITIAL;
            counter <= {(2**A_WIDTH){1'b0}};
        end
        else begin
            ps <= ns;
            counter <= counter_next;
        end
    end

    // DUT
    RAM32X1S ram (
        .O(q_o),
        .D(data),
        .WCLK(clk_div),
        .WE(we),
        .A0(counter[0]),
        .A1(counter[1]),
        .A2(counter[2]),
        .A3(counter[3]),
        .A4(counter[4])
    );

endmodule
