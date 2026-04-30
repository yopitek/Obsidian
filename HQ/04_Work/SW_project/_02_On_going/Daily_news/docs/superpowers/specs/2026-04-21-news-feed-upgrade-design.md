# news_feed Upgrade Design
**Date:** 2026-04-21  
**Repo:** https://github.com/yopitek/news_feed  
**Status:** Approved — ready for implementation

---

## Problem & Goal

The existing daily news digest (4 tabs, RSS-only, FT-style email) works well but uses a limited set of feeds. Two new Obsidian resources unlock two improvements:

1. **`rss_feeds.md`** — 150+ curated feeds across tech blogs, news, and developer writing
2. **`twitter_resource.md`** — 65 AI practitioner Twitter/X accounts with a pre-defined weekly digest prompt

The upgrade adds a **5th Tech Blogs tab** to the daily digest and a brand-new **weekly AI digest email** (Mondays), while polishing the existing FT design.

---

## Approach: Full Upgrade (Option C)

Chosen over "feed quality only" (A) or "Twitter-only" (B) because it delivers maximum value while reusing the existing Python pipeline with minimal risk. The weekly pipeline is fully independent — a failure there never affects the daily email.

---

## Section 1 — System Architecture

### Daily Pipeline (unchanged schedule: Mon–Sun 08:00 Taipei)

```
feeds.yaml (updated) + tech_blogs.yaml (new)
        ↓
feed_fetcher.py  →  normalizer  →  deduper
        ↓
summarizer.py  (zh tabs → DeepSeek; tech_blogs → RSS excerpt, no AI)
        ↓
renderer_email.py + renderer_web.py  (5-tab layout, FT refined)
        ↓
Email (SMTP) + GitHub Pages
```

GitHub Action: `.github/workflows/daily_digest.yml` — no change needed (Python code handles `tech_blogs.yaml` loading transparently)

### Weekly Pipeline (new: Monday only, 08:00 Taipei)

```
twitter_resource.md  (65 accounts list)
        ↓
twitter_searcher.py  →  Tavily Search API
   batches of 10 accounts, freshness=week
   keywords: tool, workflow, method, tutorial, prompt, tip, guide, framework
   priority accounts: @karpathy @danshipper @swyx @zarazhangrui @rauchg
        ↓
filter_and_score()  →  top 5–10 items (P1: immediately usable, P2: methodology, P3: mindset)
        ↓
DeepSeek  →  per-item structured summary (core method · why useful · link)
        ↓
weekly_renderer.py  →  weekly_email.html template
        ↓
Separate email: subject "AI乾貨週報 · Week N · YYYY-MM-DD"
+ saved to output/weekly/YYYY-MM-DD.html
```

GitHub Action: `.github/workflows/weekly_digest.yml` — new file, cron `0 0 * * 1` (Monday 00:00 UTC = 08:00 Taipei)

**New secret required:** `TAVILY_API_KEY`

---

## Section 2 — Feed Configuration

### Updated `feeds.yaml`

Current 4-tab structure is preserved. Changes:

| Tab | Change |
|-----|--------|
| `zh_news` | No change — CNA feeds already correct |
| `zh_industry` | No change |
| `en_news` | Add sub-groups: `startups` (HN, TechCrunch Startups, Sam Altman, Andrew Chen), `tech` (Verge, Forbes, SlashGear, TechCrunch), `general` (BBC top/world/business/tech, AP, NBC, ABC, CBS) |
| `ja_news` | Add remaining Yahoo JP categories: 国内, 国際, 経済, エンタメ, スポーツ, IT, 科学, 地域 |

### New `config/tech_blogs.yaml`

18 curated blogs, grouped by topic:

```yaml
tech_blogs:
  name: Tech Blogs
  item_limit: 5           # top 5 most-recent across all blogs
  use_ai_summary: false   # use RSS excerpt directly
  sources:
    # AI / ML
    - { id: blog_001, name: "Simon Willison", url: "https://simonwillison.net/atom/everything/" }
    - { id: blog_021, name: "Gary Marcus", url: "https://garymarcus.substack.com/feed" }
    - { id: blog_041, name: "Dwarkesh Patel", url: "https://www.dwarkeshpatel.com/feed" }
    - { id: blog_045, name: "Max Woolf", url: "https://minimaxir.com/index.xml" }
    - { id: blog_046, name: "geohot", url: "https://geohot.github.io/blog/feed.xml" }
    - { id: blog_061, name: "Gwern", url: "https://gwern.substack.com/feed" }
    # Engineering / Systems
    - { id: blog_027, name: "matklad", url: "https://matklad.github.io/feed.xml" }
    - { id: blog_055, name: "Eli Bendersky", url: "https://eli.thegreenplace.net/feeds/all.atom.xml" }
    - { id: blog_057, name: "Fabien Sanglard", url: "https://fabiensanglard.net/rss.xml" }
    - { id: blog_088, name: "Miguel Grinberg", url: "https://blog.miguelgrinberg.com/feed" }
    # Security
    - { id: blog_004, name: "Krebs on Security", url: "https://krebsonsecurity.com/feed/" }
    - { id: blog_076, name: "Troy Hunt", url: "https://www.troyhunt.com/rss/" }
    # Startups / Product
    - { id: blog_047, name: "Paul Graham", url: "http://www.aaronsw.com/2002/feeds/pgessays.rss" }
    - { id: blog_073, name: "Steve Blank", url: "https://steveblank.com/feed/" }
    - { id: blog_043, name: "Ed Zitron", url: "https://www.wheresyoured.at/rss/" }
    - { id: blog_089, name: "Keygen.sh", url: "https://keygen.sh/blog/feed.xml" }
    # Writing / Commentary
    - { id: blog_005, name: "Daring Fireball", url: "https://daringfireball.net/feeds/main" }
    - { id: blog_010, name: "Pluralistic", url: "https://pluralistic.net/feed/" }
```

