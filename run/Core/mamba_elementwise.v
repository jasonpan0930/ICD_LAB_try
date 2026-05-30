`timescale 1ns / 1ps

module elementwise_mul #(
    parameter A_WIDTH = 16,
    parameter B_WIDTH = 16,
    parameter OUT_WIDTH = 32
)(
    input  wire signed [A_WIDTH-1:0] i_a,
    input  wire signed [B_WIDTH-1:0] i_b,
    output wire signed [OUT_WIDTH-1:0] o_y
);
    assign o_y = i_a * i_b;
endmodule

module elementwise_add #(
    parameter A_WIDTH = 16,
    parameter B_WIDTH = 16,
    parameter OUT_WIDTH = 16
)(
    input  wire signed [A_WIDTH-1:0] i_a,
    input  wire signed [B_WIDTH-1:0] i_b,
    output wire signed [OUT_WIDTH-1:0] o_y
);
    assign o_y = i_a + i_b;
endmodule

// -----------------------------------------------------------------------------
// Pipeline element for one (i,j):
//   S0: exp_in = round_q88(dt * const_a), dB = round_q88(dt * b)
//   S1: dA = exp(exp_in), Abar_h = round_q88(dA * h), Bxt = round_q88(dB * xt)
//   S2: next_h = Abar_h + Bxt
//
// Usage:
//   Feed one (i,j) tuple every cycle with i_valid=1. Outputs are aligned by
//   o_valid after fixed latency.
// -----------------------------------------------------------------------------
module pipeline_elementwise_multiplier #(
    parameter DATA_WIDTH = 16
)(
    input  wire                         i_clk,
    input  wire                         i_rst_n,
    input  wire                         i_valid,
    input  wire signed [DATA_WIDTH-1:0] i_dt,
    input  wire signed [DATA_WIDTH-1:0] i_const_a,
    input  wire signed [DATA_WIDTH-1:0] i_b,
    input  wire signed [DATA_WIDTH-1:0] i_h,
    input  wire signed [DATA_WIDTH-1:0] i_xt,
    input  wire signed [2*DATA_WIDTH-1:0] i_mul0_result,
    input  wire signed [2*DATA_WIDTH-1:0] i_mul1_result,
    input  wire signed [2*DATA_WIDTH-1:0] i_mul2_result,
    input  wire signed [2*DATA_WIDTH-1:0] i_mul3_result,

    output wire signed [DATA_WIDTH-1:0] o_mul0_a,
    output wire signed [DATA_WIDTH-1:0] o_mul0_b,
    output wire                         o_mul0_valid,
    output wire signed [DATA_WIDTH-1:0] o_mul1_a,
    output wire signed [DATA_WIDTH-1:0] o_mul1_b,
    output wire                         o_mul1_valid,
    output wire signed [DATA_WIDTH-1:0] o_mul2_a,
    output wire signed [DATA_WIDTH-1:0] o_mul2_b,
    output wire                         o_mul2_valid,
    output wire signed [DATA_WIDTH-1:0] o_mul3_a,
    output wire signed [DATA_WIDTH-1:0] o_mul3_b,
    output wire                         o_mul3_valid,
    output reg                          o_valid,
    output reg  signed [DATA_WIDTH-1:0] o_dA,
    output reg  signed [DATA_WIDTH-1:0] o_dB,
    output reg  signed [DATA_WIDTH-1:0] o_Abar_h,
    output reg  signed [DATA_WIDTH-1:0] o_Bxt,
    output reg  signed [DATA_WIDTH-1:0] o_next_h
);

    function signed [DATA_WIDTH-1:0] round_q88;
        input signed [31:0] val;
        begin
            round_q88 = (val >>> 8) + (val[7] ? 1 : 0);
        end
    endfunction

    reg s0_valid, s1_valid;

    reg signed [DATA_WIDTH-1:0] s0_exp_in;
    reg signed [DATA_WIDTH-1:0] s0_dB;
    reg signed [DATA_WIDTH-1:0] s0_h;
    reg signed [DATA_WIDTH-1:0] s0_xt;

    wire signed [DATA_WIDTH-1:0] s1_dA_w;
    reg  signed [DATA_WIDTH-1:0] s1_dA;
    reg  signed [DATA_WIDTH-1:0] s1_dB;
    reg  signed [DATA_WIDTH-1:0] s1_Abar_h;
    reg  signed [DATA_WIDTH-1:0] s1_Bxt;

    wire signed [DATA_WIDTH-1:0]     add_next_h_w;

    assign o_mul0_a     = i_dt;
    assign o_mul0_b     = i_const_a;
    assign o_mul0_valid = i_valid;
    assign o_mul1_a     = i_dt;
    assign o_mul1_b     = i_b;
    assign o_mul1_valid = i_valid;
    assign o_mul2_a     = s1_dA_w;
    assign o_mul2_b     = s0_h;
    assign o_mul2_valid = s0_valid;
    assign o_mul3_a     = s0_dB;
    assign o_mul3_b     = s0_xt;
    assign o_mul3_valid = s0_valid;

    elementwise_add #(
        .A_WIDTH(DATA_WIDTH),
        .B_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(DATA_WIDTH)
    ) u_add_next_h (
        .i_a(s1_Abar_h),
        .i_b(s1_Bxt),
        .o_y(add_next_h_w)
    );

    mamba_exp #(.DATA_WIDTH(DATA_WIDTH)) u_exp (
        .i_x(s0_exp_in),
        .o_y(s1_dA_w)
    );

    always @(posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            s0_valid  <= 1'b0;
            s1_valid  <= 1'b0;
            o_valid   <= 1'b0;
            o_dA      <= {DATA_WIDTH{1'b0}};
            o_dB      <= {DATA_WIDTH{1'b0}};
            o_Abar_h  <= {DATA_WIDTH{1'b0}};
            o_Bxt     <= {DATA_WIDTH{1'b0}};
            o_next_h  <= {DATA_WIDTH{1'b0}};
        end else begin
            // valid pipeline
            s0_valid <= i_valid;
            s1_valid <= s0_valid;
            o_valid  <= s1_valid;

            // S0
            if (i_valid) begin
                s0_exp_in <= round_q88(i_mul0_result);
                s0_dB     <= round_q88(i_mul1_result);
                s0_h      <= i_h;
                s0_xt     <= i_xt;
            end

            // S1
            if (s0_valid) begin
                s1_dA     <= s1_dA_w;
                s1_dB     <= s0_dB;
                s1_Abar_h <= round_q88(i_mul2_result);
                s1_Bxt    <= round_q88(i_mul3_result);
            end

            // S2
            if (s1_valid) begin
                o_dA     <= s1_dA;
                o_dB     <= s1_dB;
                o_Abar_h <= s1_Abar_h;
                o_Bxt    <= s1_Bxt;
                o_next_h <= add_next_h_w;
            end
        end
    end

endmodule

module pipeline_yt_mac #(
    parameter D_MODEL = 8,
    parameter D_STATE = 8,
    parameter DATA_WIDTH = 16
)(
    input i_clk,
    input i_rst_n,
    input i_valid,
    input [7:0] i_idx_i,
    input [7:0] i_idx_j,
    input  wire signed [DATA_WIDTH-1:0]        i_h_val,    
    input  wire signed [DATA_WIDTH-1:0]        i_c_val,    
    input  wire signed [DATA_WIDTH-1:0]        i_dx_val,
    input  wire signed [2*DATA_WIDTH-1:0]      i_mul_result,

    output wire signed [DATA_WIDTH-1:0]        o_mul_a,
    output wire signed [DATA_WIDTH-1:0]        o_mul_b,
    output wire                                o_mul_valid,
    output reg                                 o_valid,    // 第 i 個 Channel 徹底算完了
    output reg  [7:0]                          o_idx_i,    // 告訴外面是哪一個 Channel 算完
    output reg  signed [DATA_WIDTH-1:0]        o_yt_final  
);
    function signed [31:0] round_q88;
        input signed [31:0] val;
        begin
            round_q88 = (val >>> 8) + (val[7] ? 1 : 0);
        end
    endfunction
    
    reg signed [31:0] yt_acc_reg [0:D_MODEL-1];

    reg signed [31:0] temp_prod;
    reg signed [31:0] temp_acc;
    reg signed [31:0] temp_final;
    // Latch channel index at j==0; o_idx_i uses this on j==D_STATE-1 so we
    // never register i_idx_i on the same edge as the parent's idx_d2 FF.
    reg [7:0] channel_idx_hold;

    assign o_mul_a     = i_c_val;
    assign o_mul_b     = i_h_val;
    assign o_mul_valid = i_valid;

    integer k;
    always @(posedge i_clk or negedge i_rst_n) begin 
        if(!i_rst_n) begin            
            o_valid <= 1'b0;
            o_idx_i <= 8'd0;
            o_yt_final <= {DATA_WIDTH{1'b0}};
            channel_idx_hold <= 8'd0;

            for (k = 0; k < D_MODEL; k = k + 1) begin
                yt_acc_reg[k] <= 32'd0;
            end

        end else begin
            o_valid <= 1'b0;
            if(i_valid) begin
                temp_prod = i_mul_result;
                if (i_idx_j == 0) begin
                    temp_acc = temp_prod;
                    channel_idx_hold <= i_idx_i;
                end else begin 
                    temp_acc = yt_acc_reg[i_idx_i] + temp_prod;
                end

                yt_acc_reg[i_idx_i] <= temp_acc;
                
                if (i_idx_j == (D_STATE - 1)) begin
                    temp_final = round_q88(temp_acc) + i_dx_val;
                    if (temp_final > 32'sd32767) 
                        o_yt_final <= 16'sd32767;
                    else if (temp_final < -32'sd32768) 
                        o_yt_final <= -16'sd32768;
                    else 
                        o_yt_final <= temp_final[15:0];

                    o_idx_i <= channel_idx_hold;
                    o_valid <= 1'b1;
                end
            end
        end
    end

endmodule

//// 以下為乘法加法不同周期的，省時間，但多65個FF左右
// `timescale 1ns / 1ps

