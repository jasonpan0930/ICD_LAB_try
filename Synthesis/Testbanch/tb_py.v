`timescale 1ns / 1ps

module tb_mamba_core();

    // ======================================================
    // 1. 參數與訊號宣告
    // ======================================================
    parameter D_IN       = 1;
    parameter D_MODEL    = 8;
    parameter D_STATE    = 8;
    parameter SEQ_LEN    = 187;
    parameter DATA_WIDTH = 16;
    parameter WGHT_WIDTH = 8;
    
    // ⚠️ 請填入 Python 印出來的總測試筆數 (例如: 1024 或 21892)
    parameter TOTAL_SAMPLES = 21336; 
    
    reg  clk;
    reg  rst_n;
    wire rst_weights_n;
    assign rst_weights_n = rst_n;
    reg  i_valid;
    reg  signed [DATA_WIDTH-1:0] i_data;
    
    wire o_ready;
    wire o_valid;
    wire [1:0] o_class;

    // 測資記憶體
    reg [15:0] test_mem   [0:TOTAL_SAMPLES*SEQ_LEN-1];
    reg [1:0]  golden_mem [0:TOTAL_SAMPLES-1];

    // 🌟 新增：各類別統計用的暫存器
    integer class_total   [0:3];
    integer class_correct [0:3];

    // ======================================================
    // 2. 實例化待測物
    // ======================================================
    mamba_core #(
        .D_IN(D_IN), .D_MODEL(D_MODEL), .D_STATE(D_STATE),
        .SEQ_LEN(SEQ_LEN), .DATA_WIDTH(DATA_WIDTH), .WGHT_WIDTH(WGHT_WIDTH)
    ) uut (
        .clk(clk), .rst_n(rst_n), .rst_weights_n(rst_weights_n), .i_valid(i_valid), .i_data(i_data),
        .w_we(1'b0), .w_addr(9'd0), .w_data(8'd0),
        .o_ready(o_ready),
        .o_valid(o_valid), .o_class(o_class)
    );

    // ======================================================
    // 3. 時鐘產生器
    // ======================================================
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // ======================================================
    // 4. 批次主測試流程
    // ======================================================
    integer s, i, c;
    integer correct_cnt;
    integer golden_val;

    initial begin
        // 讀取測資 (請確認路徑與你執行 VCS/ModelSim 的相對位置相符)
        $readmemh("Pattern/test_features.hex", test_mem);
        // 這裡讀取 Python 算出來的結果
        $readmemh("Pattern/test_python_golden.hex", golden_mem);
        
        rst_n   = 1'b0;
        i_valid = 1'b0;
        i_data  = 16'd0;
        correct_cnt = 0;
        
        // 初始化各類別計數器
        for (c = 0; c < 4; c = c + 1) begin
            class_total[c]   = 0;
            class_correct[c] = 0;
        end
        
        #25;
        rst_n = 1'b1;
        
        $display("\n===========================================");
        $display("🚀 開始 Mamba Core 批次推論模擬 (共 %0d 筆)", TOTAL_SAMPLES);
        $display("   比對目標：MIT-BIH 原始標籤 (Golden)");
        $display("===========================================\n");

        for (s = 0; s < TOTAL_SAMPLES; s = s + 1) begin
            
            // 每一筆新的心電圖進來前，Reset 硬體清空 h_t 暫存器
            @(negedge clk);
            rst_n = 1'b0;
            @(negedge clk);
            rst_n = 1'b1;
            
            // 開始餵送 187 筆特徵
            for (i = 0; i < SEQ_LEN; i = i + 1) begin
                @(posedge clk);
                i_valid <= 1'b1;
                i_data  <= test_mem[s*SEQ_LEN + i];
            end

            // 餵完後拉低 valid
            @(posedge clk);
            i_valid <= 1'b0;
            
            // 等待最後一拍的分類結果
            wait(o_valid == 1'b1);
            
            // 取出這筆資料的 MIT 正解
            golden_val = golden_mem[s];
            
            // 🌟 統計：紀錄該類別的總數
            class_total[golden_val] = class_total[golden_val] + 1;
            
            // 對答案
            if (o_class === golden_val) begin
                correct_cnt = correct_cnt + 1;
                // 🌟 統計：紀錄該類別的正確數
                class_correct[golden_val] = class_correct[golden_val] + 1;
            end else begin
                // 若要減少畫面洗版，可以把這行註解掉
                $display("❌ 錯誤 @ Sample %0d: 硬體預測=%0d, MIT正解=%0d", s, o_class, golden_val);
            end
            
            // 每 1000 筆報告一次進度
            if (s > 0 && s % 1000 == 0) begin
                $display("   ... 已測試 %0d 筆, 目前總正確數: %0d", s, correct_cnt);
            end
        end

        // 結算總成績與各類別成績
        $display("\n===========================================");
        $display("🎯 測試完成！(硬體診斷能力評估)");
        $display("-------------------------------------------");
        $display("總體正確數: %0d / %0d", correct_cnt, TOTAL_SAMPLES);
        $display("總體正確率: %0f %%", (correct_cnt * 100.0) / TOTAL_SAMPLES);
        $display("-------------------------------------------");
        $display("📊 各類別診斷準確率:");
        
        for (c = 0; c < 4; c = c + 1) begin
            if (class_total[c] > 0) begin
                $display("   類別 %0d: %6.2f %%  ( %0d / %0d )", 
                         c, 
                         (class_correct[c] * 100.0) / class_total[c], 
                         class_correct[c], 
                         class_total[c]);
            end else begin
                $display("   類別 %0d: 無測試資料", c);
            end
        end
        $display("===========================================\n");
        
        #50;
        $finish;
    end
endmodule


// `timescale 1ns / 1ps

