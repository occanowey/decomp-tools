**init flake from template**:
```sh
nix flake init -t github:occanowey/decomp-tools#full
nix flake update --flake path:$(pwd)
direnv allow

```