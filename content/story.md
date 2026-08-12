# story.html — 長篇故事頁內容

> 編輯規則見 `README.md`。**不要動 `### [block-id]` 那一行。**
> 行內標記：`==鈷藍螢光==` · `**赭色強調**` · `*斜體*`
>
> **新增：`**voice:**` 開頭的段落 = 「聲音行」。** 用在有人開口說話、或 Henry 的內心提問。
> 排版上會獨立成一行、斜體、放大到 17.5–21.5px、左邊一條赭色細線。
> 這是刻意跟 `beat`（鈷藍粗線 + 展示字體）分開的兩種語域：
> **鈷藍 = 敘事者的結論，赭色 = 別人的／自己的聲音。**
> 別人說出口的話保留引號，Henry 自己的想法不加引號。
>
> **版面規則：整頁只有一個欄寬。**
> 文字、標語、圖片全部對齊同一條左右邊界（`.band__inner{max-width:780px}`，內容 700px）。
> 只收窄段落、不收窄圖片會產生三種右邊界，讀起來像壞掉 —— 不要那樣做。
> 行寬靠**放大字級**（內文 19px）而不是收窄文字區塊來控制，實測每行 73–79 字元。
> 注意 `ch` 是「0」的字寬，比平均小寫字母寬，不能拿來推估字數，一定要實際量。
>
> 章節結構（重編後 · 共 7 章）與色帶：
>
> | 章 | 標題 | 底色 |
> |---|---|---|
> | — | Hook | 深藍 ink |
> | 01 | The room | 深藍 ink |
> | 02 | Rewind | 米色 tint |
> | 03 | The turn | 深藍 ink |
> | 04 | The hire ← **新章** | 深藍 ink |
> | 05 | Again | 米色 tint |
> | 06 | So this is why | 深藍 ink |
> | 07 | Two mirrors | 米色 tint |
> | — | Foot | 鈷藍 cobalt |
>
> 圖片位置以 `> 🖼 IMG-xx` 標示。編號 = **文章順序**，不是 Henry 傳圖的順序。
> 檔名對照（放在 `images/story/`）：
>
> | 檔名 | 內容 | 章節 | 狀態 |
> |---|---|---|---|
> | `01-warehouse-collapse.jpg` | 癱在貨包堆上 | 01 | ✅ |
> | `02-the-hoodies.jpg` | HSNU 1947 帽 T 三色 | 01 | ✅ |
> | `03-building-the-sheet.jpg` | 抱著筆電趕工 | 01 | ✅ |
> | `04-student-council.jpg` | 學生會競選人像 | 02 | ✅ |
> | `05-warehouse-crew.jpg` | 倉庫大合照 | 02 | ✅ |
> | `06-sports-day.jpg` | 體育館大合照 | 02 | ✅ |
> | `07-message-wall.jpg` | 留言黑板 | 02 | ✅ |
> | `08-inventory-spreadsheet.png` | 預購試算表（保留原解析度） | 03 | ✅ |
> | `09-microsoft-years.jpg` | 微軟時期拼圖 | 04 | ✅ |
> | `10-late-night-study.jpg` | 深夜在家苦讀（主圖） | 05 | ✅ |
> | `11-podcast-recording.jpg` | 錄 Podcast | 05 | ✅ |
> | `12-cafe-study.jpg` | 咖啡廳讀書 | 05 | ✅ |
> | `13-microsoft-build.jpg` | Microsoft Build HK 台上 | 05 | ✅ |
> | `14-fever-at-home.jpg` | 在家發燒 | 05 | ✅ |
> | `15-hospital-iv.jpg` | 住院點滴 | 05 | ✅ |
>
> **15 張全數就位、已壓縮（94 MB → 4.3 MB）。**
> 06、07 兩章與結尾不放圖 —— 那是結論段落，不是場景。

---

## A. Meta / SEO

