local ls = require 'luasnip'

-- snippet
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets('cs', {
  s('cwl', {
    t 'Console.WriteLine($"',
    i(1),
    t '");',
    i(2),
  }),
})

ls.add_snippets('cs', {
  s('di', {
    t {
      'using Microsoft.Extensions.DependencyInjection;',
      'using Sandbox;',
      '',
      'static IServiceProvider BuildServiceProvider()',
      '{',
      '    var services = new ServiceCollection();',
      '    services.AddSingleton<App>();',
      '    return services.BuildServiceProvider();',
      '}',
      '',
      'BuildServiceProvider().GetRequiredService<App>().Run(args);',
      '',
      'namespace Sandbox',
      '{',
      '    public class App',
      '    {',
      '        public void Run(string[] args) { }',
      '    }',
    },
    i(1), -- Cursor position after the App class definition
    t {
      '',
      '}',
    },
  }),
}, { key = 'cs' })
