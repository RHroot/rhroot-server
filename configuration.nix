{
  config,
  pkgs,
  lib,
  modulesPath,
  ...
}: let
  pkgs = import (fetchTarball {
    url = "https://channels.nixos.org/nixos-25.11/nixexprs.tar.xz";
  }) {};
  unstable = import (fetchTarball {
    url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
  }) {};
in {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
    # My custom modules
    ./modules/base.nix
    ./modules/wireguard.nix
    ./modules/development.nix
  ];

  networking.hostName = "remote-nix";
  users.users.root = {
    hashedPassword = "$6$28aZM0l1BdYBUDI2$uvW8AflcBnPFLAAz7Mym7r07331JH8u1yZheJig3atk8NZmU0ROT/nH.5fxDsHjlXLLnwyAzQEVOmXpwAC2gD1";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEW8mjOvzdHXlLKP7p6+OHweFN2X6aqqid3EJHvGIWXC sten@r181104"
    ];
  };
  users.users.sten = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = ["wheel"];
    description = "sten";
    hashedPassword = "$6$28aZM0l1BdYBUDI2$uvW8AflcBnPFLAAz7Mym7r07331JH8u1yZheJig3atk8NZmU0ROT/nH.5fxDsHjlXLLnwyAzQEVOmXpwAC2gD1";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEW8mjOvzdHXlLKP7p6+OHweFN2X6aqqid3EJHvGIWXC sten@r181104"
    ];
  };

  environment.shells = with pkgs; [bash];
  environment.systemPackages = with pkgs; [
    curl
    git
    unstable.neovim
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  systemd.tmpfiles.rules = ["d /swap 0755 root root -"];
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 4096;
    }
  ];
  system.stateVersion = "25.11";
}
