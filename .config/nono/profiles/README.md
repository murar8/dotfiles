# Profiles

Bases (`--profile`): `claude`, `opencode`, `pi`.
Add-ons (`--extends`): `commit`, `dotfiles`, `koda`, `nix`.

1. Every profile extends `default` — it is never implicit, and a missing base
   passes `validate` but fails at runtime (no `/nix/store`, nothing can exec).
   Check: `nono why --profile <name> --path ~/.gitconfig --op read`. Always pass
   `--profile`/`--extends`; without them `why` reports on `default`, not on the
   running session.
2. Egress is uniform: `default` sets `network_profile: "developer"`; per-profile
   `allow_domain` only adds.
3. Edit in place — `workdir: readwrite` covers this dir.
4. Tracked in the bare repo at `~/.dotfiles` (worktree `$HOME`); committing
   needs `dotfiles`, which grants it write.
