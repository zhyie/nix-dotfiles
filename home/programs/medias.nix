{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      qimgv nsxiv
      mpv smplayer
      ffmpeg yt-dlp
    ;
  };
}