// module pipeline_yt_mac #(
//     parameter D_MODEL = 8,
//     parameter D_STATE = 8,
//     parameter DATA_WIDTH = 16
// )(
//     input  wire                                i_clk,
//     input  wire                                i_rst_n,
    
//     // -----------------------------------------
//     // 輸入端 (來自 h 更新管線)
//     // -----------------------------------------
//     input  wire                                i_valid,    // 有新資料進來了
//     input  wire [7:0]                          i_idx_i,    // 這是第幾個 Channel (0~7)
//     input  wire [7:0]                          i_idx_j,    // 這是第幾個 State 元素 (0~7)
//     input  wire signed [DATA_WIDTH-1:0]        i_h_val,    // 剛出爐的 h_t
//     input  wire signed [DATA_WIDTH-1:0]        i_c_val,    // 對應的 C 參數
//     input  wire signed [DATA_WIDTH-1:0]        i_dx_val,   // 先算好的 D * x (準備最後加)
    
//     // -----------------------------------------
//     // 輸出端 (給 Pooling 單元)
//     // -----------------------------------------
//     output reg                                 o_valid,    // 第 i 個 Channel 徹底算完了
//     output reg  [7:0]                          o_idx_i,    // 告訴外面是哪一個 Channel 算完
//     output reg  signed [DATA_WIDTH-1:0]        o_yt_final  // 最終 16-bit 飽和截斷結果
// );

