# Fixed-Outline-Floorplanning-Optimization-Tool
Full Paper Link: [Full Paper](https://drive.google.com/file/d/1H9TPorSXNsspAgd3L_lMhQT7FGIEAQ3x/view?usp=drive_link)

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

<img width="420" alt="截圖 2024-02-27 下午5 05 55" src="https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/7b4507fb-b543-4a05-bbcb-30acae6d80e2">

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

<img width="413" alt="截圖 2024-02-27 下午5 02 42" src="https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/740d99fc-f256-4192-8687-1de91617f517">

### 分析模組擺置面積佔比
在此階段，計算公式如(3)式所示。

<img width="395" alt="截圖 2024-02-27 下午5 02 09" src="https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/50aee3e8-5557-4439-9898-0e7d16814ef7">


當此比例大於 80%，我們將劃分此電路為高佔比電路，否則為低佔比電路，而分析晶片結果如下所示，其中藍色、黃色矩形分別標示為固定外形、可變外形模組。

<img width="387" alt="截圖 2024-02-27 下午5 01 44" src="https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/b2bb441c-b570-49eb-a7a5-d39d9f19889d">

### Close-packing Algorithm
此階段流程圖如下所示
<img width="213" alt="截圖 2024-02-27 下午5 01 20" src="https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/cce3953b-f8ac-4f76-a887-1dc84a5f641e">



在模組擺置階段，操作示意圖如下所示

<img width="422" alt="截圖 2024-02-27 下午5 00 20" src="https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/318fbfe3-a7e5-4ee6-8fad-0160879e1377">


## 待處理issue
### Force-directed Algorithm
在 Force-directed Algorithm 中我們採用 [2] 中所提出的兩階段式平面規劃法，由全域分佈階段及合法化階段所構成。在全域分佈階段中，我們利用 [3] 中的數學解析模型 將模組均勻地散佈在晶片輪廓內。流程圖如下

<img width="405" alt="截圖 2024-02-27 下午4 51 11" src="https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/f05a92ca-fdf4-4d29-8383-7a1bcf5d99bf">

因面積較大模組所接收之力相比面積小模組較大，從而導致大模組相較小模組擴散速度太快，因此我們我們根據晶片面積，將其分割為數塊等大小之單位面積，並將模組之力大小根據模組所佔單位面積數量進行調整，使力的大小能更平均的分佈，提升優化效果。此外，我們將在每次計算力矢量時動態調整權重，以快速擴散模組且達到好的擴散效果。
我們希望單一可變形模組擺置時能有矩形外的外形解答，以有效利用晶片面積，降低死區形成比例，因此進行擴散力計算及模組擴散時，我們將模組之最小面積限制的 1.3 倍、高寬比例 1 設為此模組擴散的邊界外框，預期透過 analytical placement 會產生大量重疊的性質，將矩形外框內未重疊部分 視作該模組的外形變化。因此我們終止此階段繼續迭代的擴散指標採用 Klee 的度量計算法 [4], [5]，此算法大約可在電路剩餘 30%至 35%的重疊情況下結束，並進到下一合法化階段。
預期實作示意圖如下

<img width="423" alt="截圖 2024-02-27 下午4 52 19" src="https://github.com/jeannie068/Fixed-Outline-Floorplanning-Optimization-Tool/assets/124335771/ee98c2aa-8e7a-48e6-ad9f-5cd0b7a67dd8">

## Reference
[1] C.-H. Chiou, C.-H. Chang, S.-T. Chen, and Y.-W. Chang. Circular-contour- based obstacle-aware macro placement. In Proceedings of IEEE/ACM Asia and South Pacific Design Automation Conference, pages 172–177, 2016.

[2] Kai-Chung Chan, Chao-Jam Hsu, and Jia-Ming Lin. A Flexible Fixed-outline Floorplanning Methodology for Mixed-size Modules. 2013 18th Asia and South Pacific Design Automation Conference (ASP-DAC), Yokohama, Japan, 2013, doi: 10.1109/ASPDAC.2013.6509635.

[3] Andrew Kennings, and Kristofer P. Vorwerk. Force-Directed Methods for Generic Placement. IEEE TCAD, VOL. 25, NO. 10, OCTOBER 2006.

[4] M. H. Overmars and C.-K. Yap, “New upper bounds in Klee’s measure problem,” SIAM J. Comput., vol. 20, no. 6, pp. 1034– 1045, Dec. 1991.

[5] J. L. Bentley, “Algorithms for Klee’s rectangle problems,” Comput. Sci. Dept., Carnegie-Mellon Univ., Pittsburgh, Tech. Rep., 1977.