> **這一區沒有一個字會出現在頁面上。** 它們分別長在三個地方：
>
> | 欄位 | 出現在哪 | 誰會看到 |
> |---|---|---|
> | `meta.title` | 瀏覽器分頁名、Google 搜尋結果的**藍色標題** | 用 Google 搜「Henry Yang」的人 |
> | `meta.description` | Google 搜尋結果標題下的**灰色說明文字** | 同上，決定他要不要點進來 |
> | `meta.og-*` | 貼到 LinkedIn / Slack / WhatsApp 時彈出的**預覽卡片** | 你直接把連結傳給的人 |
>
> **你的直覺是對的。** 現行的 description 以「A student council office in 2016」開頭 ——
> 那是給讀者的敘事鉤子，不是給搜尋結果用的。
> 有人 google 你的名字時，他想知道的是「這人現在是誰」，不是 2016 年的一間辦公室。
> 而且「student council」這個詞會把你的搜尋結果往「高中生」的語意拉。
>
> 以下三個提案，**選一個或混搭都可以**。長度都控制在 155–160 字元內
> （Google 大約在 160 字元截斷）。

### [meta.title]

Who is Henry Yang — The Story

### [meta.description]

> ✅ **已選提案 A（職涯導向）**。先講你是誰、做什麼，故事只是佐證。
> 三個可搜尋的關鍵字都在：productivity technology、Microsoft、Kellogg。
> 165 字元，Google 大約在 160 截斷，尾巴的 burnout 可能被切掉 —— 但前半段的資訊已經完整。
> （被淘汰的是：B 主張導向、C 敘事導向。要換回來隨時說。）

Why Henry Yang builds productivity technology: ten years from a high school spreadsheet to Microsoft to Kellogg, and the two times a system pulled him out of burnout.

### [meta.og-title]

Who is Henry Yang — The Story

### [meta.og-description]

> og 是給「人」看的，不是給搜尋引擎看的，所以可以比 description 更有情緒、更短。
> 現行這句我建議留著 —— 它跟分享圖上印的字是同一組，看起來會很整。

Nobody likes to work. I was obsessed with being busy anyway. The origin story, and how others see me.

---

## B. 返回連結

### [top.backlink]

Henry Yang

---

## C. Hook — 開場鉤子（深藍底）

### [hero.kicker]

Who is Henry

### [hero.lead]

The thing is — nobody actually likes to work.

### [hero.hook]

I was obsessed with it anyway. Not with the work itself, but with being ==busy== at it. Stacked projects, no white space on the calendar, the last train home. For a long time, that was the only evidence I had that I was worth anything.

### [hero.cut]

This is where it started.

---

## D. 01 · The room（深藍底）

### [ch01.kicker]

- num: 01
- label: The room

### [ch01.title]

Eight of us, one broken list.

### [ch01.scene-slug]

Student council office · autumn 2016 · almost 8pm

### [ch01.prose]

Eight of us were still there, counting boxes of school anniversary merchandise against a handwritten list that had been wrong since September. Two of my teammates were arguing about a number that would not reconcile. This happened most nights that season, and it happened every year before us.

We were all exhausted. Nobody wants to spend their evenings in a basement warehouse counting hoodies until eight.

> 🖼 **IMG-01 + IMG-02 — 並排兩張**
> `images/story/01-warehouse-collapse.jpg`（有人癱在成堆貨包上）
> `images/story/02-the-hoodies.jpg`（三色帽 T，HSNU 1947）
>
> 放在「We were all exhausted」正下方，做 2-up 並排。
> 左邊是量：藍綠色貨包堆到比人高，一個人四肢攤開躺在中間裝死，旁邊還有人比手指 ——
> 讀者不需要任何說明就懂「用手寫清單清點這個數量」是什麼概念。
> 右邊是物：黑、白、紅三件帽 T 攤在桌上。貨包是不透明的，看不出裡面裝什麼；
> 這張補上答案，而且**那三個顏色正好就是下一章試算表的三大欄位**（白／紅／黑）。
> 讀者到第 03 章看到那張表時，會自動把顏色對起來。

> 「聲音行」——獨立成行、斜體、赭色左線。見下方說明。

**voice:** This is stupid — there must be a better way to do this.

I was seventeen. I went home that night and rebuilt the whole thing in a spreadsheet that synced to the cloud.

