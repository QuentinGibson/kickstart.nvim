local ls = require 'luasnip'

local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local return_filename = function()
  local filename = vim.fn.expand '%:t' -- Get the filename with extension
  return filename:match '(.+)%..+$' or filename -- Remove the extension
end

ls.add_snippets('typescriptreact', {
  s('component', {
    t 'function ',
    f(return_filename),
    t { '() {', '\t' },
    i(1),
    t { '', '}' },
    t { '', 'export default ' },
    f(return_filename),
  }),

  s('componentp', {
    -- Props interface
    t { 'interface ' },
    f(function()
      return return_filename() .. 'Props'
    end), -- Interface name as filenameProps
    t { ' {', '  // Define your props here', '}', '', '' },
    -- Component function
    t { 'function ' },
    f(return_filename), -- Component name matches the filename
    t { '({}: ' },
    f(function()
      return return_filename() .. 'Props'
    end), -- Props type as filenameProps
    t { ') {', '  return (', '    <Bounded>', '      {/* Add your JSX here */}', '    </Bounded>', '  );', '}', '', 'export default ' },
    f(return_filename), -- Export the component
    t { ';' },
  }),
})

return {}
