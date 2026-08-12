# content/ — 內容編輯工作流

這個資料夾是 `index.html` 和 `story.html` 的**文字內容鏡像**。
網站本身沒有 build step，HTML 才是最終上線的檔案；這裡的 Markdown 是給人（和 AI）
編輯用的中介層。

## 工作流程

```
1. Claude 從 HTML 匯出 → content/index.md, content/story.md
2. 你在 Markdown Editor 裡自由改寫（只動文字，不動 [block-id]）
3. 把改好的 .md 丟回來
4. Claude 校對文法 → 依 block ID 回填進 HTML → commit
```

## 唯一的規則

**不要動 `### [xxx.yyy]` 這一行。** 那是回填時的定位錨點。
其他都可以改：刪句子、加句子、整段重寫都沒問題。

如果你想**新增**一個原本沒有的區塊（例如 About 底下多一段），
直接寫在該區塊裡就好，不用自己編 ID —— 回填時我會處理成新的 `<p>`。
如果你想**刪掉**整個區塊，把內容清空並在下面寫 `<!-- 刪除 -->`。

## 行內標記對照

網站的設計系統有幾個帶樣式的行內標記，用 Markdown 語法表示：

| Markdown | 轉成 HTML | 視覺效果 |
|---|---|---|
| `==文字==` | `<span class="cb-mark">文字</span>` | 鈷藍色螢光筆底線（強調用，一段最多一個） |
| `**文字**` | `<span class="cb-em">文字</span>` | 赭色強調字（editorial emphasis，不是按鈕） |
| `*文字*` | `<em>文字</em>` | 一般斜體（story 頁的內心獨白、引述句） |
| `<br>` | `<br>` | 強制換行（只用在 moniker 那種刻意斷行的標題） |

寫作原則見 `../CLAUDE.md`：主動語態、具體、不用行銷語言、不用 emoji。

## 回填時我會另外檢查的事

- 改到名字／頭銜／學歷 → 連帶更新 `<title>`、meta description、OG、Twitter card、
  JSON-LD `Person`、`images/henry-yang.vcf`（CLAUDE.md 的 SEO checklist）
- 改到 OG 的文案 → 分享圖 `og.html` 裡的字要不要跟著改、要不要重跑 `tools/render-og.sh`
- 內容長度變化很大 → 提醒你哪一欄可能會撐破版面（index 是兩欄卡片，story 是 900px 單欄）