> 🖼 IMG-03 — 抱著筆電趕工（`images/story/03-building-the-sheet.jpg`）
> 放在這一句之後，單張。這是全章唯一一張「你在動手」的畫面：筆電架在膝蓋上打字、
> 地上散落資料、另一手還抓著一杯甜點。上一句說「我回家把整件事重做成試算表」，
> 下面就是那個畫面本身。✅ IG 介面已裁掉。

### [ch01.beat]

The next year, one person did that job. Not eight.

### [ch01.pull-note]

I have spent ten years trying to explain why that mattered so much to me. This is the closest I have come.

---

## E. 02 · Rewind（米色底）

### [ch02.kicker]

- num: 02
- label: Rewind

### [ch02.title]

The scoreboard I was raised on.

### [ch02.prose]

To understand why a spreadsheet moved me that much, you need to know what I thought I was worth.

My parents both worked, and they were tired, and they gave me everything they had. I was too young to have the words for thank you, so I paid them back in the only currency I understood: the one with a clear external standard. I was the kid with the good grades. In Taiwan, that is not an achievement. That is an identity.

Then I got into the best high school in the country and met the boys who slept through class, played ball after school, and beat my scores anyway. I studied harder. I still lost. And a question opened up that I could not close:

**voice:** If I'm not the smartest, what exactly am I worth?

So I changed the game. I joined the student council and ran everything I could get my hands on — anniversary events, graduation, sports days — at a pitch that was close to obsessive.

> 🖼 IMG-04 — 學生會競選人像（`images/story/04-student-council.jpg`）
> 放在這一段之後，單張。「So I changed the game. I joined the student council.」
> 配一張穿制服、掛學生會彩帶、手指著前方的照片 —— 這是「換戰場」那一刻的臉。

If I could not be the smartest, I would be the one who worked hardest at everything outside the classroom. That was the whole plan.

> 🖼 **IMG-05 + IMG-06 — 並排兩張**
> `images/story/05-warehouse-crew.jpg`（倉庫大合照，舉著「27」紙牌）
> `images/story/06-sports-day.jpg`（體育館大合照，紅彩帶）
>
> 放在這一段之後，做 2-up 並排。
> 上一句剛講完「anniversary events, graduation, sports days —— 把能接的全接下來」，
> 這兩張各約四十人的大合照就是那份清單的實體證據：一張校慶、一張運動賽事。
>
> **注意：倉庫大合照從第 01 章搬到這裡。** 原本我把它讀成「故事現場」，
> 但它其實是一場活動的收工合照，跟第 01 章那個八個人加班對帳的夜晚不是同一件事。
> 放在這裡，它和體育館那張變成一組，語意才對得上。

A teammate ended it in one sentence.

**voice:** "You love being busy — fine. But stop pushing your standards onto us."

First rejected on grades. Now rejected on the one thing I had left.

> 🖼 IMG-07 — 留言黑板（`images/story/07-message-wall.jpg`）
> 放在這一章的最後，單張，當作情緒收尾。
> 一個人坐在地上，仰頭看著一整面別人寫滿的黑板 —— 畫面上你是唯一沒有留下字的人。
> 剛好接在「我僅剩的那一項也被否定了」後面，孤獨感是這一章的落點。
> **這張是四張裡我最確定的一個決定。** 如果你原本想把它放在別章，跟我說。

---

## F. 03 · The turn（深藍底）

### [ch03.kicker]

- num: 03
- label: The turn

### [ch03.title]

What the spreadsheet actually did.

### [ch03.prose]

That is the state I was in, in that office, at eight at night.

The system I built that autumn did the obvious things. It ended the recurring losses. It turned a profit. It saved a program that was one bad year away from being canceled for good.

> 🖼 IMG-08 — 那張試算表（`images/story/08-inventory-spreadsheet.png`）
> 放在這一段之後。這是全篇唯一的「證物」：三個顏色 × 五個尺寸、預購/實體/瑕疵/存貨，
> 最下面一格總收入 1,284,315。上一句說「它止住虧損、開始獲利」，下一格就給讀者看帳。
> 一個十七歲的人做出這張表，這件事本身就是論點。
> ✅ **做成可點擊放大**（縮圖看不清數字，放大後的細節才是說服力來源）。
> ✅ **全頁唯一一張有說明文字的圖**，下方加一行 mono 小字：
>
> `The actual spreadsheet, autumn 2016. Not a recreation.`
>
> 這一行必要 —— 少了它，讀者會預設這是後來重畫的示意圖，證物就變成插圖。

