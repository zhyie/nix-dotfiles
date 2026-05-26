HOSTNAME ?= $(shell hostname)
USERNAME ?= $(shell whoami)
BACKEXT ?= $(shell date +%Y%m%d)
USERHOST := $(USERNAME)@$(HOSTNAME)

FBUILD = sudo nixos-rebuild build --flake
FSWITCH = sudo nixos-rebuild switch --flake
HSWITCH = home-manager switch --flake

BUILD_CMD = $(FBUILD) .\#$(HOSTNAME)
SWITCH_CMD = $(FSWITCH) .\#$(HOSTNAME)
HSWITCH_CMD = $(HSWITCH) .\#$(USERHOST)

LOGBAR = --show-trace --log-format bar-with-logs

.PHONY: help
help:  ## Display available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

##########################################
# Builds and Rebuilds					 #
##########################################
.PHONY: build switch hswitch elitenix

build: ## Build current host
	$(BUILD_CMD) $(LOGBAR)

switch: ## Rebuild current host
	git add . && $(SWITCH_CMD) $(LOGBAR)

hswitch: ## Rebuild current user's home
	git add . && $(HSWITCH_CMD) $(LOGBAR)

elitenix: ## Rebuild @elitenix
	$(FSWITCH) '.\#elitenix'

##########################################
# Nix Flakes                             #
##########################################
.PHONY: flake show check update meta uplocal

flake: ## Display the flake outputs
	nix flake show

check: ## Evaluate flake and run tests
	git add . && nix flake check --show-trace

update: ## Update flake dependencies
	nix flake update

meta: ## Display flake dependencies
	nix flake metadata

upz: ## Update zhyie's repo
	nix flake update dotfiles secrets

##########################################
# Nix Utils                              #
##########################################
.PHONY: clean gen hook

clean: ## Clean nix store and older generations
	sudo nix-collect-garbage -d;
	nix-collect-garbage -d;
	sudo nix-store --optimise;

gen: ## Display generations
	sudo nixos-rebuild list-generations

hook: ga ## Run pre-commit for the project directory
	nix develop -c pre-commit run -a

##########################################
# Git Utils                              #
##########################################
.PHONY: git commit github ga

git: ## Display git status
	git status

commit: ## Commit changes to branch
	git add . && git commit

github: ## Push to commit to github master
	git push github master

ga:
	git add .
