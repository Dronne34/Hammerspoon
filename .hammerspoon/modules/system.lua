local M = {}

local caffeine = hs.menubar.new()

local function setCaffeineDisplay(state)
  if caffeine then
    caffeine:setTitle(state and "☕︎" or "💤")
  end
end

local function bindSafe(mods, key, fn)
  local ok, err = pcall(hs.hotkey.bind, mods, key, fn)
  if not ok then
    hs.printf("[system.lua] hotkey bind failed for key '%s': %s", key, tostring(err))
  end
end

local function toggleCaffeine()
  local state = hs.caffeinate.get("displayIdle")
  hs.caffeinate.set("displayIdle", not state, true)
  setCaffeineDisplay(not state)
  hs.alert.show(not state and "Caffeine ON" or "Caffeine OFF")
end

local function toggleDarkMode()
  hs.osascript.applescript('tell application "System Events" to tell appearance preferences to set dark mode to not dark mode')
end

local function toggleMuteInput()
  local dev = hs.audiodevice.defaultInputDevice()
  if not dev then
    return
  end
  local isMuted = dev:muted()
  dev:setMuted(not isMuted)
  hs.alert.show(not isMuted and "Mic OFF" or "Mic ON")
end

function M.bind(cfg)
  local hyper = cfg.hotkeys.hyper

  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
  if caffeine then
    caffeine:setClickCallback(toggleCaffeine)
  end

  bindSafe(hyper, "0", toggleCaffeine)
  bindSafe(hyper, "9", toggleDarkMode)
  bindSafe(hyper, "8", toggleMuteInput)
  bindSafe(hyper, "return", function()
    hs.caffeinate.lockScreen()
  end)

  -- On macOS/Hammerspoon, physical Backspace key is named "delete".
  bindSafe(hyper, "delete", function()
    hs.caffeinate.startScreensaver()
  end)
end

return M
