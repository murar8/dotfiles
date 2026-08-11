# nono config

`--extends` requires `--profile` and repeats, so one profile is always
privileged. Put the agent there — two agents merge silently otherwise.
Everything else is additive and stackable. Credential-only profiles are wired
into a base chain via `extends`, never passed on the CLI. `nono profile list`
is the inventory.

1. Every profile extends `default` — it is never implicit, and a missing base
   passes `validate` but fails at runtime (no `/nix/store`, nothing can exec).
   It shadows the built-in `default` and replaces its group set, so a built-in
   group you want (`homebrew_linux`, the macOS ones) must be added here.
   Check: `nono why --profile <name> --path ~/.gitconfig --op read`. Always pass
   `--profile`/`--extends`; without `--profile`, `why` reports on no profile at
   all (denies even `~/.gitconfig`), not on `default`.
2. Egress is uniform: `default` sets `network_profile: "developer"`; per-profile
   `allow_domain` only adds.
3. `default` includes `system_write_linux`, so `/tmp` is write-only (not
   readable) and `/dev/{null,zero,full,tty,pts}` plus `/proc/self/fd` are
   writable. Without it `git` cannot run at all — it opens `/dev/null` `O_RDWR`.
   `$TMPDIR` (`/tmp/nono-$UID`) stays read+write via `filesystem.allow`.
4. Edit `profiles/` in place — `workdir: readwrite` covers this tree, so no
   `profile-drafts/` + `nono profile promote` detour. Keep `meta.description` to
   one line, covering only what the profile itself defines, never inherited
   behavior.
5. Tracked in the bare repo at `~/.dotfiles` (worktree `$HOME`); committing
   needs `dotfiles`, which grants it write.
