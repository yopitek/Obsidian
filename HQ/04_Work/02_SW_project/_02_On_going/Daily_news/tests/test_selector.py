"""
Test for tech_blogs tab in selector.py
"""
import pytest
from src.selector import TAB_CATEGORIES, ITEMS_PER_CATEGORY, map_to_display_category, select_by_category
from src.models import NormalizedArticle
from datetime import datetime, timezone


def make_blog_article(title="Test Post", tab="tech_blogs", rss_category="Tech Blogs"):
    return NormalizedArticle(
        title=title,
        link="https://example.com/post",
        published=datetime.now(timezone.utc),
        source_name="Simon Willison",
        language="en",
        tab=tab,
        rss_category=rss_category,
        guid="guid-001",
        description="A test description",
        final_category=None,
    )


def test_tech_blogs_in_tab_categories():
    assert "tech_blogs" in TAB_CATEGORIES
    assert TAB_CATEGORIES["tech_blogs"] == ["Tech Blogs"]


def test_tech_blogs_in_items_per_category():
    assert "tech_blogs" in ITEMS_PER_CATEGORY
    assert ITEMS_PER_CATEGORY["tech_blogs"] == 5


def test_map_to_display_category_tech_blogs():
    article = make_blog_article()
    assert map_to_display_category(article) == "Tech Blogs"


def test_select_by_category_includes_tech_blogs():
    articles = [make_blog_article(f"Post {i}") for i in range(8)]
    result = select_by_category(articles)
    assert "tech_blogs" in result
    assert "Tech Blogs" in result["tech_blogs"]
    assert len(result["tech_blogs"]["Tech Blogs"]) == 5  # capped at ITEMS_PER_CATEGORY