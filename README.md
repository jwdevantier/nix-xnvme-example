# Nix xNVMe hello world

Example showing how one _might_ build a environment for testing out xNVMe & libvfn

**WARNING** I was just trying things out - this is very likely not the BEST
way of doing things, but it does demonstrate feasibility.

## How to run

1. Install [Nix](https://nixos.org/download.html) -- use the recommended multi-user installation method.


Run `nix-shell` to be dumped into an environment with liburing, libaio, libvfn and xnvme installed.
You can test things out by compiling a simple hello world xNVMe program:

```
gcc hello_xnvme.c $(pkg-config --libs xnvme) -lxnvme-shared -o hello_xnvme
```

### Details...
From within this directory, execute `nix-shell` - this will read `shell.nix`, which
defines a new shell environment with a series of packages to make available to the shell.
Of these, libvfn and xnvme are unavailable from the official Nix package repository
(see [Nix Pacakge Search](https://search.nixos.org/packages) to search around for available packages).
To make libvfn and xnvme available, `default.nix` (used by `shell.nix`) refers to two derivations
(~package build scripts in nix-parlance), located in `libvfn` and `xnvme` respectively.

These derivations are largely written by searching for other packages already in Nix which uses
meson to build and writing a similar file.

**NOTE** `nix-shell` spawns an __impure__ environment -- this means your system-wide binaries
and libraries are still reachable, albeit with what nix provides taking precedence.
This means you can fire up your neovim editors in all their ungodly glory and hack away at
the code.

You _can_ run `nix-shell --pure` to spawn a pure environment where all that is available
is what is defined by `shell.nix`.


## Changes made:

### libvfn
Does not treat `scripts/trace.pl` as a program - this would make `/usr/bin/env perl` locate
the version of perl to use, ignoring the `find_program('perl')` instruction in the `meson.build`
file.

Instead, prepend the `perl` program to the invocations of the trace script.

### xNVMe

Disabled spdk, there is a spdk package in Nix, but frankly, I wasn't interested in making this work.

Patched the build files to actually look for the system's copy of libvfn and to not attempt to
build libvfn itself, nor attempt to create the big xNVMe bundle file.

