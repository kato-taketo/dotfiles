hs.window.animationDuration = 0
units = {
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

mash = { 'shift', 'cmd' }
hs.hotkey.bind(mash, 'l', function() hs.window.focusedWindow():moveToUnit(units.right50) end)
hs.hotkey.bind(mash, 'h', function() hs.window.focusedWindow():moveToUnit(units.left50) end)
hs.hotkey.bind(mash, 'k', function() hs.window.focusedWindow():moveToUnit(units.top50) end)
hs.hotkey.bind(mash, 'j', function() hs.window.focusedWindow():moveToUnit(units.bot50) end)
hs.hotkey.bind(mash, 'm', function() hs.window.focusedWindow():moveToUnit(units.maximum) end)
