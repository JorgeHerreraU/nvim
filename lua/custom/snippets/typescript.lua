local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

local function get_ts_params()
  local node_line = vim.fn.line '.'
  local next_line = vim.fn.getline(node_line + 1)
  local params = {}
  local param_str = next_line:match '%(([^)]+)%)'
  if not param_str then
    return {}
  end
  for param in param_str:gmatch '([^,]+)' do
    param = param:gsub('^%s*(.-)%s*$', '%1')
    local name, param_type = param:match '([^:]+):?%s*([^%s]*)'
    if name then
      name = name:gsub('^%s*(.-)%s*$', '%1')
      param_type = param_type:gsub('^%s*(.-)%s*$', '%1')
      table.insert(params, { name = name, type = param_type })
    end
  end
  local return_type = next_line:match '%)%s*:%s*([^%s{]+)'
  return params, return_type or 'any'
end

ls.add_snippets('typescript', {
  s('/**', {
    d(1, function()
      local params, return_type = get_ts_params()
      local nodes = {
        t { '/**', ' * ' },
        i(1, 'Description'),
        t { '', '' },
      }

      local tabstop = 2

      for _, param in ipairs(params) do
        table.insert(nodes, t { ' * @param {' })
        if param.type ~= '' then
          table.insert(nodes, t(param.type))
        else
          table.insert(nodes, i(tabstop, 'type'))
          tabstop = tabstop + 1
        end
        table.insert(nodes, t('} ' .. param.name .. ' - '))
        table.insert(nodes, i(tabstop, 'description'))
        table.insert(nodes, t { '', '' })
        tabstop = tabstop + 1
      end

      table.insert(nodes, t { ' * @returns {' })
      if return_type ~= 'any' then
        table.insert(nodes, t(return_type))
      else
        table.insert(nodes, i(tabstop, 'returnType'))
        tabstop = tabstop + 1
      end
      table.insert(nodes, t '} ')
      table.insert(nodes, i(tabstop, 'return description'))
      table.insert(nodes, t { '', ' */' })

      return ls.sn(nil, nodes)
    end),
  }),
})
