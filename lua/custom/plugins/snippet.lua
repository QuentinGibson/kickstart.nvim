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
    i(1, return_filename()),
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

  -- Shadcn/UI Component Import Snippets
  -- Card components
  s('ui-card', {
    t 'import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"',
  }),

  -- Button components
  s('ui-button', {
    t 'import { Button } from "@/components/ui/button"',
  }),

  -- Input components
  s('ui-input', {
    t 'import { Input } from "@/components/ui/input"',
  }),

  -- Form components
  s('ui-form', {
    t 'import { Form, FormControl, FormDescription, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"',
  }),

  -- Dialog components
  s('ui-dialog', {
    t 'import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog"',
  }),

  -- Sheet components
  s('ui-sheet', {
    t 'import { Sheet, SheetClose, SheetContent, SheetDescription, SheetFooter, SheetHeader, SheetTitle, SheetTrigger } from "@/components/ui/sheet"',
  }),

  -- Dropdown Menu components
  s('ui-dropdown', {
    t 'import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger, DropdownMenuCheckboxItem, DropdownMenuRadioItem, DropdownMenuRadioGroup, DropdownMenuPortal, DropdownMenuSub, DropdownMenuSubContent, DropdownMenuSubTrigger, DropdownMenuGroup, DropdownMenuShortcut } from "@/components/ui/dropdown-menu"',
  }),

  -- Select components
  s('ui-select', {
    t 'import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue, SelectGroup, SelectLabel, SelectSeparator } from "@/components/ui/select"',
  }),

  -- Table components
  s('ui-table', {
    t 'import { Table, TableBody, TableCaption, TableCell, TableFooter, TableHead, TableHeader, TableRow } from "@/components/ui/table"',
  }),

  -- Tabs components
  s('ui-tabs', {
    t 'import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"',
  }),

  -- Alert components
  s('ui-alert', {
    t 'import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert"',
  }),

  -- Badge component
  s('ui-badge', {
    t 'import { Badge } from "@/components/ui/badge"',
  }),

  -- Checkbox component
  s('ui-checkbox', {
    t 'import { Checkbox } from "@/components/ui/checkbox"',
  }),

  -- Label component
  s('ui-label', {
    t 'import { Label } from "@/components/ui/label"',
  }),

  -- Toast components
  s('ui-toast', {
    t 'import { Toast, ToastAction, ToastClose, ToastDescription, ToastProvider, ToastTitle, ToastViewport } from "@/components/ui/toast"',
  }),

  -- Tooltip components
  s('ui-tooltip', {
    t 'import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from "@/components/ui/tooltip"',
  }),

  -- Avatar components
  s('ui-avatar', {
    t 'import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"',
  }),

  -- Popover components
  s('ui-popover', {
    t 'import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"',
  }),

  -- Command components
  s('ui-command', {
    t 'import { Command, CommandDialog, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList, CommandSeparator, CommandShortcut } from "@/components/ui/command"',
  }),

  -- Calendar component
  s('ui-calendar', {
    t 'import { Calendar } from "@/components/ui/calendar"',
  }),

  -- Accordion components
  s('ui-accordion', {
    t 'import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from "@/components/ui/accordion"',
  }),

  -- Progress component
  s('ui-progress', {
    t 'import { Progress } from "@/components/ui/progress"',
  }),

  -- Slider component
  s('ui-slider', {
    t 'import { Slider } from "@/components/ui/slider"',
  }),

  -- Switch component
  s('ui-switch', {
    t 'import { Switch } from "@/components/ui/switch"',
  }),

  -- Textarea component
  s('ui-textarea', {
    t 'import { Textarea } from "@/components/ui/textarea"',
  }),

  -- Separator component
  s('ui-separator', {
    t 'import { Separator } from "@/components/ui/separator"',
  }),

  -- Skeleton component
  s('ui-skeleton', {
    t 'import { Skeleton } from "@/components/ui/skeleton"',
  }),

  -- ScrollArea components
  s('ui-scroll-area', {
    t 'import { ScrollArea, ScrollBar } from "@/components/ui/scroll-area"',
  }),

  -- HoverCard components
  s('ui-hover-card', {
    t 'import { HoverCard, HoverCardContent, HoverCardTrigger } from "@/components/ui/hover-card"',
  }),

  -- Drawer components
  s('ui-drawer', {
    t 'import { Drawer, DrawerClose, DrawerContent, DrawerDescription, DrawerFooter, DrawerHeader, DrawerTitle, DrawerTrigger } from "@/components/ui/drawer"',
  }),
})

-- Copy the same snippets for JavaScript React files
ls.add_snippets('javascriptreact', ls.get_snippets('typescriptreact'))

return {}
