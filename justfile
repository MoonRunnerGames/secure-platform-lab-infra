{
  description = "Secure Platform Lab infrastructure tooling";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      pkgsFor = system: import nixpkgs {
        inherit system;
      };
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              terraform
              terraform-docs
              tflint
              checkov
              azure-cli
              kubectl
              kubernetes-helm
              jq
              yq-go
              git
              just
            ];

            shellHook = ''
              echo "Secure Platform Lab infra shell"
              echo "Tools available:"
              echo "- terraform"
              echo "- terraform-docs"
              echo "- tflint"
              echo "- checkov"
              echo "- az"
              echo "- kubectl"
              echo "- helm"
              echo "- just"
            '';
          };
        });
    };
}