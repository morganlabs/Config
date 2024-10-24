{ ... }:
{
  urls = [
    {
      template = "https://www.phind.com/search";
      params = [
        {
          name = "q";
          value = "{searchTerms}";
        }
      ];
    }
  ];

  # icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
  definedAliases = [ "@ph" ];
}
