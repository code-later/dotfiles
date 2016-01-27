-- === sizeup ===
--
-- SizeUp emulation for hammerspoon
--
-- To use, you can tweak the key bindings and the margins

local sizeup = { }

local keys = { }
keys.hyper = {"shift", "ctrl", "alt", "cmd"}

hs.grid.ui.textSize = 100
hs.grid.setMargins("0 0")


-------------
-- Layouts --
-------------

local dellUltraWide = "Dell U3415W"
local windowLayout = {
   {"iTerm",  nil,          dellUltraWide, hs.layout.left30,    nil, nil},
   {"Emacs",  nil,          dellUltraWide, hs.layout.right70,   nil, nil}
}

--------------
-- Bindings --
--------------

--- Split Screen Actions ---
-- Send Window Left
hs.hotkey.bind(keys.hyper, "H", function()
  sizeup.send_window_left()
end)
-- Send Window Right
hs.hotkey.bind(keys.hyper, "L", function()
  sizeup.send_window_right()
end)
-- Send Window Up
hs.hotkey.bind(keys.hyper, "K", function()
  sizeup.send_window_up()
end)
-- Send Window Down
hs.hotkey.bind(keys.hyper, "J", function()
  sizeup.send_window_down()
end)

---- Thrid Screen Actions
-- Send Window Left Third
hs.hotkey.bind(keys.hyper, "U", function()
  sizeup.send_window_left_third()
end)
-- Send Window Middle
hs.hotkey.bind(keys.hyper, "I", function()
  sizeup.send_window_middle()
end)
-- Send Window Middle+Right Third
hs.hotkey.bind(keys.hyper, "P", function()
  sizeup.send_window_middle_right_third()
end)
-- Send Window Right Third
hs.hotkey.bind(keys.hyper, "O", function()
  sizeup.send_window_right_third()
end)

--- Quarter Screen Actions ---
-- Send Window Upper Left
hs.hotkey.bind({"alt"}, "F1", function()
  sizeup.send_window_upper_left()
end)
-- Send Window Upper Right
hs.hotkey.bind({"alt"}, "F2", function()
  sizeup.send_window_upper_right()
end)
-- Send Window Lower Left
hs.hotkey.bind({"alt"}, "F3", function()
  sizeup.send_window_lower_left()
end)
-- Send Window Lower Right
hs.hotkey.bind({"alt"}, "F4", function()
  sizeup.send_window_lower_right()
end)

--- Multiple Monitor Actions ---
-- Send Window Prev Monitor
hs.hotkey.bind({ "ctrl", "alt" }, "Left", function()
  sizeup.send_window_prev_monitor()
end)
-- Send Window Next Monitor
hs.hotkey.bind({ "ctrl", "alt" }, "Right", function()
  sizeup.send_window_next_monitor()
end)

--- Spaces Actions ---

-- Apple no longer provides any reliable API access to spaces.
-- As such, this feature no longer works in SizeUp on Yosemite and
-- Hammerspoon currently has no solution that isn't a complete hack.
-- If you have any ideas, please visit the ticket

--- Snapback Action ---
hs.hotkey.bind(keys.hyper, "\\", function()
  sizeup.snapback()
end)
--- Other Actions ---
-- Make Window Full Screen
hs.hotkey.bind(keys.hyper, "m", function()
  sizeup.maximize()
end)
-- Send Window Center
hs.hotkey.bind(keys.hyper, "n", function()
  sizeup.move_to_center_relative({w=0.70, h=0.95})
end)

--- Apply Layouts
hs.hotkey.bind(keys.hyper, "q", function()
  hs.layout.apply(windowLayout)
end)

--- Reload config
hs.hotkey.bind(keys.hyper, "R", function()
  hs.reload()
end)

--- Show Grid
hs.hotkey.bind(keys.hyper, "G", function()
  if hs.screen(dellUltraWide) ~= nil then
    hs.grid.setGrid('3x2').show()
  else
    hs.grid.setGrid('2x2').show()
  end
end)

-------------------
-- Configuration --
-------------------

