# Report Designer — 視覺化報告生成技能

## When to use

需要將文字報告、數據表格、市場分析轉化為專業 PPT、資訊圖表或 PDF 文件時使用。

## Workflow

1. **Receive content** — 讀取來源報告（market-researcher / financial-analyst / orchestrator 輸出）
2. **Identify output type** — 判斷需要 PPT / 資訊圖表 / HTML 投影片 / PDF
3. **Select template** — 依品牌與用途選擇對應架構模板
4. **Extract structure** — 從報告中提取：標題、關鍵數據、圖表數據、結論
5. **Generate charts** — 用 AntV 或 python-pptx 生成數據圖表
6. **Apply brand** — 套用品牌色、字型、封面設計
7. **Assemble** — 組裝完整文件
8. **Export** — 輸出到 `11_Report_Designer/output/YYYY-MM-DD/`
9. **Notify** — 呼叫 obsidian-builder 記錄產出；視需求通知 social-publisher 發布

## PPT 生成範例（python-pptx）

```python
# via Bash: python3 generate_ppt.py
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor

prs = Presentation()

# 封面頁
slide = prs.slides.add_slide(prs.slide_layouts[0])
title = slide.shapes.title
title.text = "WiFi 7 市場週報 — 第 16 週"
title.text_frame.paragraphs[0].runs[0].font.color.rgb = RGBColor(0xFF, 0xFF, 0xFF)

# 設定品牌背景色（ACS 深藍）
fill = slide.background.fill
fill.solid()
fill.fore_color.rgb = RGBColor(0x00, 0x33, 0x66)

prs.save("output/2026-W16-market-report.pptx")
```

## 資訊圖表範例（Markdown 表格 → HTML）

```bash
# 使用 Pandoc 將 Markdown 轉為帶樣式的 HTML
pandoc report.md \
  --standalone \
  --css brand-style.css \
  -o output/report.html

# 再用 WeasyPrint 轉 PDF
python3 -c "from weasyprint import HTML; HTML('output/report.html').write_pdf('output/report.pdf')"
```

## Output format

```
## 報告設計完成
**標題：** [文件標題]
**類型：** PPT / 資訊圖表 / HTML / PDF
**品牌：** ACS / ALFA / Ubiquiti / yupitek
**頁數/張數：** [N]

### 產出檔案
| 格式 | 路徑 | 大小 |
|------|------|------|
| .pptx | HQ/04_Work/05_Agents/11_Report_Designer/output/2026-04-18/report.pptx | 2.4MB |
| .pdf | HQ/04_Work/05_Agents/11_Report_Designer/output/2026-04-18/report.pdf | 1.1MB |

### 後續動作
- Obsidian 記錄：✅
- 發布到社群：[是否轉交 social-publisher]
- 傳送給客戶：[是否需要]
```

## APIs & Tools used

- Bash + python-pptx（PPT 生成）
- Bash + Pandoc + WeasyPrint（PDF 生成）
- DeepSeek API（內容摘要與結構化）
- Read（讀取來源報告）
- Write（儲存輸出文件）
- Glob（批次處理多份報告）
