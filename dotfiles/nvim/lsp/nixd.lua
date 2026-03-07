---@brief
---
--- https://github.com/nix-community/nixd
---
--- Nix language server, based on nix libraries.
---
--- If you are using Nix with Flakes support, run `nix profile install github:nix-community/nixd` to install.
--- Check the repository README for more information.

---@type vim.lsp.Config
return {
    cmd = { 'nixd' },
    filetypes = { 'nix' },
    root_markers = { 'flake.nix', '.git' },

    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { } ",
            },
            formatting = {
                command = { "nixfmt" },
            },
            options = {
                nixos = {
                    expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.elitenix.options',
                },
                home_manager = {
                    expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations."zhyie@elitenix".options.home-manager.users.type.getSubOptions []',
                },
            },
            diagnostic = {
                suppress = { "sema-extra-with" },
            },
        },
    },
}
