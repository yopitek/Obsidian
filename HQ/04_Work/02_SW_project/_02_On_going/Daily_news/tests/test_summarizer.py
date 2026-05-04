"""
Test for tech_blogs bypass in summarizer.py
"""
from datetime import datetime, timezone
from src.models import NormalizedArticle
from src.summarizer import summarize_by_category


def make_tech_blog_article(desc="Read the full post at simonwillison.net about tooling."):
    return NormalizedArticle(
        title="LLM Tooling Update",
        link="https://simonwillison.net/post",
        published=datetime.now(timezone.utc),
        source_name="Simon Willison",
        language="en",
        tab="tech_blogs",
        rss_category="Tech Blogs",
        guid="guid-tech-001",
        description=desc,
        final_category=None,
    )


def test_tech_blogs_skips_ai_uses_description():
    """Tech blogs should use RSS description directly, not AI"""
    articles = [make_tech_blog_article()]
    selected = {"tech_blogs": {"Tech Blogs": articles}}
    # Pass None as api_key — should NOT raise because AI is skipped
    result = summarize_by_category(selected, api_key=None)
    assert "tech_blogs" in result
    assert "Tech Blogs" in result["tech_blogs"]
    summarized = result["tech_blogs"]["Tech Blogs"]
    assert len(summarized) == 1
    assert summarized[0].summary == articles[0].description[:300]
    assert summarized[0].title == "LLM Tooling Update"


def test_tech_blogs_description_truncated_at_300():
    """Tech blogs description should be truncated at 300 chars"""
    long_desc = "x" * 500
    articles = [make_tech_blog_article(desc=long_desc)]
    selected = {"tech_blogs": {"Tech Blogs": articles}}
    result = summarize_by_category(selected, api_key=None)
    assert len(result["tech_blogs"]["Tech Blogs"][0].summary) == 300