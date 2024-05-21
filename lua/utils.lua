local M = {}

-- Expand curly braces c# style
local function remove_braces(line)
  return line:gsub('%s*{%s*}', '')
end

local function create_braces_block(trimmed_line, indent)
  local new_lines = { trimmed_line }
  table.insert(new_lines, indent .. '{')
  table.insert(new_lines, indent .. '    ')
  table.insert(new_lines, indent .. '}')
  return new_lines
end

function M.expand_braces()
  local bufnr = vim.api.nvim_get_current_buf()
  local line_num = vim.fn.getcurpos()[2] - 1
  local line = vim.api.nvim_buf_get_lines(bufnr, line_num, line_num + 1, false)[1]
  local indent = line:match '^%s*'

  if line:find '{%s*}' then
    local trimmed_line = remove_braces(line)
    local new_lines = create_braces_block(trimmed_line, indent)

    vim.api.nvim_buf_set_lines(bufnr, line_num, line_num + 1, false, new_lines)
    vim.api.nvim_win_set_cursor(0, { line_num + 3, #indent + 4 })
    vim.cmd 'startinsert!'
  end
end

function M.toggle_autoformat()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    print("Autoformat enabled")
  else
    vim.g.disable_autoformat = true
    print("Autoformat disabled")
  end
end

-- Helper to scroll down half a screen
function M.lazy(keys)
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  return function()
    local old = vim.o.lazyredraw
    vim.o.lazyredraw = true
    vim.api.nvim_feedkeys(keys, 'nx', false)
    vim.o.lazyredraw = old
  end
end

-- Toggle Codeium completions
local buffer_source_enabled = true
function M.toggle_codeium()
  buffer_source_enabled = not buffer_source_enabled
  vim.g.codeium_enabled = buffer_source_enabled

  if buffer_source_enabled then
    table.insert(M.cmp_sources, { name = 'codeium' })
    vim.notify('ML Completion enabled', 'Info', { title = 'Status' })
  else
    for index, source in ipairs(M.cmp_sources) do
      if source.name == 'codeium' then
        table.remove(M.cmp_sources, index)
        break
      end
    end
    vim.notify('ML Completion disabled', 'Info', { title = 'Status' })
  end

  require('cmp').setup {
    sources = require('cmp').config.sources(M.cmp_sources),
  }
end

function M.setup_cmp_sources(sources)
  M.cmp_sources = sources
  vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require("utils").toggle_codeium()<CR>', { noremap = true, silent = true })
end

-- check wsl
function M.is_wsl()
  local output = vim.fn.systemlist 'uname -r'
  return not not string.find(output[1] or '', 'WSL')
end

return M
