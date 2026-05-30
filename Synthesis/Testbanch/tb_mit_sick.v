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
    parameter ADDR_WIDTH = 9;

    // ⚠️ 請填入 Python 印出來的總測試筆數 (例如: 1024 或 21336)
    parameter TOTAL_SAMPLES = 21336; 
    
    reg  clk;
    reg  rst_n;
    reg  rst_weights_n;
    reg  i_valid;
    reg  signed [DATA_WIDTH-1:0] i_data;
    reg  w_we;
    reg  [ADDR_WIDTH-1:0] w_addr;
    reg  [7:0] w_data;
    
    // 🌟 保留新版的握手訊號 o_ready
    wire o_ready;
    wire o_valid;
    wire [1:0] o_class;

    // 測資記憶體
    reg [15:0] test_mem   [0:TOTAL_SAMPLES*SEQ_LEN-1];
    reg [1:0]  golden_mem [0:TOTAL_SAMPLES-1];
    reg [7:0]  weight_mem [0:284];
    localparam integer WEIGHT_BYTES = 285;

    // 各類別統計用的暫存器
    integer class_total   [0:3];
    integer class_correct [0:3];
    
    // 🌟 混淆矩陣 (Confusion Matrix) 暫存器 [True_Class][Pred_Class]
    integer conf_matrix   [0:3][0:3]; 

    // ======================================================
    // 2. 實例化待測物
    // ======================================================
    mamba_core #(
        .D_IN(D_IN), .D_MODEL(D_MODEL), .D_STATE(D_STATE),
        .SEQ_LEN(SEQ_LEN), .DATA_WIDTH(DATA_WIDTH), .WGHT_WIDTH(WGHT_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk), .rst_n(rst_n), .rst_weights_n(rst_weights_n), .i_valid(i_valid), .i_data(i_data),
        .w_we(w_we), .w_addr(w_addr), .w_data(w_data),
        .o_ready(o_ready), // 🌟 接上 ready 訊號
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
    integer k;
    integer correct_cnt;
    integer golden_val;
    integer wait_cycles;

    task write_weight_byte;
        input [ADDR_WIDTH-1:0] a;
        input [7:0] d;
        begin
            @(negedge clk);
            w_we   = 1'b0;
            w_addr = a;
            w_data = d;
            @(negedge clk);
            w_we = 1'b1;
            @(negedge clk);
            w_we = 1'b0;
        end
    endtask

    task load_all_weights_from_mem;
        begin
            for (k = 0; k < WEIGHT_BYTES; k = k + 1)
                write_weight_byte(k[ADDR_WIDTH-1:0], weight_mem[k]);
            @(negedge clk);
            w_addr = {ADDR_WIDTH{1'b0}};
            w_data = 8'd0;
        end
    endtask

    initial begin
        // Waveform dump for nWave/Verdi (FSDB)
        // $fsdbDumpfile("tb_mamba_core.fsdb");
        // $fsdbDumpvars(0, tb_mamba_core);
        // $fsdbDumpMDA();

`ifdef SDF
`ifndef SDF_FILE
`define SDF_FILE "../Netlist/CHIP_syn.sdf"
`endif
        $display("[TB] SDF annotation enabled: %s", `SDF_FILE);
        $sdf_annotate(`SDF_FILE, uut);
`endif

        // 讀取測資 (請確認路徑與你執行 VCS/ModelSim 的相對位置相符)
        $readmemh("Pattern/test_features.hex", test_mem);
        // 這裡讀取 MIT 的原始正確答案
        $readmemh("Pattern/test_mit_ground_truth.hex", golden_mem);
        $readmemh("Pattern/weights_ram.hex", weight_mem);

        rst_weights_n = 1'b0;
        rst_n   = 1'b0;
        i_valid = 1'b0;
        i_data  = 16'd0;
        w_we    = 1'b0;
        w_addr  = {ADDR_WIDTH{1'b0}};
        w_data  = 8'd0;
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
        rst_weights_n = 1'b1;
        #10;
        load_all_weights_from_mem;
        rst_n = 1'b1;
        #10;
        
        $display("\n===========================================");
        $display("🚀 開始 Mamba Core 批次推論模擬 (共 %0d 筆)", TOTAL_SAMPLES);
        $display("   比對目標：MIT-BIH 原始標籤 (Golden)");
        $display("===========================================\n");

        for (s = 18118; s < TOTAL_SAMPLES; s = s + 1) begin
            
            // 每一筆新的心電圖進來前，Reset 硬體清空 h_t 暫存器
            @(negedge clk);
            rst_n = 1'b0;
            @(negedge clk);
            rst_n = 1'b1;
            @(negedge clk);

            // 🌟 結合新版邏輯：開始餵送 187 筆特徵 (valid/ready 握手)
            i = 0;
            while (i < SEQ_LEN) begin
                // 在 negedge 先把資料/valid 準備好，讓 DUT 在下一個 posedge 正確取樣
                @(negedge clk);
                if (o_ready) begin
                    i_valid = 1'b1;
                    i_data  = test_mem[s*SEQ_LEN + i];
                    i = i + 1;
                    // 若嫌太吵可以註解掉這三行進度印出
                    // if ((i % 32) == 0) begin
                    //     $display("Sample %0d feed progress: %0d/%0d", s, i, SEQ_LEN);
                    // end
                end else begin
                    i_valid = 1'b0; // 如果 core 沒 ready，把 valid 拉低等待
                end
            end

            // 餵完後拉低 valid
            @(negedge clk);
            i_valid = 1'b0;
            
            // 🌟 結合舊版邏輯：等待最後一拍的分類結果 (含防無限迴圈的 timeout)
            wait_cycles = 0;
            while (o_valid !== 1'b1 && wait_cycles < 200000) begin
                @(posedge clk);
                wait_cycles = wait_cycles + 1;
            end
            if (o_valid !== 1'b1) begin
                $display("TIMEOUT @ Sample %0d after %0d cycles waiting o_valid", s, wait_cycles);
                $finish;
            end
            
            // 取出這筆資料的 MIT 正解
            golden_val = golden_mem[s];
            
            // 統計：紀錄該類別的總數
            class_total[golden_val] = class_total[golden_val] + 1;
            
            // 🌟 統計：紀錄至混淆矩陣 [True][Pred]
            conf_matrix[golden_val][o_class] = conf_matrix[golden_val][o_class] + 1;
            
            // 🌟 結合舊版邏輯：每筆都輸出結果與答案 (單筆比對)
            if (o_class === golden_val) begin
                $display("Sample %0d: Pred=%0d, Golden=%0d -> OK", s, o_class, golden_val);
                correct_cnt = correct_cnt + 1;
                class_correct[golden_val] = class_correct[golden_val] + 1;
            end else begin
                $display("Sample %0d: Pred=%0d, Golden=%0d -> NG", s, o_class, golden_val);
            end
            
            // 每 1000 筆報告一次進度
            if (s > 0 && s % 1000 == 0) begin
                $display("   ... 已測試 %0d 筆, 目前總正確數: %0d", s, correct_cnt);
            end
        end

        // ======================================================
        // 5. 結算總成績與混淆矩陣印出
        // ======================================================
        $display("\n=====================================================================");
        $display("🎯 測試完成！(硬體診斷能力評估)");
        $display("---------------------------------------------------------------------");
        $display("總體正確數: %0d / %0d", correct_cnt, (TOTAL_SAMPLES - 18118));
        $display("總體正確率: %0f %%", (correct_cnt * 100.0) / (TOTAL_SAMPLES - 18118));
        $display("---------------------------------------------------------------------");
        $display("---------------------------------------------------------------------");
        
        // 🌟 混淆矩陣輸出區塊 (完美對齊你圖表上的百分比格式)
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