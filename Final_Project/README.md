# delve

A Midnight-Commander-style dual-pane terminal file browser, written in
Clojure using [clojure-lanterna](https://github.com/sjl/clojure-lanterna) for terminal handling.

## Run it

Requires the Clojure CLI.

```bash
clojure -M:run
```

First run will download clojure-lanterna from Clojars.

## Keybindings

| Key                            | Action                          |
| ------------------------------ | ------------------------------- |
| `Tab`                        | Switch active pane (left/right) |
| `j` / `↓`                 | Move selection down             |
| `k` / `↑`                 | Move selection up               |
| `l` / `→` / `Enter`     | Descend into selected directory |
| `h` / `←` / `Backspace` | Ascend to parent directory      |
| `q`                          | Quit                            |

Directories are shown in cyan; The active pane's path header is shown in green

## Project layout

```
deps.edn
src/delve/
  fs.clj     — directory listing / parent-path helpers
  ui.clj     — pure rendering: state -> draw ops (no lanterna calls here)
  core.clj   — lanterna Screen setup, key-handling loop, main entry point
```
