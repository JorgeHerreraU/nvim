local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

local function get_params_from_func()
  local node_line = vim.fn.line '.'
  local nodes = {}
  local next_line = vim.fn.getline(node_line + 1)
  local params = next_line:match '%(([^)]+)%)'
  if not params then
    return {}
  end
  for param in params:gmatch '([^,]+)' do
    param = param:gsub('^%s*(.-)%s*$', '%1') -- trim whitespace
    table.insert(nodes, param)
  end
  return nodes
end

ls.add_snippets('javascript', {
  s('/**', {
    d(1, function()
      local params = get_params_from_func()
      local nodes = {
        t { '/**', ' * ' },
        i(1, 'Description'),
        t { '', '' },
      }

      -- Keep track of the current tabstop number
      local tabstop = 2

      for _, param in ipairs(params) do
        table.insert(nodes, t { ' * @param {' })
        table.insert(nodes, i(tabstop, 'type'))
        table.insert(nodes, t('} ' .. param .. ' - '))
        table.insert(nodes, i(tabstop + 1, 'description'))
        table.insert(nodes, t { '', '' })
        tabstop = tabstop + 2
      end

      -- Add return type and description with proper tabstops
      table.insert(nodes, t { ' * @returns {' })
      table.insert(nodes, i(tabstop, 'returnType'))
      table.insert(nodes, t '} ')
      table.insert(nodes, i(tabstop + 1, 'return description'))
      table.insert(nodes, t { '', ' */' })

      return ls.sn(nil, nodes)
    end),
  }),
})
