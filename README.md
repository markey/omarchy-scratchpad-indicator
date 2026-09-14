# Scratchpad Indicator for Omarchy

A minimal Omarchy Shell bar widget that makes the hidden scratchpad visible in
the bar:

- It is hidden when `special:scratchpad` is empty.
- It appears as an active sticky-note icon when one or more windows are stored.
- Its tooltip shows the number of scratchpad windows.
- Left-clicking the icon toggles the scratchpad, matching `Super + S`.

The widget uses Quickshell's native Hyprland model and dispatcher. It does not
run a polling process and has no dependencies beyond Omarchy Shell.

## Install from a published repository

```bash
omarchy plugin add https://github.com/markey/omarchy-scratchpad-indicator.git --enable
```

The widget is placed in the left section by default. Move it if desired:

```bash
omarchy bar move mark.scratchpad --section right
```

## Install a local development copy

Copy this directory to `~/.config/omarchy/plugins/mark.scratchpad`, then run:

```bash
omarchy-shell shell rescanPlugins
omarchy plugin enable mark.scratchpad
```

Omarchy Shell hot-reloads changes made inside the installed plugin directory.

## Remove

```bash
omarchy plugin remove mark.scratchpad
```

## Compatibility

Built and validated against Omarchy 4.0.3 / Omarchy Shell's plugin manifest
schema version 1. It supports both Omarchy's Lua dispatcher and the legacy
Hyprland dispatcher fallback.
