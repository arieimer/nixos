{
  lib,
  anki-utils,
  fetchFromGitHub,
  mecab,
  python3,
}: let
  ajtCommon = fetchFromGitHub {
    owner = "Ajatt-Tools";
    repo = "ajt_common";
    rev = "5b1da9ddac314b5f0457be71e76420eff18a3066";
    hash = "sha256-3h5mSz1MXJ1b6cwAiWzZQGBnnYM1kuZEWYf1bGyP3tM=";
  };
  mecabController = fetchFromGitHub {
    owner = "Ajatt-Tools";
    repo = "mecab_controller";
    rev = "d17412de23e4390f6d14a2d72876136d76b7288f";
    hash = "sha256-0gE+FxoaSjFh29yVBvCdiEfSfdYFEBOjna4gBeBySgM=";
  };
in
  anki-utils.buildAnkiAddon {
    pname = "ajt-japanese";
    version = "0-unstable-2025-10-21";
    src = fetchFromGitHub {
      owner = "arbyste";
      repo = "AJT-for-JPMN";
      rev = "45dd4584a83b34e5f6ef44b0370ec98bdf43b4a6";
      hash = "sha256-LG7hAjJzzI9+fO4FvcdKXwN4EGVcpjLj6rk6Qv8F2+A=";
    };
    sourceRoot = "source/japanese";

    # Fetch submodules separately because upstream uses SSH URLs.
    postUnpack = ''
      cp -r ${ajtCommon}/. "$sourceRoot/ajt_common/"
      cp -r ${mecabController}/. "$sourceRoot/mecab_controller/"
      chmod -R u+w "$sourceRoot"
    '';

    patches = [../support/ajt-japanese/writable-user-files.patch];
    postPatch = ''
      # Keep the bundled system and user dictionaries together, but use Nix's
      # MeCab executable and libraries rather than upstream's native binaries.
      substituteInPlace mecab_controller/basic_mecab_controller.py \
        --replace-fail 'find_executable("mecab"),' '"${mecab}/bin/mecab",' \
        --replace-fail '"--dicdir=" + find_best_dic_dir(),' '"--dicdir=" + SUPPORT_DIR,' \
        --replace-fail 'os.environ["DYLD_LIBRARY_PATH"] = SUPPORT_DIR' 'pass' \
        --replace-fail 'os.environ["LD_LIBRARY_PATH"] = SUPPORT_DIR' 'pass'
      rm mecab_controller/support/mecab.{lin,mac,exe} \
        mecab_controller/support/libmecab.{so.1,2.dylib,dll}
    '';

    doCheck = true;
    nativeCheckInputs = [python3];
    checkPhase = ''
      runHook preCheck
      PYTHONDONTWRITEBYTECODE=1 python ${../support/ajt-japanese/check.py}
      runHook postCheck
    '';

    meta = {
      description = "AJT Japanese for JP Mining Note";
      homepage = "https://github.com/arbyste/AJT-for-JPMN";
      downloadPage = "https://ankiweb.net/shared/info/200813220";
      license = lib.licenses.agpl3Plus;
      platforms = lib.platforms.linux ++ lib.platforms.darwin;
    };
  }
