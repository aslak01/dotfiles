local wezterm = require 'wezterm'
local M = {}
M.icons = {
  ["docker"] = {
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ["docker-compose"] = {
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ["nvim"] = {
    { Text = wezterm.nerdfonts.custom_vim },
  },
  ["vim"] = {
    { Text = wezterm.nerdfonts.dev_vim },
  },
  ["node"] = {
    { Text = wezterm.nerdfonts.mdi_hexagon },
  },
  ["zsh"] = {
    { Text = wezterm.nerdfonts.dev_terminal },
  },
  ["bash"] = {
    { Text = wezterm.nerdfonts.cod_terminal_bash },
  },
  ["paru"] = {
    { Text = wezterm.nerdfonts.linux_archlinux },
  },
  ["htop"] = {
    { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
  },
  ["cargo"] = {
    { Text = wezterm.nerdfonts.dev_rust },
  },
  ["go"] = {
    { Text = wezterm.nerdfonts.mdi_language_go },
  },
  ["lazydocker"] = {
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ["git"] = {
    { Text = wezterm.nerdfonts.dev_git },
  },
  ["lazygit"] = {
    { Text = wezterm.nerdfonts.dev_git },
  },
  ["lua"] = {
    { Text = wezterm.nerdfonts.seti_lua },
  },
  ["wget"] = {
    { Text = wezterm.nerdfonts.mdi_arrow_down_box },
  },
  ["curl"] = {
    { Text = wezterm.nerdfonts.mdi_flattr },
  },
  ["gh"] = {
    { Text = wezterm.nerdfonts.dev_github_badge },
  },
}

return M
