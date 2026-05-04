"""
Test for tech_blogs _source_type in feed_fetcher.py
"""
import responses as rsp
import responses
from src.config_loader import load_tech_blogs_config
from src.feed_fetcher import fetch_all_feeds


FAKE_RSS = """<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0"><channel>
  <title>Simon Willison</title>
  <item>
    <title>Test Entry</title>
    <link>https://simonwillison.net/2024/jan/1/test/</link>
    <description>Some description here</description>
    <pubDate>Mon, 01 Jan 2024 12:00:00 +0000</pubDate>
    <guid>https://simonwillison.net/2024/jan/1/test/</guid>
  </item>
</channel></rss>"""


@responses.activate
def test_fetch_all_feeds_tech_blogs_entries_have_source_type():
    """Tech blog entries should have _source_type: tech_blog"""
    config = load_tech_blogs_config()
    # Mock all 18 blog URLs
    for tab_id, tab in config.tabs.items():
        for source in tab.sources:
            responses.add(
                responses.GET, 
                source["url"], 
                body=FAKE_RSS, 
                content_type="application/rss+xml"
            )

    result = fetch_all_feeds(config)
    assert "tech_blogs" in result
    for entry in result["tech_blogs"]:
        assert entry.get("_source_type") == "tech_blog", f"Missing _source_type in: {entry}"