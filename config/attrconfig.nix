{ name, recursive ? true, ... }:

{
  "${name}" = {
    source = ./${name};
    recursive = recursive;
  };
}
