local M = {}

local wezterm = require("wezterm")

local catppuccin = {
  dark = {
    rosewater = "#F5E0DC",
    flamingo = "#F2CDCD",
    pink = "#F5C2E7",
    mauve = "#CBA6F7",
    red = "#F38BA8",
    maroon = "#EBA0AC",
    peach = "#FAB387",
    yellow = "#F9E2AF",
    green = "#A6E3A1",
    teal = "#94E2D5",
    sky = "#89DCEB",
    sapphire = "#74C7EC",
    blue = "#89B4FA",
    lavender = "#B4BEFE",

    text = "#CDD6F4",
    subtext1 = "#BAC2DE",
    subtext0 = "#A6ADC8",
    overlay2 = "#9399B2",
    overlay1 = "#7F849C",
    overlay0 = "#6C7086",
    surface2 = "#585B70",
    surface1 = "#45475A",
    surface0 = "#313244",

    base = "#1E1E2E",
    mantle = "#181825",
    crust = "#11111B",
  },
  light = {
    rosewater = "#dc8a78",
    flamingo = "#DD7878",
    pink = "#ea76cb",
    mauve = "#8839EF",
    red = "#D20F39",
    maroon = "#E64553",
    peach = "#FE640B",
    yellow = "#df8e1d",
    green = "#40A02B",
    teal = "#179299",
    sky = "#04A5E5",
    sapphire = "#209FB5",
    blue = "#1e66f5",
    lavender = "#7287FD",

    text = "#4C4F69",
    subtext1 = "#5C5F77",
    subtext0 = "#6C6F85",
    overlay2 = "#7C7F93",
    overlay1 = "#8C8FA1",
    overlay0 = "#9CA0B0",
    surface2 = "#ACB0BE",
    surface1 = "#BCC0CC",
    surface0 = "#CCD0DA",

    base = "#FFFFFF",
    mantle = "#E6E9EF",
    crust = "#DCE0E8",
  },
}

local colors = catppuccin.dark

function M.get_process(tab)
  local process_icons = {
    ["docker"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["docker-compose"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["nvim"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.custom_vim },
    },
    ["vim"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.dev_vim },
    },
    ["node"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.mdi_hexagon },
    },
    ["zsh"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_terminal },
    },
    ["bash"] = {
      { Foreground = { Color = colors.subtext0 } },
      { Text = wezterm.nerdfonts.cod_terminal_bash },
    },
    ["paru"] = {
      { Foreground = { Color = colors.lavender } },
      { Text = wezterm.nerdfonts.linux_archlinux },
    },
    ["htop"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
    },
    ["cargo"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_rust },
    },
    ["go"] = {
      { Foreground = { Color = colors.sapphire } },
      { Text = wezterm.nerdfonts.mdi_language_go },
    },
    ["lazydocker"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["git"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_git },
    },
    ["lazygit"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_git },
    },
    ["lua"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.seti_lua },
    },
    ["wget"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_arrow_down_box },
    },
    ["curl"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_flattr },
    },
    ["gh"] = {
      { Foreground = { Color = colors.mauve } },
      { Text = wezterm.nerdfonts.dev_github_badge },
    },
  }

  local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

  return wezterm.format(
    process_icons[process_name]
    or { { Foreground = { Color = colors.sky } }, { Text = string.format("[%s]", process_name) } }
  )
end

return M
