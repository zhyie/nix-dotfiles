HOSTNAME ?= $(shell hostname)
USERNAME ?= $(shell whoami)
BACKEXT ?= $(shell date +%Y%m%d)

FBUILD = sudo nixos-rebuild build --flake
FSWITCH = sudo nixos-rebuild switch --flake

BUILD_CMD = $(FBUILD) .\#$(HOSTNAME)
SWITCH_CMD = $(FSWITCH) .\#$(HOSTNAME)

LOGBAR = --log-format bar-with-logs

.PHONY: help
help:  ## Display available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

##########################################
# Build and Rebuild for General          #
##########################################
.PHONY: build switch

build: ## Build current host
	$(BUILD_CMD) $(LOGBAR)

switch: ## Rebuild current host
	git add . && $(SWITCH_CMD) $(LOGBAR)

##########################################
# Build and Rebuild for each host        #
##########################################
.PHONY: elitenix

elitenix: ## Host: @elitenix rebuild
	$(FSWITCH) '.\#elitenix'

##########################################
# Nix Flakes                             #
##########################################
.PHONY: flake show check update meta

flake: ## Display the flake outputs
	nix flake show

check: ## Evaluate flake and run tests
	git add . && nix flake check

update: ## Update flake dependencies
	nix flake update

meta: ## Display flake dependencies
	nix flake metadata

##########################################
# Nix Utils                              #
##########################################
.PHONY: clean

clean: ## Clean nix store and older generations
	sudo nix-collect-garbage -d;
	nix-collect-garbage -d;
	sudo nix-store --optimise;

gen: ## Display generations
	sudo nixos-rebuild list-generations

##########################################
# Git Utils                              #
##########################################
.PHONY: git commit github

git: ## Display git status
	git status

commit: ## Commit changes to branch
	git commit

github: ## Push to commit to github master
	git push github master
