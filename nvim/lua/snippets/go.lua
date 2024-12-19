local ls = require "luasnip"
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
-- local util = require "settings.luasnip.util"
local get_node_text = vim.treesitter.get_node_text
local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"
-- Conditions {{{
-- local function not_in_function()
--    return not util.is_in_function()
-- end

-- local in_test_func = {
--    show_condition = util.is_in_test_function,
--    condition = util.is_in_test_function,
-- }
--
-- local in_test_file = {
--    show_condition = util.is_in_test_file,
--    condition = util.is_in_test_file,
-- }
--
-- local in_func = {
--    show_condition = util.is_in_function,
--    condition = util.is_in_function,
-- }
--
-- local not_in_func = {
--    show_condition = not_in_function,
--    condition = not_in_function,
-- }
-- --}}}
--

-- tjdevries Transformations {{{
local transforms = {
   int = function(_, _)
      return ls.t "0"
   end,

   bool = function(_, _)
      return ls.t "false"
   end,

   string = function(_, _)
      return ls.t [[""]]
   end,

   error = function(_, info)
      if info then
         info.index = info.index + 1

         return ls.c(info.index, {
            ls.t(info.err_name),
            ls.t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
         })
      else
         return ls.t "err"
      end
   end,

   -- Types with a "*" mean they are pointers, so return nil
   [function(text)
      return string.find(text, "*", 1, true) ~= nil
   end] = function(_, _)
      return ls.t "nil"
   end,
}
local transform = function(text, info)
   local condition_matches = function(condition, ...)
      if type(condition) == "string" then
         return condition == text
      else
         return condition(...)
      end
   end
   for condition, result in pairs(transforms) do
      if condition_matches(condition, text, info) then
         return result(text, info)
      end
   end

   return ls.t(text)
end

local handlers = {
   parameter_list = function(node, info)
      local result = {}

      local count = node:named_child_count()
      for idx = 0, count - 1 do
         local matching_node = node:named_child(idx)
         local type_node = matching_node:field("type")[1]
         table.insert(result, transform(get_node_text(type_node, 0), info))
         if idx ~= count - 1 then
            table.insert(result, ls.t { ", " })
         end
      end

      return result
   end,

   type_identifier = function(node, info)
      local text = get_node_text(node, 0)
      return { transform(text, info) }
   end,
}

local function_node_types = {
   function_declaration = true,
   method_declaration = true,
   func_literal = true,
}

local function go_result_type(info)
   local cursor_node = ts_utils.get_node_at_cursor()
   local scope = ts_locals.get_scope_tree(cursor_node, 0)

   local function_node
   for _, v in ipairs(scope) do
      if function_node_types[v:type()] then
         function_node = v
         break
      end
   end

   if not function_node then
      print "Not inside of a function"
      return ls.t ""
   end

   local query = vim.treesitter.query.parse(
      "go",
      [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
    ]]
   )
   for _, node in query:iter_captures(function_node, 0) do
      if handlers[node:type()] then
         return handlers[node:type()](node, info)
      end
   end
end

local go_ret_vals = function(args)
   return ls.sn(
      nil,
      go_result_type {
         index = 0,
         err_name = args[1][1],
         func_name = args[2][1],
      }
   )
end
-- }}}

return {
   -- Test Cases {{{
   ls.s(
      { trig = "tcs", dscr = "create test cases for testing" },
      fmta(
         [[
        tcs := map[string]struct {
        	<>
        } {
        	// Test cases here
        }
        for name, tc := range tcs {
        	tc := tc
        	t.Run(name, func(t *testing.T) {
        		<>
        	})
        }
      ]],
         { ls.i(1), ls.i(2) }
      )
      -- in_test_func
   ), --}}}

   -- Good If err {{{
   ls.s(
      { trig = "ier", dscr = "if err that detects return vals" },
      fmta(
         [[
        <val>, <err> := <f>(<args>)
        if <err_same> != nil {
          return <result>
        }
        <finish>
        ]],
         {
            val = ls.i(1),
            err = ls.i(2, "err"),
            f = ls.i(3),
            args = ls.i(4),
            err_same = rep(2),
            result = ls.d(5, go_ret_vals, { 2, 3 }),
            finish = ls.i(0),
         }
      )
   ),
   -- }}}
}