But that is not the part I remember. What I remember is that nobody argued about the count again, and nobody stayed until eight. For two years I had been trying to prove my worth by ==out-working== the people around me and being the busiest person in the room — and the thing that finally made me feel worth something was ==taking work away== from them.

Standing in that office, I remember thinking: this is valuable. So *this* is what valuable feels like.

It was the first evidence I had that I might be good at something other than being the best in the room. I was good at finding the simple logic underneath a mess, and building it into something that helped other people work less.

That was also the first time I fell in love with technology — because of Excel.

**voice:** Technology can really change people's lives.

---

## G. 04 · The hire（深藍底）← 新章

> 這一章是你新增的。四句重複的草稿併成三段，你所有的資訊點都保留。
>
> **依你的要求加強了前後呼應**，這一章現在往回勾了三處、往前勾了一處：
>
> | 這一章的句子 | 呼應到 |
> |---|---|
> | a seventeen-year-old **on his bedroom floor** | 01「I went home that night and rebuilt the whole thing」+ IMG-03 那張照片 |
> | **find the simple logic underneath a mess** | 03 幾乎一字不差的原句 |
> | not **eight students in a basement** | 01「Eight of us were still there」+ 標題「Eight of us, one broken list.」 |
> | so they can **go home** | 往前接 06「That is giving somebody their evening back」 |
>
> 最後那句用你指定的 **"It was just a tool. It became my passion."**
> 我把它拆成兩個短句 —— 你原本寫成一句（but eventually became），
> 但這一章是全頁最短的一章，收在兩個三字節奏的斷句上，力道比連起來強。
> 想要原本的長句版本跟我說。
>
> ✅ 年份已定案為 **five years**（2016 → 2021）。與 V-Care Day 2021 的照片一致，
> 也與第 05 章「2023 年時已賣了三年」對得上。

### [ch04.kicker]

- num: 04
- label: The hire

### [ch04.title]

The tool raised me, then hired me.

### [ch04.prose]

Fast forward five years. I joined Microsoft — and guess which team I landed on. Modern Workplace productivity, with Excel sitting in my portfolio.

The spreadsheet a seventeen-year-old taught himself on his bedroom floor had become the thing I stood on stages to explain. Same tool. Same idea: find the simple logic underneath a mess, and hand it to people so they can go home. Only now the room was not eight students in a basement — it was millions of professionals I will never meet.

It was just a tool. It became my passion.

> 🖼 IMG-09 — 微軟時期拼圖（`images/story/09-microsoft-years.jpg`）
> 放在本章末，一張撐滿整章。這張已經是組好的五格拼圖：
> M365 圖示（Excel 在正中間）、香港團隊合照、雙螢幕辦公桌、V-Care Day 2021、攝影棚錄影。
> 左上角那顆 Excel 圖示直接接住「with Excel sitting in my portfolio」，不用另外解釋。
>
> ⚠️ 這張自帶斜切邊的設計語言，跟 Cobalt Bone 的直角＋2px 邊框＋硬陰影不同調。
> **解法：外面包一層標準的 2px ink 邊框 + 4px 硬陰影**，框住之後會讀成「一張被引用的圖」，
> 而不是「一塊風格跑掉的素材」。不建議拆成五張單圖，那會讓這章長度失控。

---

## H. 05 · Again（米色底）

### [ch05.kicker]

- num: 05
- label: Again

### [ch05.title]

I did not learn it the first time.

### [ch05.prose]

In 2023 I decided to apply to business school. My work experience was thin, my undergraduate GPA was not what it needed to be, and the old question came back wearing a new costume:

**voice:** What makes you think you're good enough for this?

So I did exactly what seventeen-year-old me did. In the second half of that year alone I sat the GMAT, sat the highest level of the Japanese proficiency exam, launched a tech podcast that reached the top 15 in Hong Kong, finished an MIT data analytics course, earned an ESG certification, held down my full-time job at Microsoft, and got nominated for an award given to the top three percent of employees worldwide.

