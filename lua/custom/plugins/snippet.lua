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
  -- Simple functional component
  s('sfc', {
    t 'function ',
    d(1, function()
      return sn(nil, i(1, return_filename()))
    end),
    t { '() {', '\treturn (' },
    t { '', '\t\t<div>' },
    t { '', '\t\t\t' },
    i(2),
    t { '', '\t\t</div>' },
    t { '', '\t)' },
    t { '', '}' },
    t { '', '', 'export default ' },
    f(function(args)
      return args[1][1]
    end, { 1 }),
  }),

  -- Functional component with props
  s('sfcp', {
    -- Props interface
    t { 'interface ' },
    f(function()
      return return_filename() .. 'Props'
    end),
    t { ' {', '\t' },
    i(1, '// Define your props here'),
    t { '', '}', '', '' },
    -- Component function
    t { 'function ' },
    f(return_filename),
    t { '({ ' },
    i(2),
    t { ' }: ' },
    f(function()
      return return_filename() .. 'Props'
    end),
    t { ') {', '\treturn (' },
    t { '', '\t\t<div>' },
    t { '', '\t\t\t' },
    i(3),
    t { '', '\t\t</div>' },
    t { '', '\t)' },
    t { '', '}', '', 'export default ' },
    f(return_filename),
  }),

  -- React functional component with export
  s('rfce', {
    t { "import React from 'react'", '', '' },
    t 'export default function ',
    f(return_filename),
    t { '() {', '\treturn (' },
    t { '', '\t\t<div>' },
    t { '', '\t\t\t' },
    i(1),
    t { '', '\t\t</div>' },
    t { '', '\t)' },
    t { '', '}' },
  }),

  -- Arrow function component with export
  s('rafce', {
    t { "import React from 'react'", '', '' },
    t 'const ',
    f(return_filename),
    t { ' = () => {', '\treturn (' },
    t { '', '\t\t<div>' },
    t { '', '\t\t\t' },
    i(1),
    t { '', '\t\t</div>' },
    t { '', '\t)' },
    t { '', '}', '', 'export default ' },
    f(return_filename),
  }),

  -- useState hook
  s('useState', {
    t 'const [',
    i(1, 'state'),
    t ', set',
    f(function(args)
      return args[1][1]:gsub('^%l', string.upper)
    end, { 1 }),
    t '] = useState',
    t '<',
    i(2),
    t '>(',
    i(3),
    t ')',
  }),

  -- useEffect hook
  s('useEffect', {
    t { 'useEffect(() => {', '\t' },
    i(1),
    t { '', '\treturn () => {', '\t\t' },
    i(2, '// cleanup'),
    t { '', '\t}', '}, [' },
    i(3),
    t '])',
  }),

  -- useCallback hook
  s('useCallback', {
    t 'const ',
    i(1, 'memoizedCallback'),
    t { ' = useCallback(', '\t(' },
    i(2),
    t { ') => {', '\t\t' },
    i(3),
    t { '', '\t},', '\t[' },
    i(4),
    t { ']', ')' },
  }),

  -- useMemo hook
  s('useMemo', {
    t 'const ',
    i(1, 'memoizedValue'),
    t { ' = useMemo(() => {', '\t' },
    i(2),
    t { '', '}, [' },
    i(3),
    t '])',
  }),

  -- useRef hook
  s('useRef', {
    t 'const ',
    i(1, 'ref'),
    t ' = useRef',
    t '<',
    i(2),
    t '>(',
    i(3, 'null'),
    t ')',
  }),

  -- Custom hook
  s('custom', {
    t 'export function use',
    i(1, 'CustomHook'),
    t '(',
    i(2),
    t { ') {', '\t' },
    i(3, '// Hook logic here'),
    t { '', '', '\treturn ' },
    i(4, '{}'),
    t { '', '}' },
  }),

  -- Context with provider
  s('ctx', {
    t { "import React, { createContext, useContext, ReactNode } from 'react'", '', '' },
    t 'interface ',
    i(1, 'Context'),
    t { 'Type {', '\t' },
    i(2, '// Define context type'),
    t { '', '}', '', 'const ' },
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t 'Context = createContext<',
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t { "Type | undefined>(undefined)", '', '' },
    t 'export function ',
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t { 'Provider({ children }: { children: ReactNode }) {', '\tconst value = {', '\t\t' },
    i(3, '// Provider value'),
    t { '', '\t}', '', '\treturn (' },
    t { '', '\t\t<' },
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t { 'Context.Provider value={value}>', '\t\t\t{children}', '\t\t</' },
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t { 'Context.Provider>', '\t)' },
    t { '', '}', '', 'export function use' },
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t { '() {', '\tconst context = useContext(' },
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t { 'Context)', '\tif (!context) {', "\t\tthrow new Error('use" },
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t { " must be used within " },
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t { "Provider')", '\t}', '\treturn context', '}' },
  }),
})

-- Copy the same snippets for JavaScript React files
ls.add_snippets('javascriptreact', ls.get_snippets('typescriptreact'))

return {}