-- Margins --
sizeup.screen_edge_margins = {
  top =    0, -- px
  left =   0,
  right =  0,
  bottom = 0
}
sizeup.partition_margins = {
  x = 0, -- px
  y = 0
}

-- Partitions --
sizeup.split_screen_partitions = {
  x = 0.5, -- %
  y = 0.5
}
sizeup.quarter_screen_partitions = {
  x = 0.5, -- %
  y = 0.5
}
sizeup.third_screen_partitions = {
  x = 0.333333333, -- %
  y = 0.5
}

----------------
-- Public API --
----------------
function sizeup.send_window_left_third()
  local s = sizeup.screen()
  local tsp = sizeup.third_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Left Third", {
    x = s.x,
    y = s.y,
    w = (s.w * tsp.x) - sizeup.gutter().x,
    h = s.h
  })
end

function sizeup.send_window_middle()
  local s = sizeup.screen()
  local tsp = sizeup.third_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Middle", {
    x = s.x + (s.w * tsp.x) + g.x,
    y = s.y,
    w = (s.w * tsp.x) - sizeup.gutter().x,
    h = s.h
  })
end

function sizeup.send_window_middle_right_third()
  local s = sizeup.screen()
  local tsp = sizeup.third_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Middle + Right Third", {
    x = s.x + (s.w * tsp.x) + g.x,
    y = s.y,
    w = (s.w * tsp.x * 2) - sizeup.gutter().x,
    h = s.h
  })
end

function sizeup.send_window_right_third()
  local s = sizeup.screen()
  local tsp = sizeup.third_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Right Third", {
    x = s.x + (s.w * tsp.x * 2) + g.x,
    y = s.y,
    w = (s.w * tsp.x) - sizeup.gutter().x,
    h = s.h
  })
end

function sizeup.send_window_left()
  local s = sizeup.screen()
  local ssp = sizeup.split_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Left", {
    x = s.x,
    y = s.y,
    w = (s.w * ssp.x) - sizeup.gutter().x,
    h = s.h
  })
end

function sizeup.send_window_right()
  local s = sizeup.screen()
  local ssp = sizeup.split_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Right", {
    x = s.x + (s.w * ssp.x) + g.x,
    y = s.y,
    w = (s.w * (1 - ssp.x)) - g.x,
    h = s.h
  })
end

function sizeup.send_window_up()
  local s = sizeup.screen()
  local ssp = sizeup.split_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Up", {
    x = s.x,
    y = s.y,
    w = s.w,
    h = (s.h * ssp.y) - g.y
  })
end

function sizeup.send_window_down()
  local s = sizeup.screen()
  local ssp = sizeup.split_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Down", {
    x = s.x,
    y = s.y + (s.h * ssp.y) + g.y,
    w = s.w,
    h = (s.h * (1 - ssp.y)) - g.y
  })
end

function sizeup.send_window_upper_left()
  local s = sizeup.screen()
  local qsp = sizeup.quarter_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Upper Left", {
    x = s.x,
    y = s.y,
    w = (s.w * qsp.x) - g.x,
    h = (s.h * qsp.y) - g.y
  })
end

function sizeup.send_window_upper_right()
  local s = sizeup.screen()
  local qsp = sizeup.quarter_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Upper Right", {
    x = s.x + (s.w * qsp.x) + g.x,
    y = s.y,
    w = (s.w * (1 - qsp.x)) - g.x,
    h = (s.h * (qsp.y)) - g.y
  })
end

function sizeup.send_window_lower_left()
  local s = sizeup.screen()
  local qsp = sizeup.quarter_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Lower Left", {
    x = s.x,
    y = s.y + (s.h * qsp.y) + g.y,
    w = (s.w * qsp.x) - g.x,
    h = (s.h * (1 - qsp.y)) - g.y
  })
end

function sizeup.send_window_lower_right()
  local s = sizeup.screen()
  local qsp = sizeup.quarter_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Lower Right", {
    x = s.x + (s.w * qsp.x) + g.x,
    y = s.y + (s.h * qsp.y) + g.y,
    w = (s.w * (1 - qsp.x)) - g.x,
    h = (s.h * (1 - qsp.y)) - g.y
  })
end

