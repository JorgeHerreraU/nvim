-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
-- Use the `dependencies` key to specify the dependencies of a particular plugin
return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  tag = '0.1.6',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    {
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
    },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local window_picker = require 'window-picker'

    -- Configure the window picker (adjust these settings as you prefer)
    window_picker.setup {
      hint = 'floating-big-letter',
      filter_rules = {
        autoselect_one = true,
        include_current_win = true,
      },
    }

    local function custom_get_selection_window(picker, entry)
      local picked_window_id = window_picker.pick_window() or vim.api.nvim_get_current_win()
      return picked_window_id
    end

    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      defaults = {
        file_ignore_patterns = {
          'node_modules/.*',
          'bin/.*',
          'obj/.*',
          'build/.*',
          'dist/.*',
          'target/.*',
          'out/.*',
          'vendor/.*',
          '.git/.*',
          '.vscode/.*',
          '.idea/.*',
          '.next/.*',
          'gradle/.*',
          'app/build/.*',
          '%.o',
          '%.a',
          '%.log',
          '%.class',
          '%.pdf',
          '%.jpg',
          '%.png',
        },
        get_selection_window = custom_get_selection_window,
        layout_strategy = 'horizontal',
        previewer = true,
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    -- Keys
    -- Helper keymaps functions
    local find_files = function()
      builtin.find_files { hidden = true, no_ignore = true, no_ignore_parent = true }
    end
    local find_buffer = function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = false,
      })
    end
    local grep_open_files = function()
      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end
    local find_nvim_files = function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end
    local grep_string_under_cursor = function()
      builtin.grep_string {
        search = vim.fn.expand '<cword>',
        word_match = '-w',
        only_sort_text = true,
        search_dirs = { 'src/', 'lib/' },
        file_ignore_patterns = { '*.min.js', '*.min.css' }, -- Ignore minified files
      }
    end
    -- Keybindings
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
    vim.keymap.set('n', '<leader>fs', builtin.search_history, { desc = 'Find History' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymaps' })
    vim.keymap.set('n', '<leader>ff', find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = 'Find Select Telescope' })
    vim.keymap.set('n', '<leader>fw', grep_string_under_cursor, { desc = 'Find Current Word' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find by Grep' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Find Resume' })
    vim.keymap.set('n', '<leader>fn', find_nvim_files, { desc = 'Find Neovim files' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Find Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>f/', grep_open_files, { desc = 'Find in Open Files' })
    vim.keymap.set('n', '<leader>/', find_buffer, { desc = 'Find in buffer' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find Opened Buffers' })
  end,
}
