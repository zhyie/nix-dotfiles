{
  checks,
  lib,
  stdenv,
  writeShellScriptBin,
}:

let
  inherit (checks.${stdenv.hostPlatform.system}.git-hooks.config)
    package
    configFile
    ;
in
writeShellScriptBin "git-hooks" ''
  ${lib.getExe package} run --all-files --config ${configFile}
''
