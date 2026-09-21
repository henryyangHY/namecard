# 中英雙語切換（in-page i18n）— 設計規格

日期：2026-09-20
狀態：已核可，待實作
範圍：`index.html` + `story.html`

---

## 1. 目標

在名片頁與故事頁上加一顆語言切換鍵，讓訪客在**同一個網址、不重新載入**的情況下把全頁文案切成繁體中文。

**成功判準**

- 切換為瞬時，且不產生任何網路請求
- 不新增頁面、不新增網址、不新增 build step
- 中文不引入任何 webfont（額外下載 0 bytes）
- 既有的設計系統、版面、圖片、互動一律不動
- Henry 之後新增內容時，忘記寫中文不會弄壞中文版

## 2. 非目標

- 不做瀏覽器語言偵測
- 不記憶語言選擇（無 localStorage / sessionStorage / URL 參數）
- 不做中文版的獨立 URL、`hreflang` 或獨立 OG 圖
- 不改 `images/henry-yang.vcf`
- 不新增第三方 i18n 套件

## 3. 已接受的取捨

單一 URL 是 Henry 明確的選擇，以下是其必然結果，均已確認接受：

| 取捨 | 說明 |
|---|---|
| OG 分享預覽永遠英文 | `og:*` 由伺服器端讀取，同網址只有一組 meta |
| Google 只索引英文版 | 中文內容拿不到獨立搜尋排名，無 `hreflang` 可用 |
| 跨頁不延續語言 | index 切到中文後點進 story 會回到英文，需再按一次 |
| 切換時版面高度會跳動 | 中文通常比英文短 15–25%，不做掩飾 |

## 4. 架構：opt-in 成對標記

### 4.1 核心規則

```css
html[lang="en"]      [lang="zh-Hant"] { display: none; }
html[lang="zh-Hant"] [lang="en"]      { display: none; }
```

`<html>` 上的 `lang` 是唯一的狀態來源。不引入 `data-lang`，避免兩個概念。

**未標 `lang` 的元素在兩個語言都顯示。** 這是刻意的 fallback：新增內容只寫英文時，該區塊在中文版照常出現，不消失、不破版。「先上英文、之後補中文」是受支援的正式工作流。

`lang` 必須寫完整的 `zh-Hant`。只寫 `zh` 會讓部分系統挑簡體字形（PingFang SC）。

### 4.2 標記粒度

標在**最小的純文字塊**上：包含文字但不包含圖片、連結或結構的那一層。通常是 `<p>`、`<h1>`–`<h3>`、`<li>`，或 project 卡片裡的 `<span class="project__name">`。

**永遠不標 `lang` 的三類**：圖片、連結網址與 handle、數字年份。

### 4.3 雙份 DOM 與字典的分界

| 類型 | 機制 | 判準 |
|---|---|---|
| 內容文案 | 雙份 DOM（成對 `lang`） | 只出現一次的實質內容 |
| 介面字 | 字典（`data-i18n`） | 會重複出現，或在 `<head>`／JS 裡 |

介面字必須走字典的三個原因：會重複出現時雙份 DOM 會散落各處；`<title>` 與 meta 在 `<head>` 裡 CSS 管不到；語言鍵自己的文字在英文版上要顯示中文，而雙份 DOM 的規則正好會把它藏掉。

### 4.4 Project modal 自動繼承

`openProject()` 把 `.project__detail` 整塊 clone 進 modal。雙份 DOM 一起被 clone，而切換規則掛在 `html[lang]` 上是全域的，因此 modal 內容自動跟隨語言。**此路徑不需要任何程式碼。**

## 5. CSS 規格

全部新增在 `assets/css/v2.css` 末段。既有規則一條都不改。

### 5.1 字型（0 bytes 下載）

`v2.css` 的 81 條 `font-family` 有 78 條走 token，因此只需在中文元素上重新定義三個 token：

```css
[lang="zh-Hant"]{
  --font-display:'Bricolage Grotesque','PingFang TC','Noto Sans TC','Microsoft JhengHei',sans-serif;
  --font-body:'Instrument Sans','PingFang TC','Noto Sans TC','Microsoft JhengHei',sans-serif;
  --font-mono:'JetBrains Mono','PingFang TC','Noto Sans TC',monospace;
}
```

品牌字型排第一，因此中文句中夾的 `Microsoft 365 Copilot`、`Kellogg`、`2026` 仍由 Bricolage／Instrument Sans 渲染，只有中文字落到系統字。