---

## Section 3 — New & Changed Files

### New files

**`src/twitter_searcher.py`**  
- Reads account list (hardcoded from `twitter_resource.md`, or loaded from `config/twitter_accounts.yaml`)  
- Batches accounts 10–15 at a time  
- Calls Tavily Search API: query = `site:twitter.com OR site:x.com @{handle} (tool OR workflow OR tutorial OR prompt OR framework)`, `days=7`  
- Returns list of `{handle, text, url, score}` dicts  
- Priority accounts processed first; total Tavily calls = 7 batches of 10 (65 accounts ÷ 10, fits free tier easily)

**`src/weekly_renderer.py`**  
- Accepts filtered tweet list  
- Calls DeepSeek once per item: generates `{title, core_method, why_useful}` in Traditional Chinese  
- Renders `templates/weekly_email.html` with Jinja2  
- Returns HTML string + plain-text fallback

**`config/twitter_accounts.yaml`** *(optional — keeps accounts editable without code changes)*

**`templates/weekly_email.html`**  
- FT-refined style (same CSS variables as daily email)  
- Header: "AI乾貨週報 · Week {N} · {date}"  
- Each item: type badge (🛠️/💡/📝/🚀) · title · handle · core method bullets · why useful · link  
- Footer: scan stats (accounts scanned · items found · items included)

**`.github/workflows/weekly_digest.yml`**  
- `cron: '0 0 * * 1'` (Monday 00:00 UTC)  
- Same Python setup as `daily_digest.yml`  
- Env vars: `TAVILY_API_KEY`, `DEEPSEEK_API_KEY`, `SMTP_*`, `EMAIL_RECIPIENT`  
- On failure: upload HTML artifact (same pattern as daily)

### Modified files

| File | Change |
|------|--------|
| `feeds.yaml` | Expand `en_news` sub-groups; expand `ja_news` Yahoo JP categories |
| `src/feed_fetcher.py` | Load `tech_blogs.yaml` in addition to `feeds.yaml`; tag items with `source_type: tech_blog` |
| `src/summarizer.py` | Skip AI summarization for `source_type == tech_blog` (use RSS description directly) |
| `src/renderer_email.py` | Add 5th tab render block for Tech Blogs |
| `src/renderer_web.py` | Add 5th tab render block for Tech Blogs |
| `templates/email.html` | Add 5th tab anchor + section; apply FT polish (spacing, dividers, typography) |
| `templates/web.html` | Add 5th tab JS switch + section; apply FT polish |
| `src/main.py` | Wire up tech_blogs pipeline; no structural change |
| `.github/workflows/daily_digest.yml` | No change needed — Python handles `tech_blogs.yaml` transparently |

---

## Section 4 — Error Handling & Cost

### Daily digest
- Tech blog fetch failures: skip silently (same pattern as current feeds)  
- If fewer than 3 tech blog items retrieved: omit Tech Blogs tab from that day's output

### Weekly digest
- Tavily failures: retry once, then skip that batch — continue with remaining accounts  
- DeepSeek failures per item: fall back to raw tweet text (truncated to 200 chars)  
- If total items < 3: skip sending; log warning to GitHub Actions  
- On complete failure: save partial HTML as artifact

### Cost estimate
| Component | Usage | Cost |
|-----------|-------|------|
| Tavily Search | ~7 calls/week (batched) | Free tier (1,000/month) |
| DeepSeek summaries | ~10 summaries/week × 52 | Minimal (~$0.01/week) |
| Tech blog RSS | 18 feeds/day | Free |

---

## Section 5 — Design (FT Refined)

The existing FT aesthetic is kept. Specific polish applied to both email and web templates:

- **Typography**: increase article title `line-height` to 1.35; source/time line gets `0.78rem` (currently too large relative to title)
- **Section dividers**: replace `border-bottom` hairlines with `2px` top border on section headers (more editorial)
- **Tab bar**: active tab gets `border-bottom: 3px solid #333` underline treatment (currently just color change)
- **Tech Blogs tab accent**: `#8B4513` (saddle brown) to distinguish from news tabs — matches the warm FT palette
- **Weekly email header**: masthead style — large serif date, week number, horizontal rule

No structural layout changes. Email CSS stays conservative (inline styles, no media queries) for compatibility.

---

## Out of Scope

- Real-time updates
- User personalization / multiple subscribers
- Full-text article crawling
- Translating tech blog content to Chinese
- Twitter replies/threads (headlines only)

---

## New GitHub Secret

Add `TAVILY_API_KEY` to the repository secrets. Get a free API key at https://tavily.com.

All other secrets (`DEEPSEEK_API_KEY`, `SMTP_*`, `EMAIL_RECIPIENT`) are unchanged.
