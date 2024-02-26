# Fixed-Outline-Floorplanning-Optimization-Tool
Full Paper Link: https://drive.google.com/file/d/1H9TPorSXNsspAgd3L_lMhQT7FGIEAQ3x/view?usp=drive_link

此為我們開發的一新穎的固定輪廓平面佈局優化工具，藉由決定模組外形及位置來降低晶片總線長，找尋Physical Design中平面規劃的最佳解決方案。


## 摘要
此工具為四階段框架：
1. 模組權重連線關係建立
2. 晶片輪廓資料建立
3. 可擺置面積佔比分析
4. 擺置變形演算法

特別的是，我們著重於探尋除矩形外的模組外形解答，基於傳統的模擬退火法、二次分析方法，結合動態調整參數，開發專注於混合尺寸模塊佈局、模組外形調整的演算法。同時，擺置所有模組時考慮了模組最小面積、高寬比、矩形比等限制。

## 問題限制及評估目標值算法
### 問題描述
* 平面規劃需處理例如固定輪廓（fixed-outline）限制及可變形模組（soft module）等重要問題。
* 給定一測試資料輸入檔案，裡面包含：
    1. 晶片輪廓的寬度與高度（晶片輪廓的左下角座標訂為原點 (0,0)）
    2. 一群可變形的模組及其需求的最小面積
    3. 一群固定外形且為矩形的模組及其寬度、高度與左下角座標
    4. 模組之間的連線數量（皆為兩接點連線 [two-pin net]）
* 根據輸入檔案，需實做一個固定輪廓的平面配置器，半周長導線總長（total half-perimeter wirelength，total HPWL）為最佳化目標，在符合所有模組外形及位置的限制下，決定所有可變形模組的外形以及位置。輸出檔案包括：
    1. 半周長導線總長（精確度到小數點後一位）
    2. 所有可變形模組數量及被決定的外形與位置資訊。

---
### 評估目標值算法
![image](https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/bdf2f813-843b-43e6-b4fd-acded08c3d26)

---
## 資料夾說明
* case-input：輸入檔案放置處
* case-output：輸出檔案放置處
* view：圖片放置處，例如測試資料原始固定輪廓圖、測試資料輸出擺置圖、模組間連接視覺化，等等

## 檔案說明
* CAD2023.m - 使用MATLAB生成擺置視覺化圖片
* PlaceAlg  - 擺置變形演算法
* TREE - 包含樹（tree）的資料結構定義，以及多種函數功能
* contour - 建立以 doubly linked list 結構的 circular-contour [1]來儲存電路的擺置狀態
* myGraph - 包含圖（graph）的資料結構定義。以及一些功能例如將電路初始數據的模組間連線關係儲存至 多個 sub graph、並計算生成MST（Minimum Spanning Tree），等等。
case01 graph示意圖
![image](https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/e5120d14-9978-4278-8675-e8da267663f0)

* parser - 定義模組的資料結構，通過 parser 讀取電路初始數據進結構中

## 演算法
我們構想的演算法主要由五個階段構成，包括建立 graph、建立 circular-contour、分析可擺置面積比例、Close-packing Algorithm、Force-directed Algorithm。
流程圖如下所示:
![image](https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/0e94c3fc-64b8-4d30-be87-abb154e29dd4)

### 分析模組擺置面積佔比
在此階段，計算公式如(3)式所示。
![image](https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/5db8f3de-b77a-4ef2-96f7-8d1db49b6e0a)


當此比例大於 80%，我們將劃分此電路為高佔比電路，否則為低佔比電路，而分析晶片結果如下所示，其中藍色、黃色矩形分別標示為固定外形、可變外形模組。
![image](https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/93ea0a4f-e454-42cd-acbb-f6105867a37a)

### Close-packing Algorithm
此階段流程圖如下所示
![image](https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/eddd0471-895e-4fe7-81d6-3b34de698fed)


在模組擺置階段，操作示意圖如下所示

![image](https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/55d83cbb-57f9-4196-8738-7e61ef4a5ca6)