> 🖼 **IMG-09 ~ IMG-12 — 四張一組，這是全頁最重要的一個版面**
> `10-late-night-study.jpg`（深夜在家用 iPad 手寫，右邊螢幕滿滿的行事曆）
> `11-podcast-recording.jpg`（家裡錄 Podcast，大麥克風 + 防噴罩 + 剪音軌）
> `12-cafe-study.jpg`（咖啡廳裡穿牛仔外套讀 iPad）
> `13-microsoft-build.jpg`（Microsoft Build Hong Kong 台上拿麥克風）
>
> 這一段的力量來自「清單長到荒謬」——GMAT、日檢 N1、Podcast、MIT 課程、ESG 認證、
> 微軟正職、全球前 3% 提名，全部塞在六個月裡。四張照片同時出現，
> **版面的擁擠本身就是論點**，不需要再寫一句「我當時很忙」。
>
> **版面建議：IMG-10 放大當主圖，其餘三張排成一列在下方。**
> 理由是 IMG-09 右邊那台螢幕上是一整片沒有空隙的行事曆 ——
> 這正好回扣開場 Hook 的「no white space on the calendar」，是全頁唯一一次
> 文字與畫面對到同一個意象。做成四宮格等分的話這個細節會小到看不見。
> （備案：2×2 等分四宮格，responsive 比較好處理，但會失去上面那個呼應。）
>
> ⚠️ 壓縮後我再看過 IMG-10 螢幕上的月份，1200px 寬時已經完全糊掉、讀不出來，
> 不會跟 2023 下半年打架。不用處理。

From the outside, that list reads like ambition. From the inside it was the same boy asking the same question, pretending that being busy was the same as being worth something. By then I was breaking down on a schedule.

I was sick constantly and tired all the time. Then, two weekends in a row, my fever climbed to almost 40°C and I was admitted to hospital for a full workup. Every indicator came back normal. **Deep down I already knew what it actually was: anxiety.**

> 🖼 **IMG-14 + IMG-15 — 並排兩張，依時序**
> `14-fever-at-home.jpg`（額頭貼退熱貼、癱在沙發上）
> `15-hospital-iv.jpg`（手背上的點滴針，病房桌）
>
> 順序照文字走：先在家發燒，再住院。左邊接「fever climbed to almost 40°C」，
> 右邊接「admitted to hospital for a full workup」。
>
> **版面要跟上面那組刻意相反。** 上面是四張擠在一起的高密度區塊（在演、在忙、在成就），
> 這裡只有兩張、留白拉大、不加任何說明文字。
> 讀者從「滿版的忙碌」捲到「兩張安靜的橫躺」，那個落差就是這一章的論證，
> 文字不用再多講一句。

The night I left the hospital and came home, my girlfriend asked me the question that went straight through me:

**voice:** "Why do you keep wearing yourself down to nothing, and then come home like that to the people who love you?"

That was a punch to the stomach. Somewhere along the way, the thing I had started as a way of repaying the people I love **had become the reason I was hurting myself and worrying them**. Was I keeping myself this busy so that I could watch them worry about me?

Here is the part that is hardest to admit. I had been selling productivity software at Microsoft for three years. Three years on stages explaining how it gives people their time back — **and I was not using any of it**. To me it was an app. A product. A thing in a deck.

Then I actually tried it. Frameworks first, Inbox Zero and Getting Things Done, then a second brain, then an AI agent I have been rebuilding ever since. Within a week I could ==see==, for the first time, exactly what I was carrying and what I was not. Within months, the specific anxiety of *I am so busy and I don't know what I am busy with* was simply gone.

### [ch05.beat]

Productivity tech pulled me out of that spiral of anxiety.<br>For the second time in my life.

> 🖼 **這一段刻意不放圖**（Henry 手上也沒有素材）。
> 這不是缺口，是這章的節奏：
> 四張擠成一團（忙碌）→ 兩張安靜橫躺（崩潰）→ 完全沒有圖（復原）。
> 視覺密度一路遞減，跟情緒曲線同步。復原是安靜的，版面也應該安靜。

---

## I. 06 · So this is why（深藍底）

> 這一章沒有 ch-title，直接進正文。

### [ch06.kicker]

- num: 06
- label: So this is why

### [ch06.prose]