//     // ======================================================
//     // 內部暫存器宣告
//     // ======================================================
//     // 核心累加器 (8 個箱子，每個裝 32-bit 防止溢位)
//     reg signed [31:0] yt_acc_reg [0:D_MODEL-1]; 

//     // S1 管線暫存器 (第一級：乘法完的結果)
//     reg                            s1_valid;
//     reg  [7:0]                     s1_idx_i;
//     reg  [7:0]                     s1_idx_j;
//     reg  signed [31:0]             s1_prod;      // 裝 h * c 的乘積
//     reg  signed [DATA_WIDTH-1:0]   s1_dx_val;

//     // 用於組合邏輯計算的暫時變數 (不會生成實體 DFF)
//     reg signed [31:0] temp_acc;
//     reg signed [31:0] temp_final;

//     // ======================================================
//     // Q8.8 四捨五入函數 (Round to Nearest)
//     // ==========================================
//     function signed [31:0] round_q88;
//         input signed [31:0] val;
//         begin
//             round_q88 = (val >>> 8) + (val[7] ? 1 : 0);
//         end
//     endfunction

//     // ======================================================
//     // 管線主邏輯
//     // ======================================================
//     integer k;
//     always @(posedge i_clk or negedge i_rst_n) begin
//         if (!i_rst_n) begin
//             s1_valid <= 1'b0;
//             s1_idx_i <= 8'd0;
//             s1_idx_j <= 8'd0;
//             s1_prod  <= 32'd0;
//             s1_dx_val <= {DATA_WIDTH{1'b0}};
            
