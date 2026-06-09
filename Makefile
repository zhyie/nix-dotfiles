HOSTNAME ?= $(shell hostname)
USERNAME ?= $(shell whoami)
BACKEXT ?= $(shell date +%Y%m%d)

NIXOS_BUILD := sudo nixos-rebuild build --flake
NIXOS_SWITCH := sudo nixos-rebuild switch --flake
HOME_SWITCH := home-manager switch --flake

.PHONY: help
help:  ## Display available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

##############################
## Builds and Rebuilds
##############################
.PHONY: build switch hswitch elitenix

build: ## Build current host
	$(NIXOS_BUILD) '.#$(HOSTNAME)'

switch: ga ## Rebuild current host
	$(NIXOS_SWITCH) '.#$(HOSTNAME)' --show-trace

hswitch: ga ## Rebuild current user's home
	$(HOME_SWITCH) '.#$(USERNAME)@$(HOSTNAME)' --show-trace

elitenix: ## Build @elitenix
	$(NIXOS_BUILD) '.#elitenix'

##############################
## Nix Flakes
##############################
.PHONY: flake show check check-all meta update upz

flake: ## Display the flake outputs
	nix flake show

check: ga ## Evaluate flake and run tests
	nix flake check --no-build --show-trace

check-all: ga ## Evaluate flake and run tests
	nix flake check --no-build --all-systems --show-trace

meta: ## Display flake dependencies
	nix flake metadata

update: ## Update flake dependencies
	nix flake update

upz: ## Update zhyie's repo
	nix flake update dotfiles secrets

##############################
## Nix Utils
##############################
.PHONY: clean gen hook

gen: ## Display generations
	sudo nixos-rebuild list-generations

clean: ## Clean generations and optimise nix store
	sudo nix-collect-garbage -d;
	nix-collect-garbage -d;
	sudo nix-store --optimise;

hook: ga ## Run git-hooks to project directory
	nix develop -c git-hooks run --all-files

##############################
## Git Utils
##############################
.PHONY: git commit github ga

git: ## Display git status
	git status

ga:	## Track all files
	git add .

gc: ga ## Commit changes to branch
	git commit

github: ## Push to commit to github master
	git push github master
