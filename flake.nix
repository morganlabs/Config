{
  description = "My NixOS Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop/Window Managers
    hyprland.url = "github:hyprwm/Hyprland";

    # Customisation
    nix-colors.url = "github:misterio77/nix-colors";
    nixcord.url = "github:kaylorben/nixcord";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim Plugins
    nvim-plugin-scroll-eof = {
      url = "github:Aasim-A/scrollEOF.nvim";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      vars = import ./vars.nix;
      mkSystem = import ./mkSystem.nix {
        inherit
          inputs
          vars
          nixpkgs
          home-manager
          ;
      };
    in
    {
      homeManagerModules = {
        default = ./homeManagerModules;
      };

      nixosConfigurations = {
        # MERCILESS - KoruSe & SNITCHXV
        # Custom Build
        # Ryzen 7 5800X
        # AMD Radeon RX 6650 XT
        # 512GB NVMe SSD
        # 48GB (2x8gb, 2x16gb) DDR4-3200
        merciless = mkSystem {
          hostname = "merciless";
          logicalCores = 16;
          memorySize = 48;
        };

        # Veins - Lil Peep
        # HP Laptop 14s-dq2512sa
        # Intel i5-1135G7
        # Intel Iris Xe
        # 256GB NVMe SSD
        # 16GB (2x8GB) DDR4-2666
        # Realtek RTL8821CE-M Wi-Fi and Bluetooth 4.2
        veins = mkSystem {
          hostname = "veins";
          logicalCores = 8;
          memorySize = 16;
        };
      };
    };
}
