"""Check the native dependency and writable data without starting Anki's GUI."""

import ast
import pathlib
import sys
import tempfile
import types

sys.path.insert(0, str(pathlib.Path("mecab_controller").resolve()))
from basic_mecab_controller import BasicMecabController

result = BasicMecabController().run("日本語")
assert "日本語" in result and result.endswith("EOS"), result

# Load only the path helper, avoiding imports that require a running Anki UI.
tree = ast.parse(pathlib.Path("helpers/file_ops.py").read_text())
helper = next(node for node in tree.body if isinstance(node, ast.FunctionDef) and node.name == "user_files_dir")
helper.decorator_list = []
with tempfile.TemporaryDirectory() as base:
    sys.modules["aqt"] = types.SimpleNamespace(mw=types.SimpleNamespace(pm=types.SimpleNamespace(base=base)))
    namespace = {"pathlib": pathlib}
    exec(compile(ast.Module(body=[helper], type_ignores=[]), "file_ops.py", "exec"), namespace)
    directory = namespace["user_files_dir"]()
    assert directory == pathlib.Path(base) / "addons21/200813220/user_files"
    (directory / "test").write_text("writable")