系統字覆蓋：PingFang TC（Apple 全系列內建）、Noto Sans TC（Android／Linux）、Microsoft JhengHei（Windows）。

**明確禁止**：不得為中文引入任何 webfont。中文 webfont 單檔 3–8MB，會摧毀本頁的載入表現。

### 5.2 字距與行高

`letter-spacing` 41 條硬寫、僅 9 條走 token；`line-height` 41 條中僅 1 條走 token。因此無法靠 token 解決，需另寫規則。

選擇器採 `html[lang="zh-Hant"] <tag>[lang="zh-Hant"]`，權重 `(0,2,1)`，穩定蓋過既有的 `.prose p` `(0,1,1)` 與所有單 class 規則。放在 `v2.css` 末段以確保同權重時勝出。

```css
/* ===== 中文排版 ===== */
html[lang="zh-Hant"] p[lang="zh-Hant"],
html[lang="zh-Hant"] li[lang="zh-Hant"]{
  line-height:1.85;
  letter-spacing:normal;
  line-break:strict;
}
html[lang="zh-Hant"] h1[lang="zh-Hant"],
html[lang="zh-Hant"] h2[lang="zh-Hant"],
html[lang="zh-Hant"] h3[lang="zh-Hant"]{
  line-height:1.4;
  letter-spacing:normal;
}
html[lang="zh-Hant"] .kicker[lang="zh-Hant"],
html[lang="zh-Hant"] .projects__kicker[lang="zh-Hant"]{
  letter-spacing:.05em;
  text-transform:none;
}
```

規模預估：基底 25–30 行，另有 3–5 個個案微調（`.voice` 刻意做緊的引句、`.moniker` 兩行標語、`.hook-lead` 大標）。個案於實作時依實際渲染決定，不預先臆測。

**維護意義**：新增的中文內容只要是 `<p>` / `<li>` / `<h2>` / `<h3>`，自動套用正確排版，不需為每個新區塊寫 CSS。

### 5.3 譯註樣式（新增元件）

他人引述的原話保留英文，底下加中文譯註：

```css
.quote-gloss{
  margin-top:8px;font-family:var(--font-body);font-size:13px;
  line-height:1.8;color:var(--muted);
}
```

### 5.4 rail 空間

375px 實測：rail 總寬 290px，`HY` + `Now` + `QR` + `2026` 佔 204px，四個 gap 佔 32px，裝飾線 `.rail__rule` 僅剩 54px。新增一顆約 50px 的語言鍵加一個 8px gap 需要 58px，**會超出約 4px**。

解法是在窄螢幕收掉純裝飾的分隔線：

```css
@media (max-width:420px){ .rail__rule{display:none} }
```

釋出 62px 後重算為 286px ≤ 290px。此數字須於實作後用瀏覽器實測覆核。

`story.html` 的 `.story-top` 已是 `display:flex; justify-content:space-between`，語言鍵作為第二個子元素放入即可，**CSS 零變動**。

## 6. 切換按鈕規格

```html
<button class="cb-pill" type="button" id="lang-btn" data-i18n-label="lang.aria">
  <span data-i18n="lang.label">中文</span>
</button>
```

- 沿用既有 `.cb-pill`，不新增元件
- 位置：`index.html` 放在 rail 的 `QR` 之後、`2026` 之前；`story.html` 放在 `.story-top` 的 backlink 之後
- 顯示**目標語言**：英文版顯示「中文」，中文版顯示「EN」
- **不使用地球圖示**（語言不等於國家，且與鄰近的 `Now` / `QR` 並排時更難判讀）
- 按鈕文字走字典，不走雙份 DOM（見 4.3）
- `aria-label` 隨語言切換：英文版 `Switch to Chinese`，中文版 `Switch to English`
- **不使用 `aria-pressed`**（該屬性用於開關，此處是 A/B 切換）
- 切換後焦點留在按鈕上

## 7. 切換邏輯

```
1. document.documentElement.lang = next          // 'en' | 'zh-Hant'
2. 瀏覽器重算 CSS，display:none 換邊
3. 同一 tick 內跑字典迴圈：
   - [data-i18n]        → textContent
   - [data-i18n-label]  → aria-label
   - document.title
   - meta[name="description"] 的 content
4. 若 Now modal 已渲染過，以記憶體中的資料重跑 render（不重新 fetch）
```

預估 15 行。無網路請求、無重新載入、無圖片重抓。

