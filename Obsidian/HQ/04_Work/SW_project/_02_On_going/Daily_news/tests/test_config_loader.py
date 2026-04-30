"""
Test for load_tech_blogs_config() in config_loader.py
"""
import pytest
from pathlib import Path
import yaml
from src.config_loader import load_tech_blogs_config
from src.models import FeedsConfig, TabConfig


def test_tech_blogs_config_returns_feeds_config():
    config = load_tech_blogs_config()
    assert isinstance(config, FeedsConfig)


def test_tech_blogs_config_has_tech_blogs_tab():
    config = load_tech_blogs_config()
    assert "tech_blogs" in config.tabs


def test_tech_blogs_config_tab_has_18_sources():
    config = load_tech_blogs_config()
    tab = config.tabs["tech_blogs"]
    assert len(tab.sources) == 18


def test_tech_blogs_config_tab_properties():
    config = load_tech_blogs_config()
    tab = config.tabs["tech_blogs"]
    assert isinstance(tab, TabConfig)
    assert tab.language == "en"
    assert tab.item_limit == 5
    assert tab.name == "Tech Blogs"


def test_tech_blogs_config_file_not_found():
    from pathlib import Path
    import pytest
    with pytest.raises(FileNotFoundError):
        load_tech_blogs_config(path=Path("config/nonexistent.yaml"))