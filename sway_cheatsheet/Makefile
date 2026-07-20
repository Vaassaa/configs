ENGINE   ?= xelatex
NAME     := main
BUILD    := build
WALLW    := 1280
WALLH    := 720

.PHONY: all pdf png set clean

all: png

pdf: $(BUILD)/$(NAME).pdf

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/$(NAME).pdf: main.tex config.tex grid.tex style/palette.tex style/keycheat.tex $(wildcard sections/*.tex) | $(BUILD)
	$(ENGINE) -interaction=nonstopmode -halt-on-error -output-directory=$(BUILD) main.tex

# Lives outside build/ on purpose: this is the stable path
# ~/.config/sway/config points at, so `make clean` must never remove it.
png: wallpaper.png

# Uses poppler's pdftoppm if present (crisper text hinting); falls back
# to Ghostscript otherwise. The page is already exactly WALLWxWALLH bp,
# so both just rasterize 1:1 at 72dpi.
wallpaper.png: $(BUILD)/$(NAME).pdf
	@if command -v pdftoppm >/dev/null 2>&1; then \
		pdftoppm -png -singlefile -scale-to-x $(WALLW) -scale-to-y $(WALLH) \
			$(BUILD)/$(NAME).pdf wallpaper; \
	else \
		gs -q -dNOPAUSE -dBATCH -sDEVICE=png16m -r72 -g$(WALLW)x$(WALLH) \
			-o wallpaper.png $(BUILD)/$(NAME).pdf; \
	fi

# Preview immediately by setting it as the live Sway wallpaper. Needs an
# absolute path: swaymsg resolves it relative to the compositor's own
# working directory, not this shell's.
set: png
	swaymsg output '*' bg "$(abspath wallpaper.png)" fill

clean:
	rm -rf $(BUILD)