function sizeup.send_window_prev_monitor()
  hs.alert.show("Prev Monitor")
  local win = hs.window.focusedWindow()
  local nextScreen = win:screen():previous()
  win:moveToScreen(nextScreen)
end

function sizeup.send_window_next_monitor()
  hs.alert.show("Next Monitor")
  local win = hs.window.focusedWindow()
  local nextScreen = win:screen():next()
  win:moveToScreen(nextScreen)
end

-- snapback return the window to its last position. calling snapback twice returns the window to its original position.
-- snapback holds state for each window, and will remember previous state even when focus is changed to another window.
function sizeup.snapback()
  local win = sizeup.win()
  local id = win:id()
  local state = win:frame()
  local prev_state = sizeup.snapback_window_state[id]
  if prev_state then
    win:setFrame(prev_state)
  end
  sizeup.snapback_window_state[id] = state
end

function sizeup.maximize()
  sizeup.set_frame("Full Screen", sizeup.screen())
end

--- move_to_center_relative(size)
--- Method
--- Centers and resizes the window to the the fit on the given portion of the screen.
--- The argument is a size with each key being between 0.0 and 1.0.
--- Example: win:move_to_center_relative(w=0.5, h=0.5) -- window is now centered and is half the width and half the height of screen
function sizeup.move_to_center_relative(unit)
  local s = sizeup.screen()
  sizeup.set_frame("Center", {
    x = s.x + (s.w * ((1 - unit.w) / 2)),
    y = s.y + (s.h * ((1 - unit.h) / 2)),
    w = s.w * unit.w,
    h = s.h * unit.h
  })
end

--- move_to_center_absolute(size)
--- Method
--- Centers and resizes the window to the the fit on the given portion of the screen given in pixels.
--- Example: win:move_to_center_relative(w=800, h=600) -- window is now centered and is 800px wide and 600px high
function sizeup.move_to_center_absolute(unit)
  local s = sizeup.screen()
  sizeup.set_frame("Center", {
    x = (s.w - unit.w) / 2,
    y = (s.h - unit.h) / 2,
    w = unit.w,
    h = unit.h
  })
end


------------------
-- Internal API --
------------------

-- SizeUp uses no animations
hs.window.animation_duration = 0
-- Initialize Snapback state
sizeup.snapback_window_state = { }
-- return currently focused window
function sizeup.win()
  return hs.window.focusedWindow()
end
-- display title, save state and move win to unit
function sizeup.set_frame(title, unit)
  -- hs.alert.show(title)
  local win = sizeup.win()
  sizeup.snapback_window_state[win:id()] = win:frame()
  return win:setFrame(unit, 0)
end
-- screen is the available rect inside the screen edge margins
function sizeup.screen()
  local screen = sizeup.win():screen():frame()
  local sem = sizeup.screen_edge_margins
  return {
    x = screen.x + sem.left,
    y = screen.y + sem.top,
    w = screen.w - (sem.left + sem.right),
    h = screen.h - (sem.top + sem.bottom)
  }
end
-- gutter is the adjustment required to accomidate partition
-- margins between windows
function sizeup.gutter()
  local pm = sizeup.partition_margins
  return {
    x = pm.x / 2,
    y = pm.y / 2
  }
end

--- hs.window:moveToScreen(screen)
--- Method
--- move window to the the given screen, keeping the relative proportion and position window to the original screen.
--- Example: win:moveToScreen(win:screen():next()) -- move window to next screen
function hs.window:moveToScreen(nextScreen)
  local currentFrame = self:frame()
  local screenFrame = self:screen():frame()
  local nextScreenFrame = nextScreen:frame()
  self:setFrame({
    x = ((((currentFrame.x - screenFrame.x) / screenFrame.w) * nextScreenFrame.w) + nextScreenFrame.x),
    y = ((((currentFrame.y - screenFrame.y) / screenFrame.h) * nextScreenFrame.h) + nextScreenFrame.y),
    h = ((currentFrame.h / screenFrame.h) * nextScreenFrame.h),
    w = ((currentFrame.w / screenFrame.w) * nextScreenFrame.w)
  })
end

--- Display message after loading
hs.alert.show("Config loaded")