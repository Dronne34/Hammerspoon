local M = {}

local function withWindow(fn)
  local win = hs.window.focusedWindow()
  if win then
    fn(win)
  else
    hs.alert.show("No focused window")
  end
end

local function moveTo(unit)
  withWindow(function(win)
    win:moveToUnit(unit)
  end)
end

function M.bind(cfg)
  local hyper = cfg.hotkeys.hyper
  local resizeStep = cfg.window.resizeStep
  local nudgeStep = cfg.window.nudgeStep

  -- Halves
  hs.hotkey.bind(hyper, "Left", function()
    moveTo({ x = 0, y = 0, w = 0.5, h = 1 })
  end)
  hs.hotkey.bind(hyper, "Right", function()
    moveTo({ x = 0.5, y = 0, w = 0.5, h = 1 })
  end)
  hs.hotkey.bind(hyper, "Up", function()
    moveTo({ x = 0, y = 0, w = 1, h = 0.5 })
  end)
  hs.hotkey.bind(hyper, "Down", function()
    moveTo({ x = 0, y = 0.5, w = 1, h = 0.5 })
  end)

  -- Quarters
  hs.hotkey.bind(hyper, "1", function()
    moveTo({ x = 0, y = 0, w = 0.5, h = 0.5 })
  end)
  hs.hotkey.bind(hyper, "2", function()
    moveTo({ x = 0.5, y = 0, w = 0.5, h = 0.5 })
  end)
  hs.hotkey.bind(hyper, "3", function()
    moveTo({ x = 0, y = 0.5, w = 0.5, h = 0.5 })
  end)
  hs.hotkey.bind(hyper, "4", function()
    moveTo({ x = 0.5, y = 0.5, w = 0.5, h = 0.5 })
  end)

  -- Thirds
  hs.hotkey.bind(hyper, "5", function()
    moveTo({ x = 0, y = 0, w = 1 / 3, h = 1 })
  end)
  hs.hotkey.bind(hyper, "6", function()
    moveTo({ x = 1 / 3, y = 0, w = 1 / 3, h = 1 })
  end)
  hs.hotkey.bind(hyper, "7", function()
    moveTo({ x = 2 / 3, y = 0, w = 1 / 3, h = 1 })
  end)

  -- Core actions
  hs.hotkey.bind(hyper, "M", function()
    withWindow(function(win)
      win:maximize()
    end)
  end)

  hs.hotkey.bind(hyper, "C", function()
    withWindow(function(win)
      win:centerOnScreen()
    end)
  end)

  hs.hotkey.bind(hyper, "F", function()
    withWindow(function(win)
      win:setFullScreen(not win:isFullScreen())
    end)
  end)

  -- Move window across screens
  hs.hotkey.bind(hyper, "N", function()
    withWindow(function(win)
      win:moveOneScreenWest(false, true)
    end)
  end)

  hs.hotkey.bind(hyper, ";", function()
    withWindow(function(win)
      win:moveOneScreenEast(false, true)
    end)
  end)

  -- Resize
  hs.hotkey.bind(hyper, "=", function()
    withWindow(function(win)
      win:increaseSize(resizeStep, resizeStep)
    end)
  end)

  hs.hotkey.bind(hyper, "-", function()
    withWindow(function(win)
      win:decreaseSize(resizeStep, resizeStep)
    end)
  end)

  -- Nudge
  hs.hotkey.bind(hyper, "H", function()
    withWindow(function(win)
      win:move({ x = -nudgeStep, y = 0 })
    end)
  end)

  hs.hotkey.bind(hyper, "J", function()
    withWindow(function(win)
      win:move({ x = 0, y = nudgeStep })
    end)
  end)

  hs.hotkey.bind(hyper, "K", function()
    withWindow(function(win)
      win:move({ x = 0, y = -nudgeStep })
    end)
  end)

  hs.hotkey.bind(hyper, "L", function()
    withWindow(function(win)
      win:move({ x = nudgeStep, y = 0 })
    end)
  end)

  -- Window hints
  hs.hotkey.bind(hyper, "W", function()
    hs.hints.windowHints()
  end)
end

return M
