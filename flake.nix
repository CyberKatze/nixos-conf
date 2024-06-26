{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    hyprpicker.url = "github:hyprwm/hyprpicker";
    hypr-contrib.url = "github:hyprwm/contrib";
 
  };

  outputs = inputs @ { self, nixpkgs, hyprland, home-manager, hypr-contrib, hyprpicker }: 
    let
      system = "x86_64-linux";
      user = "ck";
      hostName = "ck-pc";
    in {

      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem rec{
        inherit system;
        specialArgs = {inherit hyprland user hostName inputs; };
        modules = [ 
          ./system/configuration.nix
          hyprland.nixosModules.default 
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./home/home.nix;
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };
    };
}
