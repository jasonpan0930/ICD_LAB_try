`timescale 1ns / 1ps

module tb_mamba_core();

    parameter D_IN       = 1;
    parameter D_MODEL    = 8;
    parameter D_STATE    = 8;
    parameter SEQ_LEN    = 187;
    parameter DATA_WIDTH = 16;
    parameter WGHT_WIDTH = 8;
    
    reg  clk;
    reg  rst_n;
    wire rst_weights_n;
    assign rst_weights_n = rst_n;
    reg  i_valid;
    reg  signed [DATA_WIDTH-1:0] i_data;
    
    wire o_ready;
    wire o_valid;
    wire [1:0] o_class;

    reg [15:0] test_mem [0:SEQ_LEN-1];
    integer i;

    mamba_core #(
        .D_IN(D_IN), .D_MODEL(D_MODEL), .D_STATE(D_STATE),
        .SEQ_LEN(SEQ_LEN), .DATA_WIDTH(DATA_WIDTH), .WGHT_WIDTH(WGHT_WIDTH)
    ) uut (
        .clk(clk), .rst_n(rst_n), .rst_weights_n(rst_weights_n), .i_valid(i_valid), .i_data(i_data),
        .w_we(1'b0), .w_addr(9'd0), .w_data(8'd0),
        .o_ready(o_ready),
        .o_valid(o_valid), .o_class(o_class)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        $readmemh("Pattern/test_data.hex", test_mem);
        
        rst_n   = 1'b0;
        i_valid = 1'b0;
        i_data  = 16'd0;
        
        #25;
        rst_n = 1'b1;
        #10;
        
        $display("===========================================");
        $display("🚀 開始單筆 Debug 模擬...");
        $display("===========================================");

        for (i = 0; i < SEQ_LEN; i = i + 1) begin
            @(posedge clk);  
            i_valid <= 1'b1;
            i_data  <= test_mem[i];
            
            // 🌟 插入這段：在 t=0 時，等組合邏輯算完 (延遲 1ns)，印出硬體內部訊號
            if (i == 0) begin
                #1; 
                $display("\n🛠️ [Verilog 實際數據] t=0, Channel 0");
                $display("  - xt[0]      : %d", $signed(uut.u_datapath.xt[0]));
                $display("  - dt_raw[0]  : %d", $signed(uut.u_datapath.dt_raw[0]));
                $display("  - dt[0]      : %d", $signed(uut.u_datapath.dt[0]));
                $display("  - B_val[0]   : %d", $signed(uut.u_datapath.B_val[0]));
                $display("  - C_val[0]   : %d", $signed(uut.u_datapath.C_val[0]));
                $display("  - dA[0][0]   : %d", $signed(uut.u_datapath.dA[0][0]));
                $display("  - dB[0][0]   : %d", $signed(uut.u_datapath.dB[0][0]));
                $display("  - next_h[0][0]: %d", $signed(uut.u_datapath.o_next_h[0][0]));
                $display("  - residual[0]: %d", $signed(uut.u_datapath.residual[0]));
                $display("  - yt[0]      : %d", $signed(uut.u_datapath.yt[0]));
                $display("-" * 40);
            end
        end

        @(posedge clk);
        i_valid <= 1'b0;

        wait(o_valid == 1'b1);
        $display("\n🎯 最終預測類別 (o_class): %d\n", o_class);
        
        #50;
        $finish;
    end
endmodule