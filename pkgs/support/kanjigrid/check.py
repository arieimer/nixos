"""Exercise grouping loading and logging without starting Anki's GUI."""

import importlib
import pathlib
import shutil
import sys
import tempfile
import types

with tempfile.TemporaryDirectory() as base, tempfile.TemporaryDirectory() as addon:
    # Assemble the release layout, where data lives beside the Python modules.
    shutil.copytree("src", addon, dirs_exist_ok=True)
    shutil.copytree("data", pathlib.Path(addon) / "data")
    sys.modules["aqt"] = types.SimpleNamespace(mw=types.SimpleNamespace(pm=types.SimpleNamespace(base=base)))
    package = types.ModuleType("kanjigrid")
    package.__path__ = [addon]
    sys.modules["kanjigrid"] = package
    data = importlib.import_module("kanjigrid.data")
    logger = importlib.import_module("kanjigrid.logger")

    data.init_groups()
    bundled_count = len(data.groupings)
    assert bundled_count > 0
    user_files = pathlib.Path(base) / "addons21/1610304449/user_files"
    assert (user_files / "data").is_dir()
    shutil.copyfile(next(pathlib.Path("data").glob("*.json")), user_files / "data/custom.json")
    data.init_groups()
    assert len(data.groupings) == bundled_count + 1

    logger.log("test message")
    logger.error_log("test error")
    logs = list((user_files / "logs").glob("*.log"))
    assert len(logs) == 2
    assert any("test message" in path.read_text() for path in logs)
    assert any("test error" in path.read_text() for path in logs)
