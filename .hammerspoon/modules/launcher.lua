local M = {}

local function appChooser()
  local runningApps = hs.application.runningApplications()
  local choices = {}

  for _, app in ipairs(runningApps) do
    local name = app:name()
    if name and name ~= "" then
      table.insert(choices, {
        text = name,
        subText = app:bundleID() or "",
      })
    end
  end

  table.sort(choices, function(a, b)
    return a.text < b.text
  end)

  local chooser = hs.chooser.new(function(choice)
    if choice and choice.text then
      hs.application.launchOrFocus(choice.text)
    end
  end)

  chooser:choices(choices)
  chooser:show()
end

function M.bind(cfg)
  local hyperShift = { "ctrl", "alt", "cmd", "shift" }

  for key, appName in pairs(cfg.apps) do
    hs.hotkey.bind(hyperShift, key, function()
      hs.application.launchOrFocus(appName)
    end)
  end

  hs.hotkey.bind(hyperShift, "R", function()
    hs.reload()
  end)

  hs.hotkey.bind(hyperShift, "Q", function()
    local app = hs.application.frontmostApplication()
    if app then
      app:kill()
    end
  end)

  hs.hotkey.bind(hyperShift, "P", appChooser)
end

return M