//             o_valid    <= 1'b0;
//             o_idx_i    <= 8'd0;
//             o_yt_final <= {DATA_WIDTH{1'b0}};
            
//             for (k = 0; k < D_MODEL; k = k + 1) begin
//                 yt_acc_reg[k] <= 32'd0;
//             end
//         end else begin
            
//             // --------------------------------------------------
//             // Stage 1: 乘法級 (MUL)
//             // --------------------------------------------------
//             // 只要收到 valid，就把 h 跟 C 乘起來存著
//             s1_valid <= i_valid;
//             if (i_valid) begin
//                 s1_idx_i  <= i_idx_i;
//                 s1_idx_j  <= i_idx_j;
//                 s1_prod   <= i_h_val * i_c_val; // 💥 整個模組唯一的 1 顆乘法器！
//                 s1_dx_val <= i_dx_val;
//             end

//             // --------------------------------------------------
//             // Stage 2: 累加與收尾級 (ACC & Clamp)
//             // --------------------------------------------------
//             o_valid <= 1'b0; // 預設輸出無效
            
//             if (s1_valid) begin
//                 // 1. 決定目前的累加總和是多少
//                 if (s1_idx_j == 0) begin
//                     // 如果是 j=0，代表新的一輪，箱子清空直接放乘積
//                     temp_acc = s1_prod; 
//                 end else begin
//                     // 否則，把箱子裡的舊值拿出來加上新乘積
//                     temp_acc = yt_acc_reg[s1_idx_i] + s1_prod;
//                 end
                
//                 // 2. 把更新後的總和放回箱子裡
//                 yt_acc_reg[s1_idx_i] <= temp_acc;

//                 // 3. 如果這是第 8 個元素 (j=7)，準備結算！
//                 if (s1_idx_j == (D_STATE - 1)) begin
//                     // 加上殘差 (D * x)
//                     temp_final = round_q88(temp_acc) + round_q88(s1_dx_val);
                    
//                     // 執行飽和截斷 (Clamp)
//                     if (temp_final > 32'sd32767) 
//                         o_yt_final <= 16'sd32767;
//                     else if (temp_final < -32'sd32768) 
//                         o_yt_final <= -16'sd32768;
//                     else 
//                         o_yt_final <= temp_final[15:0];
                        
//                     // 標記完工並輸出
//                     o_idx_i <= s1_idx_i;
//                     o_valid <= 1'b1; 
//                 end
//             end
            
//         end
//     end

// endmodule