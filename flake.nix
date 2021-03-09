{
  description = "my project description";

  inputs = {
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-20.09";
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.unstable.legacyPackages.${system};
      env = pkgs.poetry2nix.mkPoetryEnv { projectDir = ./.; };
    in {
      devShell."${system}" = pkgs.mkShell {
        buildInputs = [env];
        shellHook = ''
          mkdir .vim
          echo '{"python.pythonPath": "${env}/bin/python",}' > .vim/coc-settings.json
        '';
      };
    };
}
