with import <nixpkgs> {};

writeShellScriptBin "hello" ''
  ${builtins.readFile ./hello.sh}
''
