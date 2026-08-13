# 影片要怎麼放 — 三個做法

## 為什麼 LinkedIn 嵌入不行

那個 iframe 帶進來的不只是影片，是 LinkedIn 的**整張貼文卡**：頭像、姓名、
按讚留言列、他們的字型和白底卡片。在 Cobalt Bone 的版面裡它讀起來像貼上去的異物，
外面包一層 ink 邊框也救不回來 —— 因為突兀的是裡面，不是外面。

你要的其實只有**影片本身**。所以解法就是：把影片以外的東西全部拿掉。

---

## 這個分支做的：方案 A — 自己託管影片

**已經實作好了，`images/demo-poster.jpg` 目前是佔位圖。**

靜止狀態 100% 是站上自己的設計：ink 邊框、鈷藍播放鍵配硬陰影、
等寬小標籤。**點下去之前，頁面上不存在任何第三方的東西。**

### 你要準備兩個檔案

| 檔案 | 說明 |
|---|---|
| `images/demo.mp4` | 影片本身。H.264 + AAC，1280px 寬就夠了 |
| `images/demo-poster.jpg` | 封面靜圖，1280×720（目前是佔位圖，要換掉） |

影片可以從 LinkedIn 貼文下載，或直接用你原始的檔案。
封面圖建議從影片裡挑一格有畫面重點的，不要挑黑幀。

### 尺寸限制

GitHub Pages 單檔上限 **100 MB**、repo 建議 1 GB 以內、每月流量 100 GB。
一支 30–60 秒、1280px 的影片大約 **5–20 MB**，完全在範圍內。

如果你的檔案超過 25 MB 左右，先壓過再放（`-crf 26` 通常肉眼看不出差別）：

```
ffmpeg -i 原檔.mp4 -vf scale=1280:-2 -c:v libx264 -crf 26 -preset slow \
       -c:a aac -b:a 128k -movflags +faststart images/demo.mp4
```

`+faststart` 這個參數不能省 —— 它把索引搬到檔案開頭，影片才能邊載邊播，
不然使用者要等整支下載完才會動。

### 長寬比

元件用 CSS 變數控制，改 `index.html` 裡那一行就好：

```html
<figure class="vid" style="--vid-ratio: 16 / 9">   <!-- 橫式 -->
<figure class="vid" style="--vid-ratio: 1 / 1">    <!-- 方形，LinkedIn 常見 -->
<figure class="vid" style="--vid-ratio: 9 / 16">   <!-- 直式 -->
```

告訴我你的影片是哪一種，我調好。

---

## 方案 B — 上傳 YouTube（不公開），一樣用這個外框

如果影片很大、或你想要自動轉檔和 CDN，把影片設成 **unlisted** 傳上 YouTube，
外框和播放鍵完全不用改，只換點擊後載入的東西：

```js
var f = document.createElement('iframe');
f.src = 'https://www.youtube-nocookie.com/embed/影片ID?autoplay=1&rel=0';
f.allow = 'accelerated-media; autoplay; encrypted-media; picture-in-picture';
f.allowFullscreen = true;
figure.appendChild(f);
```

用 `youtube-nocookie.com` 而不是 `youtube.com` —— 前者在使用者按下播放前不放追蹤 cookie。

**跟方案 A 的差別**：靜止狀態一模一樣（都是你的封面圖 + 鈷藍播放鍵），
差別只在按下去之後會看到 YouTube 的播放器介面而不是瀏覽器原生的。
不佔 repo 空間，但多一個外部相依。

---

## 方案 C — 只放封面圖 + 連到 LinkedIn

最省事，但**不符合你說的「讓別人在網站上看到影片本身」** —— 使用者還是得跳出去。
列在這裡只是為了完整，不建議。

---

## 建議

**選 A。** 理由：

1. 你要的是「在網站上看到影片」，A 是唯一完全自己掌握播放體驗的做法
2. 沒有第三方 cookie、沒有登入牆、登出的訪客也看得到
3. 貼文如果哪天刪掉或改動，網站不受影響
4. 檔案大小在 GitHub Pages 的限制內綽綽有餘

**只有一種情況選 B**：影片超過 50 MB，或你之後想常常換片。

---

## 這個分支已經做完的事

- `.vid` 元件（`assets/css/v2.css`）
- `index.html` 的「Currently building」區塊，滿版放在兩欄下方
- 點擊才載入的 JS，靜止狀態零第三方請求
- 八個寬度（1280 → 320px）驗證無橫向溢出
- `images/demo-poster.jpg` 佔位圖

**還缺**：你的 `images/demo.mp4` 和真正的封面圖。
