{ host, home, ... }:

let
  devFlakeRoot = "${home}/dev/dotfiles/nix-darwin/eryx";
  devFlake = "${devFlakeRoot}/develop";
  devProfiles = "${devFlakeRoot}/.nix-profiles";
  devShellNames = [ "dev" "tools" ];

  mkDevShellFunction = shellName: ''
    function ${shellName} --description "nix develop .#${shellName}"
      mkdir -p ${devProfiles}
      nix develop --profile ${devProfiles}/${shellName} devs#${shellName} -c fish $argv
    end
  '';

  rebuildFunction = ''
    function rebuild --description "Apply nix-darwin config"
      sudo darwin-rebuild switch --flake ${devFlakeRoot}#${host} $argv
    end
  '';
in
{
  nix.registry.devs.to = {
    type = "path";
    path = devFlake;
  };

  programs.fish.enable = true;

  programs.fish.interactiveShellInit = builtins.concatStringsSep "\n"
    ((map mkDevShellFunction devShellNames) ++ [ rebuildFunction ]);
}
