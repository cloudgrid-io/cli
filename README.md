# CloudGrid CLI

[![npm](https://img.shields.io/npm/v/@cloudgrid-io/cli?color=cb3837)](https://www.npmjs.com/package/@cloudgrid-io/cli)
[![license](https://img.shields.io/badge/license-MIT-green)](./LICENSE)

Build, ship, and run apps and agents on CloudGrid from your terminal. A directory or a
URL becomes a live, addressable thing in about 30 seconds -- deploy, tail logs, share,
read feedback, all without leaving your shell.

## Contents

- [Install](#install)
- [Quickstart](#quickstart)
- [Examples](#examples)
- [Commands](#commands)
- [Flags](#flags)
- [Updating](#updating)
- [Uninstall](#uninstall)
- [Troubleshooting](#troubleshooting)
- [Support](#support)
- [License](#license)

## Install

**macOS / Linux -- curl**
```
curl -fsSL https://raw.githubusercontent.com/cloudgrid-io/cli/main/install.sh | sh
```

**macOS / Linux -- Homebrew**
```
brew install cloudgrid-io/tap/grid
```

**Cross-platform (incl. Windows) -- npm**
```
npm install -g @cloudgrid-io/cli
```

Verify: `grid --version` and `grid doctor`.

## Quickstart

```
grid login          # Google OAuth in the browser
grid whoami         # confirm user + active grid
grid plug           # build + deploy the current directory, prints the live URL
grid open           # open it in the browser
```

No account needed to try a one-off share: `grid plug ./index.html` drops a public link.

## Examples

```
# Scaffold and deploy a Node app
grid new my-api --type node
cd my-api && grid plug

# Deploy the current directory and tail its logs
grid plug
grid logs --since 10m

# Make a deploy public, then read feedback
grid visibility set my-app link
grid feedback

# Switch grid, list what is on it
grid use atomic
grid get grids
```

## Commands

| Command | Purpose |
|---|---|
| `login` / `logout` / `whoami` | Sign in (Google OAuth), sign out, show user + active grid |
| `use [slug]` | Set or show the active grid |
| `new <name>` | Scaffold a project folder + cloudgrid.yaml (entity minted on first `plug`) |
| `plug [target]` | Build + deploy (or redeploy); prints the live URL |
| `dev` | Run the linked entity locally with grid-injected resources |
| `status [name]` | Grid dashboard, entity detail, or a deploy snapshot |
| `logs [name]` | Stream entity logs |
| `open [name]` | Open the entity URL in the browser |
| `info [name]` | Entity metadata: URL, grid, visibility, services |
| `visibility set <slug> <mode>` | private \| grid \| link |
| `rollback` / `versions` | Roll back to a prior deploy; list/tag minted versions |
| `env` / `secrets` | Manage runtime env vars and secrets (secret values are never printed) |
| `get` | List grids, entities, or spaces |
| `rename` / `delete` / `unplug` | Rename, archive, take off the grid |
| `pull` / `pickup` | Download source and link the folder; or fork your own copy |
| `feedback [message]` | Send feedback to the CloudGrid team |
| `doctor` | Diagnostic checks (Node, Docker, API reachability, auth) |
| `completion <shell>` | Shell completion script |

Run `grid <command> --help` for the full flag set of any command.

## Flags

Global:
- `-V, --version` -- print the CLI version
- `-v, --verbose` -- detailed output
- `-h, --help` -- help for any command

Common per-command:
- `--grid <slug>` -- pick/override the grid
- `--json` -- machine-readable output (where supported)
- `--no-clipboard` / `--no-notify` -- suppress clipboard copy / OS notification on `plug`
- `--since <dur>` / `--tail <n>` -- `logs` window

## Updating

```
npm update -g @cloudgrid-io/cli      # npm
brew upgrade grid                    # homebrew
```
`grid doctor` warns when a newer version is available.

## Uninstall

```
npm uninstall -g @cloudgrid-io/cli   # npm
brew uninstall grid                  # homebrew
rm -rf ~/.cloudgrid                  # remove stored credentials + config
```

## Troubleshooting

- **`grid: command not found`** -- ensure the npm global bin (or Homebrew bin) is on `$PATH`; re-run the installer.
- **Auth errors / 401** -- `grid login` again; check `grid whoami` shows the expected grid, switch with `grid use <grid>`.
- **Deploy fails** -- run `grid doctor`; check `grid logs` and `grid status <name>` for the trace.

## Support

- Skills + MCP: [cloudgrid-io/skills](https://github.com/cloudgrid-io/skills)
- Issues: [cloudgrid-io/cli/issues](https://github.com/cloudgrid-io/cli/issues)

## License

MIT. See [LICENSE](./LICENSE).
