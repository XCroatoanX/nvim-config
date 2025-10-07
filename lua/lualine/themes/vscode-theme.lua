local colors = {
  black        = '#1e1e1e',
  white        = '#d4d4d4',
  red          = '#f44747',
  green        = '#608b4e',
  blue         = '#569cd6',
  yellow       = '#dcdcaa',
  gray         = '#808080',
  darkgray     = '#2d2d2d',
  lightgray    = '#3c3c3c',
  inactivegray = '#5a5a5a',
}
local vscode_lualine = {
  normal = {
    a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray },
  },
  insert = {
    a = { bg = colors.green, fg = colors.black, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray },
  },
  replace = {
    a = { bg = colors.red, fg = colors.black, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray },
  },
  command = {
    a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray },
  },
  inactive = {
    a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.gray },
    c = { bg = colors.darkgray, fg = colors.gray },
  },
}

return vscode_lualine
