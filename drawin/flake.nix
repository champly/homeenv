{
  description = "champly's mbp development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    # x86_64-darwin
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacypackages.${system};
    devenv = pkgs.mkshell {
      packages = [
        pkgs.git
        pkgs.zsh
        pkgs.oh-my-zsh
        pkgs.fzf
        pkgs.neovim
        pkgs.tmux
        pkgs.yazi
        pkgs.lazygit
        pkgs.ripgrep
        pkgs.fd
        pkgs.k9s
        pkgs.go
        pkgs.gopls
      ];

      shellhook = ''
        exec zsh -i
      '';
    };
    in {
      devshells.${system}.default = devenv;

      packages.${system}.default = pkgs.symlinkjoin {
        name = "champly-mbp-env";
        paths = devenv.buildinputs;
      };
    };
}
