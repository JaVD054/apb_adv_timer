`timescale 1ns/1ns

parameter APB_ADDR_WIDTH = 12;
parameter EXTSIG_NUM     = 32;
parameter TIMER_NBITS    = 16;

module tb;

    // Inputs
    logic HCLK = 0;
    logic HRESETn;
    logic [APB_ADDR_WIDTH-1:0] PADDR;
    logic [31:0] PWDATA;
    logic PWRITE;
    logic PSEL;
    logic PENABLE;
    logic dft_cg_enable_i;
    logic low_speed_clk_i = 0;
    logic [EXTSIG_NUM-1:0] ext_sig_i;

    // Outputs
    logic [31:0] PRDATA;
    logic PREADY;
    logic PSLVERR;
    logic [3:0] events_o;
    logic [3:0] ch_0_o;
    logic [3:0] ch_1_o;
    logic [3:0] ch_2_o;
    logic [3:0] ch_3_o;

    always 
        #10 HCLK = ~HCLK;

    always 
        #50 low_speed_clk_i = ~low_speed_clk_i;

    // Instantiate the DUT
    apb_adv_timer #(
        .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
        .EXTSIG_NUM(EXTSIG_NUM),
        .TIMER_NBITS(TIMER_NBITS)
    ) dut (
        .HCLK(HCLK),
        .HRESETn(HRESETn),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PWRITE(PWRITE),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PRDATA(PRDATA),
        .PREADY(PREADY),
        .PSLVERR(PSLVERR),
        .dft_cg_enable_i(dft_cg_enable_i),
        .low_speed_clk_i(low_speed_clk_i),
        .ext_sig_i(ext_sig_i),
        .events_o(events_o),
        .ch_0_o(ch_0_o),
        .ch_1_o(ch_1_o),
        .ch_2_o(ch_2_o),
        .ch_3_o(ch_3_o)
    );

    // // create dumpfile
    // initial begin
    //     $dumpfile("tb.vcd");
    //     $dumpvars(0, tb);
    // end

    initial begin
        HRESETn = 0;
        #100 HRESETn = 1;
        #5 PSEL = 1;
        PENABLE = 1;
        PWRITE = 1;
        PADDR = 8;
        PWDATA = {16'b10001, 16'b0};
        #100;
        PADDR = 0;
        PWDATA = {{27{1'b0}}, 5'b10001};
        #10000;
        
        $stop;


    end

endmodule