Work is most of life. If I can take a little friction and a little confusion out of someone's work — if I can hand a person, or a team, something they could not do the day before — that is not a small thing. That is giving somebody their evening back.

### [ch06.lie-tag]

The lie I believed

### [ch06.lie-text]

Do a little more, prepare a little harder, and the value will finally be seen.

### [ch06.truth-tag]

What was actually true

### [ch06.truth-text]

Package what you know into a system other people can run, and it keeps working when you are not in the room.

### [ch06.pull-quote]

Technology should make people more capable, **not more busy**.

### [ch06.pull-note]

I do not say that as a slogan. I say it as someone who was the busiest person he knew, and was not more capable for it. That is why I work on productivity technology — not because it is a market, but because it ==saved== me twice, and I would like to be the one who does that for somebody else.

---

## J. 07 · Two mirrors（米色底）

### [ch07.kicker]

- num: 07
- label: Two mirrors

### [ch07.title]

Who I think I am, and who they say I am.

### [ch07.self-heading]

I consider myself as…

### [ch07.self-list]

- Someone whose gift is making complex things clear. My parents met in a university debate club; "say it again, make it clear this time" was a house rule before it was a career.
- A translator between technology and people in three languages, for whoever is in the room.
- A planner by nature. I like order. Productivity systems do on paper what I was already doing in my head.
- Someone who changed his own scoreboard: from *what did I finish* to *what keeps running when I'm not there*.

### [ch07.others-heading]

What other people see me as…

### [ch07.pills]

> 依你的決定：**不標出處**。前兩個是實心鈷藍的重點樣式，其餘一般樣式。

- Structured (hot)
- Inspiring (hot)
- Driven
- Curious
- Analytical
- All-rounded
- Perseverant
- Go-getter

### [ch07.consensus]

> 改成兩張小卡，沿用第 06 章 `lt-card`（謊言／真相）的形式，
> 但**標籤浮出卡片上緣**，像標籤紙夾在邊框上。
>
> 拿掉了：引言句「I asked ten friends...」、票數「Six of ten」「Four of ten」。

**card 1**
- tag: What Henry's best at
- a: He makes complicated things easy to understand.

**card 2**
- tag: Compare Henry to a product
- a: Notion（含標誌）

> ✅ **Notion 標誌換成 Henry 提供的檔案** —— Font Awesome Free 7.3.1，
> 圖示授權 CC BY 4.0。路徑用 `fill="currentColor"`，所以會自動吃頁面的 `--ink` 色。
> path 直接內嵌在 `story.html` 裡（省一次請求、拿得到 ink 色），
> 署名註解一併保留在標籤旁邊。原始檔留在 `images/notion.svg` 當來源存證。

### [ch07.testimonial-quote]

You take messy, scattered ideas and turn them into a beautifully structured, highly functional system that makes everyone else's lives easier and more productive.

### [ch07.testimonial-cite]

> 依你的決定：拿掉 Grace 的名字。

Colleague, Microsoft

### [ch07.disagree-heading]

Where they disagree with me

### [ch07.disagree-intro]

> 依你的決定：四句引言全部不署名。

Everything on my side of this page is about craft. But when I asked those same ten people what I should do *more* of, not one of them said craft.

### [ch07.disagree-quotes]

> ✅ 做成 **2×2 便利貼**：鈷藍底、白色斜體、2px ink 邊框 + 硬陰影，
> 每張帶 ±1 度的輕微傾斜（沿用名片頁 `Fun fact` 標籤既有的手法）。
> 視窗變窄時自動變成單欄。

- You should rest more.
- Give yourself short breaks.
- You share the joy of the means — I would like to see you think about what you actually want as the destination.
- Read a novel that isn't trying to teach you anything.

### [ch07.disagree-punch]

They see someone who has not learned how to stop. The seventeen-year-old is still in there.

---

## K. 結尾（鈷藍底）

> ✅ 用你指定的版本，一字未改（文法本來就沒問題）。正向收尾已確認。
>
> ✅ **拼字已統一為美式。** 掃過兩頁 HTML 和這份 md，實際只有兩處要動：
> 第 03 章 `cancelled` → `canceled`，以及 alt text 的 `colourways` / `totalling`
> → `colorways` / `totaling`。其餘本來就是美式。

