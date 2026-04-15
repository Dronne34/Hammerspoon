-- Hammerspoon - advanced starter configuration
hs.window.animationDuration = 0

local log = hs.logger.new("init", "info")

local cfg = require("modules.config")
local hyper = cfg.hotkeys.hyper

local function safeRequire(module)
  local ok, mod = pcall(require, module)
  if not ok then
    hs.alert.show("Module load failed: " .. module)
    log.e("Failed to load " .. module .. ": " .. tostring(mod))
    return nil
  end
  return mod
end

local modules = {
  "modules.window",
  "modules.launcher",
  "modules.system",
  "modules.clipboard",
  "modules.mouse",
}

for _, moduleName in ipairs(modules) do
  local mod = safeRequire(moduleName)
  if mod and mod.bind then
    mod.bind(cfg)
  end
end

hs.hotkey.bind(hyper, "/", function()
  hs.hotkey.showHotkeys()
end)

hs.hotkey.bind(hyper, "`", function()
  hs.openConsole()
end)

local reloading = false
local function reloadConfig(files)
  for _, file in ipairs(files) do
    if file:sub(-4) == ".lua" then
      if not reloading then
        reloading = true
        hs.timer.doAfter(0.2, function()
          hs.reload()
        end)
      end
      return
    end
  end
end

local watcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
watcher:start()

hs.alert.show("Hammerspoon loaded ✅")
log.i("Config loaded")
