{
  lib,
  anki-utils,
  fetchFromGitHub,
  python3,
}:
anki-utils.buildAnkiAddon {
  pname = "kanjigrid";
  version = "0-unstable-2026-06-15";
  src = fetchFromGitHub {
    owner = "Kuuuube";
    repo = "kanjigrid";
    rev = "d235cae7bc8d6ad66c7b363fb5a4234b3dd66400";
    hash = "sha256-2Q2PNY/NMob5qHsQrpTC3Zukz7A2amkXgqQagqL2gyk=";
  };

  patches = [../support/kanjigrid/writable-user-files.patch];

  doCheck = true;
  nativeCheckInputs = [
    (python3.withPackages (ps: [ps.pytest ps.jsonschema]))
  ];
  checkPhase = ''
    runHook preCheck
    export PYTHONDONTWRITEBYTECODE=1
    python -m pytest tests/tests.py -v -p no:cacheprovider
    python ${../support/kanjigrid/check.py}
    runHook postCheck
  '';

  # Match upstream's release layout: Python files and grouping data together.
  preInstall = ''
    mkdir addon
    cp src/*.py src/config.json manifest.json LICENSE README.md addon/
    cp -r data addon/
    cd addon
  '';

  meta = {
    description = "Anki addon that visualizes kanji learning progress in a grid";
    homepage = "https://github.com/Kuuuube/kanjigrid";
    downloadPage = "https://ankiweb.net/shared/info/1610304449";
    license = lib.licenses.agpl3Only;
  };
}
