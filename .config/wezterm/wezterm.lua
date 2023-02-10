-- wezterm config inspired by https://github.com/thanhvule0310/dotfiles
local wezterm = require("wezterm")
local keymaps = require("keys")
local process_icons = require("process_icons")

local function is_vi_process(pane)
  return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function conditional_activate_pane(window, pane, pane_direction, vim_direction)
  if is_vi_process(pane) then
    window:perform_action(wezterm.action.SendKey({ key = vim_direction, mods = "ALT" }), pane)
  else
    window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
  conditional_activate_pane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
  conditional_activate_pane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
  conditional_activate_pane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
  conditional_activate_pane(window, pane, "Down", "j")
end)

local function get_process(tab)
  local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

  if process_name == "" then
    process_name = "zsh"
  end

  return wezterm.format(
    process_icons.icons[process_name]
    or { { Text = string.format("[%s]", process_name) } }
  )
end

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir
  local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

  return current_dir == HOME_DIR and "~"
      or string.format("%s", string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

wezterm.on("format-tab-title", function(tab)
  return wezterm.format({
    { Attribute = { Intensity = "Half" } },
    { Text = string.format(" %s ", tab.tab_index + 1) },
    "ResetAttributes",
    { Text = get_process(tab) },
    { Text = " " },
    { Text = get_current_working_dir(tab) },
    { Text = "▕" },
  })
end)

wezterm.on("update-right-status", function(window)
  window:set_right_status(wezterm.format({
    { Attribute = { Intensity = "Normal" } },
    { Text = wezterm.strftime(" %A, %d %B %Y %-H:%M ") },
  }))
end)

return {
  font = wezterm.font_with_fallback({
    "Liga SFMono Nerd Font",
    "Apple Color Emoji",
  }),
  font_size = 15,
  max_fps = 120,
  color_scheme = "Default Dark (base16)",
  enable_wayland = false,
  pane_focus_follows_mouse = false,
  warn_about_missing_glyphs = false,
  show_update_window = false,
  check_for_updates = false,
  line_height = 1.1,
  window_decorations = "RESIZE",
  window_close_confirmation = "NeverPrompt",
  audible_bell = "Disabled",
  window_padding = {
    left = 0,
    right = 0,
    top = 5,
    bottom = 0,
  },
  initial_cols = 110,
  initial_rows = 25,
  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = is_dark and 0.85 or 0.95,
  },
  enable_scroll_bar = false,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  show_new_tab_button_in_tab_bar = false,
  window_background_opacity = 1.0,
  tab_max_width = 50,
  hide_tab_bar_if_only_one_tab = true,
  disable_default_key_bindings = true,
  keys = keymaps.keys,
  send_composed_key_when_left_alt_is_pressed = true, -- alt keybindings
  use_ime = false,
  use_dead_keys = true,
  debug_key_events = false,
  front_end = "WebGpu",
  hyperlink_rules = {
    {
      regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b",
      format = "$0",
    },
    {
      regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },
    {
      regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      format = "mailto:$0",
    },
    {
      regex = [[\bfile://\S*\b]],
      format = "$0",
    },
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = "$0",
    },
    {
      regex = [[\b[tT](\d+)\b]],
      format = "https://example.com/tasks/?t=$1",
    },
  },
}
