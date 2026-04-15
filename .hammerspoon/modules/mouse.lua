local M = {}

local function highlightMouse()
  local pos = hs.mouse.absolutePosition()
  local radius = 40
  local circle = hs.drawing.circle(hs.geometry.rect(pos.x - radius, pos.y - radius, radius * 2, radius * 2))

  circle:setStrokeColor({ red = 0.2, blue = 1, green = 0.7, alpha = 0.9 })
  circle:setFill(false)
  circle:setStrokeWidth(5)
  circle:show()

  hs.timer.doAfter(0.7, function()
    circle:delete()
  end)
end

function M.bind(cfg)
  local hyper = cfg.hotkeys.hyper

  hs.hotkey.bind(hyper, "P", highlightMouse)
end

return M
