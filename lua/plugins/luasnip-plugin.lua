return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.2.0",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
        local ls = require 'luasnip'
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local d = ls.dynamic_node
        local sn = ls.snippet_node
        local f = ls.function_node
        -- add a snippet when press 'dm' that inserts $$ $$ and places the cursor in the middle
        ls.add_snippets("all", {
            s("dm", {
                t({ "$$" }), i(1), t({ "$$" })
            })
        })
        ls.add_snippets("lua", {
            s("trig", {
                t "text: ", i(1), t { "", "copy: " },
                d(2, function(args)
                        -- the returned snippetNode doesn't need a position; it's inserted
                        -- "inside" the dynamicNode.
                        return sn(nil, {
                            -- jump-indices are local to each snippetNode, so restart at 1.
                            i(1, args[1])
                        })
                    end,
                    { 1 })
            })
        })
    end
}