### [foot.line]

I truly believe technology should never make us busier; it should make us more capable.

Ten years on, I still catch myself measuring my worth in output (and it is hard not to in an MBA classroom). The difference is that now I have systems that keep me organized and focused, and tell me when to rest. And I am building one that can do the same for other people.

### [foot.cta]

Back to the name card and contact

---

## L. 附錄：圖片 alt text 初稿

> alt text 是給讀螢幕的人、以及搜尋引擎看的文字描述，不會顯示在畫面上。
> 請複核內容有沒有寫錯（尤其人數、地點、事件名稱）。
> 原則：描述「畫面上看得到什麼」，不重複內文已經說過的話，不寫「一張照片顯示…」。

| 檔案 | alt text |
|---|---|
| `01-warehouse-collapse.jpg` | A student lying spread-eagled across a head-high stack of plastic-wrapped hoodie bundles in the storeroom, while another points at him. |
| `02-the-hoodies.jpg` | Three of the school anniversary hoodies in their packaging — black, cream and red, each printed HSNU 1947. |
| `03-building-the-sheet.jpg` | Henry at seventeen, hunched over a laptop balanced on his knees, surrounded by scattered event materials. |
| `04-student-council.jpg` | Henry in school uniform wearing a student council campaign sash, pointing off camera. |
| `05-warehouse-crew.jpg` | About forty student council members posed together in the corrugated-iron storeroom, holding a cardboard sign. |
| `06-sports-day.jpg` | Around forty students with red ribbons posed on a gymnasium basketball court after a sports day. |
| `07-message-wall.jpg` | Henry sitting on the floor, looking up at a large chalkboard covered edge to edge in handwritten messages. |
| `08-inventory-spreadsheet.png` | The inventory spreadsheet: three colorways across five sizes, tracking pre-orders, counter sales, defects and remaining stock, totaling NT$1,284,315 in revenue. |
| `09-microsoft-years.jpg` | Five photographs from Henry's Microsoft years: the Microsoft 365 app icons, the Hong Kong team, a desk of monitors, a company volunteering day, and a video shoot. |
| `10-late-night-study.jpg` | Henry writing on a tablet late at night at his home desk, a second monitor beside him showing a calendar with almost no free space. |
| `11-podcast-recording.jpg` | Henry recording a podcast at home, speaking into a condenser microphone with an audio editor open on the laptop in front of him. |
| `12-cafe-study.jpg` | Henry working through study material on a tablet in a café. |
| `13-microsoft-build.jpg` | Henry presenting on stage at Microsoft Build Hong Kong, microphone in hand. |
| `14-fever-at-home.jpg` | Henry asleep on a couch with a cooling patch on his forehead and a towel across his chest. |
| `15-hospital-iv.jpg` | Henry's hand resting on a hospital tray table, an IV line taped into the back of it. |

✅ 兩處說法已確認：
- `07-message-wall` 用 `handwritten messages`（Henry 確認那是一個活動，不是畢業道別）
- `01` 從 `merchandise bundles` 改成 `hoodie bundles`（看到帽 T 那張之後可以更具體）

---

## M. 附錄：已定案的決定

| 項目 | 決定 |
|---|---|
| ch04 年份 | five years（2016 → 2021） |
| Podcast 排名 | 兩頁都寫明 in Hong Kong |
| ch03 螢光筆 | 只留 `out-working` 與 `taking work away` 兩處 |
| 結尾語氣 | 維持正向收尾 |
| ch05 成就區 | IMG-09 放大當主圖 + 其餘三張排一列 |
| ch07 四句引言 | 四行堆疊 |
| 試算表 | 可點擊放大 + 一行說明文字 |
| 微軟拼圖 | 包 2px ink 邊框 + 硬陰影 |
| 其他圖片 caption | 全部不加 |
| 合照肖像 | 無疑慮，照登 |
| story 頁 meta description | 提案 A（職涯導向） |
| 拼字 | 全頁統一美式 |
| 圖片資產 | 15 張全數就位、已壓縮並改名（`images/story/`） |
| 待辦（排版後） | 大合照上用手繪風格圈出 Henry 的位置 |
