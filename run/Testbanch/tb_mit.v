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
    
    // 總測試筆數 (MIT-BIH 全量)
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

    // 各類別統計用的暫存器
    integer class_total   [0:3];
    integer class_correct [0:3];
    
    // 混淆矩陣 (Confusion Matrix) 暫存器 [True_Class][Pred_Class]
    integer conf_matrix   [0:3][0:3]; 

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
        forever #3 clk = ~clk; 
    end

    // ======================================================
    // 4. 批次主測試流程
    // ======================================================
    integer s, i, c, p;
    integer correct_cnt;
    integer golden_val;
    integer wait_cycles;

    initial begin
        // ⚠️ 跑全量測試時，強烈建議將 FSDB 波形關閉，否則會塞爆硬碟配額！
        // $fsdbDumpfile("tb_mamba_core.fsdb");
        // $fsdbDumpvars(0, tb_mamba_core);
        // $fsdbDumpMDA();

        // 讀取測資
        $readmemh("Pattern/test_features.hex", test_mem);
        $readmemh("Pattern/test_mit_ground_truth.hex", golden_mem);
        
        rst_n   = 1'b0;
        i_valid = 1'b0;
        i_data  = 16'd0;
        correct_cnt = 0;
        
        // 初始化各類別計數器與混淆矩陣
        for (c = 0; c < 4; c = c + 1) begin
            class_total[c]   = 0;
            class_correct[c] = 0;
            for (p = 0; p < 4; p = p + 1) begin
                conf_matrix[c][p] = 0;
            end
        end
        
        #25;
        rst_n = 1'b1;
        
        $display("\n===========================================");
        $display("🚀 開始 Mamba Core 批次推論模擬 (共 %0d 筆)", TOTAL_SAMPLES);
        $display("   比對目標：MIT-BIH 原始標籤 (Golden)");
        $display("   (已關閉波形輸出以加速模擬)");
        $display("===========================================\n");

        // 🌟 修改點 1：從第 0 筆開始跑到 TOTAL_SAMPLES
        for (s = 0; s < TOTAL_SAMPLES; s = s + 1) begin
            
            @(negedge clk);
            rst_n = 1'b0;
            @(negedge clk);
            rst_n = 1'b1;
            
            i = 0;
            while (i < SEQ_LEN) begin
                @(negedge clk);
                if (o_ready) begin
                    i_valid = 1'b1;
                    i_data  = test_mem[s*SEQ_LEN + i];
                    i = i + 1;
                end else begin
                    i_valid = 1'b0;
                end
            end

            @(negedge clk);
            i_valid = 1'b0;
            
            wait_cycles = 0;
            while (o_valid !== 1'b1 && wait_cycles < 200000) begin
                @(posedge clk);
                wait_cycles = wait_cycles + 1;
            end
            if (o_valid !== 1'b1) begin
                $display("TIMEOUT @ Sample %0d after %0d cycles waiting o_valid", s, wait_cycles);
                $finish;
            end
            
            golden_val = golden_mem[s];
            class_total[golden_val] = class_total[golden_val] + 1;
            conf_matrix[golden_val][o_class] = conf_matrix[golden_val][o_class] + 1;
            
            // 為了讓終端機乾淨一點，你可以選擇只在出錯時印出詳細資訊
            // 這裡預設依然印出全部，若覺得太洗頻可以把 OK 的那行註解掉
            if (o_class === golden_val) begin
                // $display("Sample %0d: Pred=%0d, Golden=%0d -> OK", s, o_class, golden_val);
                correct_cnt = correct_cnt + 1;
                class_correct[golden_val] = class_correct[golden_val] + 1;
            end else begin
                $display("❌ Sample %0d: Pred=%0d, Golden=%0d -> NG", s, o_class, golden_val);
            end
            
            // 每 1000 筆報告一次進度
            if (s > 0 && s % 1000 == 0) begin
                $display("   ... 已測試 %0d 筆, 目前總正確數: %0d (目前準確率: %0f %%)", s, correct_cnt, (correct_cnt * 100.0) / s);
            end
        end

        // ======================================================
        // 5. 結算總成績與混淆矩陣印出
        // ======================================================
        $display("\n=====================================================================");
        $display("🎯 測試完成！(硬體診斷能力評估)");
        $display("---------------------------------------------------------------------");
        
        // 🌟 修改點 2：分母改為 TOTAL_SAMPLES
        $display("總體正確數: %0d / %0d", correct_cnt, TOTAL_SAMPLES);
        $display("總體正確率: %0f %%", (correct_cnt * 100.0) / TOTAL_SAMPLES);
        $display("---------------------------------------------------------------------");
        $display("---------------------------------------------------------------------");
        
        $display("📊 Normalized Confusion Matrix (混淆矩陣比例):");
        $display("                 | Pred 0 (N) | Pred 1 (V) | Pred 2 (F) | Pred 3 (Q) |");
        $display("---------------------------------------------------------------------");
        for (c = 0; c < 4; c = c + 1) begin
            if (class_total[c] > 0) begin
                $display(" True Class %0d    |   %5.2f%%   |   %5.2f%%   |   %5.2f%%   |   %5.2f%%   |", 
                         c, 
                         (conf_matrix[c][0] * 100.0) / class_total[c], 
                         (conf_matrix[c][1] * 100.0) / class_total[c], 
                         (conf_matrix[c][2] * 100.0) / class_total[c], 
                         (conf_matrix[c][3] * 100.0) / class_total[c]);
            end else begin
                $display(" True Class %0d    |    --      |    --      |    --      |    --      |", c);
            end
        end
        $display("=====================================================================\n");
        
        #50;
        $finish;
    end
endmodule