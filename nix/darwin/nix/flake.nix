{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, sf-mono-liga-src }:
    let
      configuration = { pkgs, config, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget

        nixpkgs.config.allowUnfree = true;

        nixpkgs.overlays = [
          (final: prev: {
            sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
              pname = "sf-mono-liga-bin";
              version = "dev";
              src = inputs.sf-mono-liga-src;
              dontConfigure = true;
              installPhase = ''
                echo "installing fonts $out" >&2
                mkdir -p $out/share/fonts/opentype
                cp -R $src/*.otf $out/share/fonts/opentype/
              '';
            };
          })
        ];

        environment.systemPackages =
          [
            pkgs.neovim
            okgs.obsidian
            pkgs.wezterm
            pkgs.vscode
            pkgs.raycast
            pkgs.nixd
            pkgs.nixpkgs-fmt
            pkgs.starship
            pkgs.fzf
            pkgs.eza
            pkgs.zoxide
            pkgs.thefuck
            pkgs.zsh-syntax-highlighting
            pkgs.zsh-autosuggestions
          ];

        homebrew = {
          enable = true;
          brews = [
            "mas"
            "git"
            "gh"
          ];
          casks = [
            "zen-browser"
            "karabiner-elements"
            "bartender"
            "stats"
            "discord"
            "bitwarden"
            "shottr"
            "todoist"
          ];
          masApps = { 
            "Dropover" = 1355679052;
          };
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

        fonts.packages = with pkgs; [
          sf-mono-liga-bin
          (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];

        system.defaults = {
          dock.autohide = true;
          dock.autohide-delay = 0.05;
          dock.autohide-time-modifier = 0.3;
          dock.mru-spaces = false;
          dock.show-recents = false;
          dock.tilesize = 48;
          dock.persistent-apps = [
            "/System/Library/CoreServices/Finder.app"
            "/System/Applications/System Settings.app"
            "/System/Applications/Calendar.app"
            "/System/Applications/Mail.app"
            "/System/Applications/Messages.app"
            "/Applications/Discord.app"
            "${pkgs.obsidian}/Applications/Obsidian.app"
            "/Applications/Safari.app"
            "/Applications/Zen Browser.app"
            "${pkgs.wezterm}/Applications/Wezterm.app"
            "${pkgs.vscode}/Applications/Visual Studio Code.app"
          ];
          finder.FXPreferredViewStyle = "clmv";
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
          NSGlobalDomain.AppleShowAllExtensions = true;
          NSGlobalDomain._HIHideMenuBar = false;
          NSGlobalDomain.AppleShowAllFiles = true;
          loginwindow.GuestEnabled = false;
          trackpad.Clicking = true;
        };

        # This is for adding alias instead of symlink for applications for Spotlight
        # system.activationScripts.applications.text =
        #   let

        #     env = pkgs.buildEnv {
        #       name = "system-applications";
        #       paths = config.environment.systemPackages;
        #       pathsToLink = "/Applications";
        #     };
        #   in
        #   pkgs.lib.mkForce ''
        #     # Set up applications.
        #     echo "setting up /Applications..." >&2
        #     rm -rf /Applications/Nix\ Apps
        #     mkdir -p /Applications/Nix\ Apps
        #     find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        #     while read src; do
        #       app_name=$(basename "$src")
        #       echo "copying $src" >&2
        #       ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        #     done
        #   '';

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Sams-Mac-mini
      darwinConfigurations."Sams-Mac-mini" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple Silicon Only
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "samhamer";
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Sams-Mac-mini".pkgs;
    };


}