// module tb_mamba_core();

//     // ======================================================
//     // 1. 參數與訊號宣告
//     // ======================================================
//     parameter D_IN       = 1;
//     parameter D_MODEL    = 8;
//     parameter D_STATE    = 8;
//     parameter SEQ_LEN    = 187;
//     parameter DATA_WIDTH = 16;
//     parameter WGHT_WIDTH = 8;
    
//     // ⚠️ 請填入 Python 印出來的總測試筆數！
//     parameter TOTAL_SAMPLES = 21892; 
    
//     reg  clk;
//     reg  rst_n;
//     reg  i_valid;
//     reg  signed [DATA_WIDTH-1:0] i_data;
    
//     wire o_valid;
//     wire [1:0] o_class;

//     // 測資記憶體
//     // test_mem 存放所有心電圖特徵, golden_mem 存放所有標準答案
//     reg [15:0] test_mem   [0:TOTAL_SAMPLES*SEQ_LEN-1];
//     reg [1:0]  golden_mem [0:TOTAL_SAMPLES-1];

//     // ======================================================
//     // 2. 實例化待測物
//     // ======================================================
//     mamba_core #(
//         .D_IN(D_IN), .D_MODEL(D_MODEL), .D_STATE(D_STATE),
//         .SEQ_LEN(SEQ_LEN), .DATA_WIDTH(DATA_WIDTH), .WGHT_WIDTH(WGHT_WIDTH)
//     ) uut (
//         .clk(clk), .rst_n(rst_n), .i_valid(i_valid), .i_data(i_data),
//         .o_valid(o_valid), .o_class(o_class)
//     );

//     // ======================================================
//     // 3. 時鐘產生器
//     // ======================================================
//     initial begin
//         clk = 0;
//         forever #5 clk = ~clk; 
//     end

//     // ======================================================
//     // 4. 批次主測試流程 (Automated Batch Testing)
//     // ======================================================
//     integer s, i;
//     integer correct_cnt;

//     initial begin
//         // 讀取測資 (請確認路徑與你執行 VCS 的相對位置相符)
//         $readmemh("Pattern/test_features.hex", test_mem);
//         $readmemh("Pattern/test_golden.hex", golden_mem);
        
//         rst_n   = 1'b0;
//         i_valid = 1'b0;
//         i_data  = 16'd0;
//         correct_cnt = 0;
        
//         #25;
//         rst_n = 1'b1;
        
//         $display("\n===========================================");
//         $display("🚀 開始 Mamba Core 批次推論模擬 (共 %0d 筆)", TOTAL_SAMPLES);
//         $display("===========================================\n");

//         for (s = 0; s < TOTAL_SAMPLES; s = s + 1) begin
            
//             // 🌟 關鍵：每一筆新的心電圖進來前，必須 Reset 硬體清空暫存器！
//             @(negedge clk);
//             rst_n = 1'b0;
//             @(negedge clk);
//             rst_n = 1'b1;
            
//             // 開始餵送 187 筆特徵
//             for (i = 0; i < SEQ_LEN; i = i + 1) begin
//                 @(posedge clk);
//                 i_valid <= 1'b1;
//                 i_data  <= test_mem[s*SEQ_LEN + i];
//             end

//             // 餵完後拉低 valid
//             @(posedge clk);
//             i_valid <= 1'b0;
            
//             // 等待最後一拍的分類結果
//             wait(o_valid == 1'b1);
            
//             // 對答案
//             if (o_class === golden_mem[s]) begin
//                 correct_cnt = correct_cnt + 1;
//             end else begin
//                 // 如果有錯，印出來方便 Debug
//                 $display("❌ 錯誤 @ Sample %0d: 硬體算出=%0d, Python預期=%0d", s, o_class, golden_mem[s]);
//             end
            
//             // 每 1000 筆報告一次進度
//             if (s > 0 && s % 1000 == 0) begin
//                 $display("   ... 已測試 %0d 筆, 目前正確數: %0d", s, correct_cnt);
//             end
//         end

//         // 結算總成績
//         $display("\n===========================================");
//         $display("🎯 全部測試完成！");
//         $display("🎯 硬體最終正確數: %0d / %0d", correct_cnt, TOTAL_SAMPLES);
//         $display("🎯 硬體最終正確率: %0f %%", (correct_cnt * 100.0) / TOTAL_SAMPLES);
//         $display("===========================================\n");
        
//         #50;
//         $finish;
//     end
// endmodule