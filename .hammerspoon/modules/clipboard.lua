local M = {}

local history = {}
local lastValue = nil

local function normalizeText(text)
  if not text then
    return nil
  end
  text = text:gsub("\r\n", "\n")
  if text:match("^%s*$") then
    return nil
  end
  return text
end

local function pushClipboard(text, maxItems)
  local normalized = normalizeText(text)
  if not normalized then
    return
  end

  for i, item in ipairs(history) do
    if item == normalized then
      table.remove(history, i)
      break
    end
  end

  table.insert(history, 1, normalized)

  while #history > maxItems do
    table.remove(history)
  end
end

local function buildChoices(previewLength)
  local choices = {}
  for i, item in ipairs(history) do
    local preview = item:gsub("\n", " ⏎ ")
    if #preview > previewLength then
      preview = preview:sub(1, previewLength) .. "…"
    end

    table.insert(choices, {
      text = string.format("%d. %s", i, preview),
      subText = "Enter = copy in clipboard, Cmd+V pentru paste",
      idx = i,
    })
  end
  return choices
end

local function showChooser(previewLength)
  local chooser = hs.chooser.new(function(choice)
    if not choice then
      return
    end
    local selected = history[choice.idx]
    if selected then
      hs.pasteboard.setContents(selected)
      hs.alert.show("Copied from history")
    end
  end)

  chooser:choices(buildChoices(previewLength))
  chooser:show()
end

function M.bind(cfg)
  local hyper = cfg.hotkeys.hyper
  local maxItems = cfg.clipboard.maxItems
  local pollInterval = cfg.clipboard.pollInterval
  local previewLength = cfg.clipboard.previewLength

  hs.timer.doEvery(pollInterval, function()
    local current = hs.pasteboard.getContents()
    if current ~= lastValue then
      lastValue = current
      pushClipboard(current, maxItems)
    end
  end)

  hs.hotkey.bind(hyper, "V", function()
    showChooser(previewLength)
  end)

  hs.hotkey.bind(hyper, "Y", function()
    local newest = history[1]
    if newest then
      hs.pasteboard.setContents(newest)
      hs.alert.show("Latest clipboard restored")
    end
  end)
end

return M
