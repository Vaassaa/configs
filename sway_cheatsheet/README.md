# sway_cheatsheet

A LaTeX/TikZ-generated wallpaper showing your Sway keybindings, styled
with Sway's own default client colour palette. Built to be extended —
adding a shortcut or a whole new group shouldn't require touching the
rendering code.

## Build

Requires `xelatex` (TeX Live, for system-font access via `fontspec`)
and `poppler` (for `pdftoppm`).

```sh
make            # -> build/wallpaper.png, exactly 1280x720
make set        # build + set as the live Sway wallpaper (swaymsg)
make clean
```

## File map

| File                  | Purpose                                             |
|------------------------|-----------------------------------------------------|
| `config.tex`           | canvas size, margins, fonts, header text            |
| `style/palette.tex`    | colours — edit the "semantic roles" block to reskin |
| `style/keycheat.tex`   | the macros (`\key`, `\combo`, `\sr`, `\group`, ...)  |
| `sections/*.tex`       | pure content: one file per shortcut group           |
| `grid.tex`             | where each group box sits on the canvas             |
| `main.tex`             | glue: loads everything above, draws the header      |

## Adding a shortcut

Add a line to the relevant `sections/*.tex` file:

```latex
\sr{Mod,Shift,x}{do the thing}
```

`\sr` renders the first argument as a comma-separated run of keycaps
joined by "+", and the second as the description. For a row whose left
cell isn't a plain Mod-combo (e.g. two keys side by side, or a
shortened label for a long key name like `XF86AudioPlay`), use `\srx`
with raw content instead — see `sections/utilities.tex` for examples.

## Adding a whole group

1. Write `sections/<name>.tex` with `\sr`/`\srx` rows.
2. In `grid.tex`, add one `\node` line: either `at (colX)` to start a
   new column, or `at ($(<previous box>.south west)+(0,-\gutterY)$)`
   to stack it under an existing one. Box height is automatic; only
   `\colWidth` (in `config.tex`) needs to fit the content.

## Extending beyond Sway shortcuts

Nothing here is Sway-specific except the palette and the content
files. A second page/topic (vim binds, tmux, whatever) can reuse
`style/keycheat.tex` as-is — just add new `sections/*.tex` files and
either a new `grid.tex` or a variant of it.
