# nono config

Profiles live in `profiles/`. Sessions here grant it write, so edit directly —
no `profile-drafts/` + `nono profile promote` detour.

Bases (`--profile`): `claude`, `opencode`, `pi`.
Add-ons (`--extends`): `commit`, `dotfiles`, `koda`, `nix`.

1. Every profile extends `default` — it is never implicit, and a missing base
   passes `validate` but fails at runtime (no `/nix/store`, nothing can exec).
   Check: `nono why --profile <name> --path ~/.gitconfig --op read`. Always pass
   `--profile`/`--extends`; without them `why` reports on `default`, not on the
   running session.
2. Egress is uniform: `default` sets `network_profile: "developer"`; per-profile
   `allow_domain` only adds.
3. `default` includes `system_write_linux`, so `/tmp` is write-only (not
   readable) and `/dev/{null,zero,full,tty,pts}` plus `/proc/self/fd` are
   writable. Without it `git` cannot run at all — it opens `/dev/null` `O_RDWR`.
   `$TMPDIR` (`/tmp/nono-$UID`) stays read+write via `filesystem.allow`.
4. Edit `profiles/` in place — `workdir: readwrite` covers this tree. Keep
   `meta.description` to one line.
5. Tracked in the bare repo at `~/.dotfiles` (worktree `$HOME`); committing
   needs `dotfiles`, which grants it write.
