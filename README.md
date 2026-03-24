nix-dotfiles
============

===

*"I just love when things are made for me."*

Mantained by @[zhyie](https://github.com/zhyie)

Specifically for:
- personal preferences
- daily driving and workflow
- family home desktop

---

NixOS Configuration
===================

My personal flake-based configuration for NixOS and Home Manager.
This is setup with a modular directory structure for managing multiple
hosts and user environments. This separates system-wide and user configs,
with reusable modules for each.

---

BASE DIRECTORY STRUCTURE
------------------------

```
.
├── flake.nix
├── flake.lock
├── hosts/
│   ├── default.nix
│   └── ...
├── users/
│   ├── default.nix
│   └── ...
├── modules/
│   ├── default.nix
│   └── ...
└── home/
    ├── default.nix
    └── ...
```

- `flake.nix`   : defines inputs, outputs, and system configurations
- `flake.lock`  : pins dependency versions
- `hosts/`      : machine-specific configuration
- `users/`      : user-specific configuration
- `modules/`    : system wide environment configurations
- `home/`       : user environment configuration

*For more information and full directory structure, see [docs/TREE.md](docs/TREE.md).*

ENVIRONMENT
-----------

#### WINDOW MANAGER

#### TOOLS

#### PROGRAMS

#### SERVICES

#### THEMES

There are 2 themes used in this setup

Main theming: Catppuccin
Catppuccin is used mostly in everything that has to do with themes

*For more information and full environment, see [docs/ENVIRONMENT.md](docs/ENVIRONMENT.md).*


FUTURE PLANS
------------------------------

- [ ] Secret management with sops
- [ ] Desktop ricing
- [ ]

------------------------------
***Built for me -- by me.***
