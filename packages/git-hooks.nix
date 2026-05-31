{
  inputs,
  stdenv,
  writeShellScriptBin,
}:
let
  config = inputs.self.checks.${stdenv.hostPlatform.system}.git-hooks.config;
  inherit (config) package configFile;
in
writeShellScriptBin "git-hooks" ''
  ${pkgs.lib.getExe package} run --all-files --config ${configFile}
''