## 8. 字典

各頁 inline 在自己的 `<script>` 裡，不抽共用檔。理由：符合既有「All JS is vanilla and inline」慣例；兩頁的介面字幾乎不重疊。

### 8.1 `index.html`（約 30 條）

| key | 英文 |
|---|---|
| `meta.title` | Henry Yang |
| `meta.desc` | （現有 meta description） |
| `lang.label` / `lang.aria` | 中文 / Switch to Chinese |
| `rail.now` / `rail.now.aria` | Now / See what Henry is up to now |
| `rail.qr` / `rail.qr.aria` | QR / Show QR code to share this page |
| `avatar.tape` / `avatar.aria` | Tap the photo to save contact / Save Henry's contact card to your phone |
| `toast.vcard` | ✓ Contact downloaded — open it to save Henry to your phone. |
| `qr.scan` / `qr.aria` / `close.aria` | Scan to visit / QR code / Close |
| `now.title` / `now.sub` / `now.aria` | Now · Henry / What I'm up to · last updated / What I'm doing now |
| `now.loading` / `now.empty` / `now.error` | Loading… / Nothing here yet. / Could not load. Try again later. |
| `now.foot` | Inspired by |
| `tag.building` … `tag.life` | 六個 tag 對照 |
| `projects.count` | 2 items |
| `cue.open` | Open ↗ |
| `pd.youtube` | Watch on YouTube ↗ |
| `pd.play.session` / `pd.play.demo` | Play the session recording / Play the demo |

### 8.2 `story.html`（約 8 條）

`meta.title`、`meta.desc`、`lang.label`、`lang.aria`、`close.aria`、`zoom.aria`（Open the inventory spreadsheet at full size）、`zoom.modal.aria`（Inventory spreadsheet, full size）、`pills.aria`（Words friends and colleagues used to describe Henry）。

## 9. 內容規則

### 9.1 什麼不翻

| 類別 | 處理 | 例 |
|---|---|---|
| Email、網址、handle | 不翻，不標 `lang` | `/HENRY-HJ-YANG` |
| 公司、學校、產品名 | 保留英文 | Microsoft、Kellogg、Microsoft 365 Copilot、Claude Code、Zettelkasten |
| 人名 | 保留英文 | Judson Althoff、Douglas Dawson |
| 職稱 | 翻中文 | VP of Cloud + AI Communication → 雲端與 AI 溝通副總裁 |
| 數字、年份 | 不翻，不標 `lang` | 2026、6,000+、400k+ |

依據為台灣科技圈實際書寫慣例。

### 9.2 主標題

中文版 `h1` 為 **「楊欣融 Henry Yang」**（中文名為主、英文名隨後）。`h1` 需成對標記。

### 9.3 他人引述

`bio__testimonial`（Douglas Dawson）及 story.html 中任何他人引述，**中文版保留英文原文**，底下加 `.quote-gloss` 中文譯註。

引述本體**不標 `lang`**（兩個語言都顯示英文原文），譯註元素標 `lang="zh-Hant"`（僅中文版顯示）。這是規格中唯一一處刻意的「單邊標記」，`check-i18n.sh` 需將 `.quote-gloss` 列入白名單，否則會被誤報為漏配對。

理由：把他人原話整句換成中文，等同讓一個真人在中文版說出他沒說過的話。譯註明確標示為翻譯，不冒充原話。

### 9.4 文案來源

全部 2354 字的繁中版由 Claude 起草（依現有英文重寫而非直譯），Henry 逐段修訂。

## 10. Now modal

### 10.1 schema

`now.json` 的 entry 新增**選填**欄位 `text_zh`：

```json
{ "date": "2026-09-20", "tag": "shipping", "text": "…", "text_zh": "…" }
```

有 `text_zh` 則中文版顯示之，無則 fallback 顯示英文 `text`。既有 20 筆不需回頭補。`NOW_PROTOCOL.md` 補一段說明此欄位與 fallback 行為。

### 10.2 其他調整

- `fmtDate()` 加語言分支：英文 `SEP 20`，中文 `9月20日`
- tag 顯示走字典（`SHIPPING` → `發布中` 等六條）
- modal 開啟中切換語言時，以記憶體中的資料重跑 render（需將 fetch 結果存入變數，約 3 行）

## 11. SEO / meta

