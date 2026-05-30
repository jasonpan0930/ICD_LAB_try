# 專案脈絡：TinyMamba - 應用於穿戴式心電圖診斷之極輕量狀態空間加速器
**(Project Context: Algorithm-Hardware Co-Design of an Ultra-Lightweight State Space Model for Wearable ECG Diagnostics)**

## 1. 專案概述 (Project Overview)
本專案旨在開發一顆針對「邊緣運算 (Edge AI) 穿戴式裝置」特化的極低功耗心電圖 (ECG) 分類數位晶片。透過軟硬體協同設計 (Algorithm-Hardware Co-design)，我們將當前最前沿的狀態空間模型 (State Space Model, Mamba) 極限微縮，取代傳統龐大的 CNN 或 RNN 網路，達成在資源極度受限條件下的即時心律不整偵測。

## 2. 核心演算法規格 (Algorithm Specifications)
* **模型架構:** Micro-Mamba (數位化單層狀態空間模型，評估擴充至雙層)
* **硬體節點 (Parameters):** 極限壓縮至 293 個節點。
* **量化規格 (Quantization):** 目前為 **W8A16** (Weights: INT8, Activation: Q8.8 Fixed-point)，未來目標朝向更極致的 W8A8 邁進。
* **Rescaling:** 乘法後採用 Arithmetic Right Shift (算術右移) 進行截斷 (Truncation) 取代四捨五入 (Rounding)，以符合 Verilog 合成限制。

## 3. 資料工程與醫學決策 (Data Engineering & Medical Insights)
* **資料集:** Kaggle MIT-BIH Arrhythmia Database (187-point 單一心跳切片版本)。
* **關鍵決策：採用「4 分類」取代「5 分類」 (捨棄 S 類別)**
    * 醫學物理考量: 切片破壞了 S 類別最關鍵的 RR 時間間隔特徵。將算力 100% 集中於波形形態變化劇烈之類別 (如 V, F)，達成極致的硬體資源分配。

## 4. 數位硬體優化與演算法協同策略 (Hardware-Algorithm Co-Optimization)
為確保模型能轉譯為超低功耗的 RTL 數位電路，我們執行了深度的架構優化：

### A. 非線性函數硬體化 (Non-linear Function Approximation)
捨棄耗能的原生指數與對數函數，改用硬體友善設計，並結合 **STE (Straight-Through Estimator) 進行 Hardware-Aware Retraining**，成功將量化與近似造成的準確率衰退 (82.9%) 重新拉升至 **94.21%**：
* **Softplus ($ln(1+e^x)$):** 拆解為 $x + ln(1+e^{-|x|})$。透過極小型的 Look-Up Table (LUT) 查表計算 $ln(1+e^{-|x|})$，並搭配簡單的加法器與 MUX 完成。
* **Exponential ($e^x$):** 採用 Base-2 轉換 $2^{1.442695x} = 2^I \times 2^F$。整數部分 ($2^I$) 直接使用位移 (Shift) 實作，小數部分 ($2^F$) 使用 LUT 查表。

### B. 架構折疊與面積優化 (Architecture Folding & Area Optimization)
初版 Single-Cycle (純組合邏輯) 實作導致 Cell Area 高達 4.23M。透過**「以空間換取時間」**的策略，成功將面積狂減近 87% (縮減至 567K)：
1. **Pipeline & Sequential Data Path:** 將 Element-wise 運算與矩陣相乘 (Matrix Multiplication) 拆分至多個 Cycle 循序執行，大幅共用乘加器 (MAC)。
2. **Layer Fusion (矩陣運算合併):** 在數學上直接將 `proj_in` (1至8維) 與 `x_proj` (8至17維) 的運算合併為單一步驟 ($1 \times 17$)，直接省去中間 8 維的暫存器與運算邏輯。

## 5. 基準比較與學術價值 (Benchmarking)
* **VS. 原始 UCLA Baseline (1D ResNet):** 以不到 1% 的參數與硬體資源，在 4 分類任務上達成 **94.21%** 的總體準確率 (N: 95.7%, V: 86.2%, F: 68.5%, Q: 87.2%)。
* **VS. 貯蓄池計算 (MDPI 2026 ESN):** 證明純數位邏輯的 SSM 演算法萃取效率，遠勝於需要數千節點的類比/混合訊號網路。

## 6. 目前專案進度與未來展望 (Status & Future Work)
* [x] 完成 Micro-Mamba 軟體架構建置與 4 分類醫學定義。
* [x] 完成 W8A16 非線性函數近似之 STE 硬體感知重新訓練，確認準確率達標 (94.21%)。
* [x] 完成初步 RTL Synthesis，並透過 Pipeline 與數學化簡將 Area 縮減至 567K。
* [ ] **Area Optimization:** 進一步實作神經網路乘法的 Sequential 循序運算，逼近面積極限。
* [ ] **Memory Architecture:** 使用 Flip-Flops (FFs) 來高效率儲存 NN 的 Weights & Biases。
* [ ] **Algorithm Advance:** 實驗 2-Layer Mamba 提升 Robustness，並挑戰極限的 W8A8 量化。
