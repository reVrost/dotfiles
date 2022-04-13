local ls = require "luasnip"

-- This is a snippet creator
--  s(<trigger>, <nodes>)
local s = ls.s
local t = ls.text_node

-- This is format node, like sprintf
local fmt = require("luasnip.extras.fmt").fmt

-- This is an insert node, i(position, default_text)
local i = ls.insert_node

-- This repeats a node rep(position)
local rep = require("luasnip.extras").rep
-- ls.add_snippets("all", {
--    s("china", fmt("sello", {})),
--    { key = "china" },
-- })
--

-- All
-- ls.add_snippets("all", {
--    s("pr", fmt('fmt.Printf("{} is %+v\n", {})', { i(1, "default"), rep(1) })),
-- })

-- Go
ls.add_snippets("go", {
   -- Print anything
   s("pr", fmt('fmt.Printf("debug: {} is %+v\\n", {})', { i(1, "default"), rep(1) })),
   -- If has key
   s(
      "ihk",
      fmt(
         [[
        if val, ok := {}["{}"]; ok {{
            {}
        }}
       ]],
         { i(1, "dict"), i(2, "key"), i(3, "code") }
      )
   ),
   s(
      "er",
      fmt(
         [[
          {}, err := {} 
          if err != nil {{
              return {}err
          }}   
        ]],
         { i(1, "val"), i(2, "fn()"), i(3, "nil, ") }
      )
   ),
})