- `<title>` 與 `<meta name="description">` 由字典經 JS 設定
- `og:*` 與 `twitter:*` **不動**，永遠英文
- JSON-LD **不動**（已含 `alternateName: 楊欣融`，結構化資料本就應只有一份）

## 12. 維護：`tools/check-i18n.sh`

零依賴腳本，掃 `index.html` 與 `story.html`，檢查兩件事：

1. 每個標了 `lang` 的元素是否有配對元素。**配對的定義**：同一父元素下、緊鄰其後（或其前）的兄弟元素，具有另一個語言的 `lang` 值且 tag 名稱相同。`.quote-gloss` 在白名單中，不檢查配對（見 9.3）
2. 每個 `data-i18n` / `data-i18n-label` 的 key 是否存在於該頁字典中

輸出格式：

```
index.html:189  lang="en" 沒有配對的中文  <span class="project__name">
story.html:204  data-i18n="ch.back" 不在字典裡
2 issues
```

無 issue 時輸出 `0 issues` 並回傳 exit code 0。

存在理由：唯一真正會咬人的失誤是「標了英文卻漏掉配對中文」，該段會在中文版靜默消失。本 repo 無 CI 無測試，此腳本是新增內容後三秒的保險。

## 13. `CLAUDE.md` 新增章節

於「How to make changes」下新增 **Bilingual content** 一節，內容包含：

- 4.1–4.3 的標記規則（含「未標記即雙語共用」的 fallback 語義）
- 新增 project 卡片的雙語模板（可直接複製）
- 新增 story chapter 的雙語模板
- 字典位置與新增介面字的方式
- `./tools/check-i18n.sh` 的使用時機
- 「不得為中文引入 webfont」的禁令

此節視為本次交付物之一。缺少它，此機制會在數月內退化為規則不明、中文覆蓋不均的狀態。

## 14. 檔案變動

| 檔案 | 變動 |
|---|---|
| `index.html` | 中文內容成對加入、語言鍵、字典 + 切換邏輯、Now render 調整、meta 由 JS 設定 |
| `story.html` | 中文內容成對加入、語言鍵、自身小字典 + 切換邏輯 |
| `assets/css/v2.css` | 末段新增中文排版約 30 行、`.quote-gloss` 4 行、rail media query 1 行 |
| `og.html` | 僅 bump `?v=` |
| `now.json` | entry 新增選填 `text_zh` |
| `NOW_PROTOCOL.md` | 補 `text_zh` 說明 |
| `tools/check-i18n.sh` | 新增 |
| `CLAUDE.md` | 新增 Bilingual content 一節 |

`v2.css` 有變動，因此 `index.html`、`story.html`、`og.html` 三處的 `?v=` 必須同步 bump（目前 `3.6` → `3.7`）。漏 bump 會讓回訪者以舊快取樣式渲染新標記而破版。

## 15. 驗證計畫

本 repo 無測試框架與 CI，驗證以實際執行並附證據為準。

| 項目 | 方法 | 通過判準 |
|---|---|---|
| 四種組合渲染 | 本機 server，截圖 index／story × en／zh-Hant | 版面完整，無溢出或重疊 |
| rail 不破版 | 375px 實測各元素寬度總和 | 總和 ≤ rail 可用寬度 |
| 無漏翻 | `./tools/check-i18n.sh` | `0 issues`，exit 0 |
| 切換無請求 | DevTools Network，記錄切換前後請求數 | 差值為 0 |
| 中文字型未下載 | Network 面板過濾 font | 無新增字型請求 |
| 鍵盤操作 | Tab 至語言鍵、Enter 切換 | 可聚焦、可觸發、焦點不跳走 |
| `prefers-reduced-motion` | 開啟該偏好後載入兩頁 | 既有行為不變 |
| Now modal 切換 | 開啟 modal 後切語言 | 介面字、tag、日期格式皆更新 |

## 16. 風險

| 風險 | 緩解 |
|---|---|
| 漏寫配對中文導致該段在中文版消失 | `check-i18n.sh`；且 fallback 設計使未標記者兩語言皆顯示，僅「標了一半」才有此風險 |
| 中文排版個案多於預估的 3–5 處 | 實作時逐頁目視，個案以最小規則處理，不重構既有 CSS |
| rail 在極窄螢幕（<360px）仍擠 | 實測 320px；必要時於該斷點改為隱藏 `.rail__year` |
| 未來新增內容未依規則標記 | `CLAUDE.md` 章節 + 可複製模板 |

---

*(by Claude)*
