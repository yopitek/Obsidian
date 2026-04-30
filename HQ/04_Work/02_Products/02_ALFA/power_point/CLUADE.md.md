Luxury Brand」的極簡與高級感，以下是幾款精品與頂級科技品牌最常使用的**無襯線字體 (Sans-serif)**，供您獨立驗證與參考：

1. 經典歐文無襯線字體（適合用於標題、數字與英文規格）

- **Futura**：極具代表性的幾何無襯線體，線條極度俐落、充滿現代主義的美感。許多頂級精品（如 Louis Vuitton）都採用此字體或其變體，能瞬間賦予版面前衛與時尚的氛圍。
- **Helvetica / Helvetica Neue**：設計界最經典、中性且乾淨的字體。它是許多高級品牌與科技精品（如 Apple、Fendi 等）的標準字體，非常適合用在簡報的內文與密集的規格表中，能保持極佳的易讀性與專業感。
- **Montserrat 或 Proxima Nova**：這兩款是近年在高級數位產品、精品電商設計中極度受歡迎的現代無襯線體。它們的字形寬闊大氣，且擁有非常豐富的字重（粗細）選擇。
- **Optima**：這是一款帶有微細粗細變化的「人文主義無襯線體」，兼具了無襯線的現代感與襯線體的古典優雅，非常適合用於大標題或引言。

2. 繁體中文字體搭配（適合用於中文解說與場景描述）

若您的簡報中包含繁體中文，建議搭配以下乾淨的黑體，以呼應英文的精品字體：

- **冬青黑體 (Hiragino Sans TC)**：常見於蘋果系統的高級中文字體，字形骨架清秀優雅，廣泛被許多強調質感的品牌與日系精品採用。
- **思源黑體 (Noto Sans TC) / 蘋方體 (PingFang TC)**：這兩款是目前最現代、乾淨的無襯線中文字體。

**💡 精品簡報排版訣竅**： 在字體應用上，Luxury Brand 風格的關鍵在於**「粗細對比」與「空間感」**。

1. **善用極細體 (Thin / Light)**：在標題或大大的數字（例如 3000 Mbps 或 WiFi 6E）使用極細的字重，可以表現出精緻與科技工藝感。
2. **拉寬字距 (Tracking / Letter-spacing)**：嘗試將**英文大標題設定為「全大寫 (ALL CAPS)」，並適度拉寬字母之間的間距**，這也是各大時尚精品最愛用來營造尊貴與大氣感的文字排版手法。

工作原則:
Think Before Coding → **在寫代碼前先思考，阻斷錯誤假設和遺漏的權衡**
Simplicity First → **簡單優先，阻止過度工程化和臃腫的抽象**
Surgical Changes → **精準修改，只動需要改的代碼，不碰其他**
Goal-Driven Execution → **目標驅動，先寫測試，明確驗證標準**

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]