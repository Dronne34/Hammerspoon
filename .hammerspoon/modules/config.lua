local M = {}

M.hotkeys = {
  hyper = { "ctrl", "alt", "cmd" },
}

M.window = {
  resizeStep = 80,
  nudgeStep = 40,
}

M.clipboard = {
  maxItems = 80,
  pollInterval = 0.8,
  previewLength = 90,
}

M.apps = {
  T = "Ghostty",
  B = "Google Chrome",
  F = "Finder",
  S = "Slack",
  E = "Visual Studio Code",
  D = "Discord",
  O = "Obsidian",
  U = "Music",
  C = "Calendar",
  N = "Notes",
}

return M
