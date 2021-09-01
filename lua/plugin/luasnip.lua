local ls = require'luasnip'
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d
local l = require'luasnip.extras'.l
local r = require'luasnip.util.functions'.rep
local p = require("luasnip.util.functions").partial



ls.snippets = {
	all = {
		-- trigger is fn.
		s("fn", {
			-- Simple static text.
			t("//Parameters: "),
			-- function, first parameter is the function, second the Placeholders
			-- whose text it gets as input.
			f(copy, 2),
			t({ "", "function " }),
			-- Placeholder/Insert.
			i(1),
			t("("),
			-- Placeholder with initial text.
			i(2, "int foo"),
			-- Linebreak
			t({ ") {", "\t" }),
			-- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
			i(0),
			t({ "", "}" }),
		}),
		s("class", {
			-- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
			c(1, {
				t("public "),
				t("private "),
			}),
			t("class "),
			i(2),
			t(" "),
			c(3, {
				t("{"),
				-- sn: Nested Snippet. Instead of a trigger, it has a position, just like insert-nodes. !!! These don't expect a 0-node!!!!
				-- Inside Choices, Nodes don't need a position as the choice node is the one being jumped to.
				sn(nil, {
					t("extends "),
					i(1),
					t(" {"),
				}),
				sn(nil, {
					t("implements "),
					i(1),
					t(" {"),
				}),
			}),
			t({ "", "\t" }),
			i(0),
			t({ "", "}" }),
		}),
		-- Parsing snippets: First parameter: Snippet-Trigger, Second: Snippet body.
		-- Placeholders are parsed into choices with 1. the placeholder text(as a snippet) and 2. an empty string.
		-- This means they are not SELECTed like in other editors/Snippet engines.
		ls.parser.parse_snippet(
			"lspsyn",
			"Wow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}"
		),

		-- When wordTrig is set to false, snippets may also expand inside other words.
		ls.parser.parse_snippet(
			{ trig = "te", wordTrig = false },
			"${1:cond} ? ${2:true} : ${3:false}"
		),

		-- When regTrig is set, trig is treated like a pattern, this snippet will expand after any number.
		ls.parser.parse_snippet({ trig = "%d", regTrig = true }, "A Number!!"),

		-- The last entry of args passed to the user-function is the surrounding snippet.
		s(
			{ trig = "a%d", regTrig = true },
			f(function(args)
				return "Triggered with " .. args[1].trigger .. "."
			end, {})
		),
		-- It's possible to use capture-groups inside regex-triggers.
		s(
			{ trig = "b(%d)", regTrig = true },
			f(function(args)
				return "Captured Text: " .. args[1].captures[1] .. "."
			end, {})
		),
		-- Use a function to execute any shell command and print its text.
		s("bash", f(bash, {}, "ls")),
		-- Short version for applying String transformations using function nodes.
		s("transform", {
			i(1, "initial text"),
			t({ "", "" }),
			-- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
			-- This list will be applied in order to the first node given in the second argument.
			l(l._1:match("[^i]*$"):gsub("i", "o"):gsub(" ", "_"):upper(), 1),
		}),
		s("transform2", {
			i(1, "initial text"),
			t("::"),
			i(2, "replacement for e"),
			t({ "", "" }),
			-- Lambdas can also apply transforms USING the text of other nodes:
			l(l._1:gsub("e", l._2), { 1, 2 }),
		}),
		-- Shorthand for repeating the text in a given node.
		s("repeat", { i(1, "text"), t({ "", "" }), r(1) }),
		-- Directly insert the ouput from a function evaluated at runtime.
		s("part", p(os.date, "%Y")),
		-- use matchNodes to insert text based on a pattern/function/lambda-evaluation.
		s(
			"mat",
			{
				i(1, { "sample_text" }),
				t(": "),
				m(1, "%d", "contains a number", "no number :("),
			}
		),
		-- The inserted text defaults to the first capture group/the entire
		-- match if there are none
		s("mat2", {
			i(1, { "sample_text" }),
			t(": "),
			m(1, "[abc][abc][abc]"),
		}),
		-- It is even possible to apply gsubs' or other transformations
		-- before matching.
		s("mat3", {
			i(1, { "sample_text" }),
			t(": "),
			m(
				1,
				l._1:gsub("[123]", ""):match("%d"),
				"contains a number that isn't 1, 2 or 3!"
			),
		}),
		-- `match` also accepts a function, which in turn accepts a string
		-- (text in node, \n-concatted) and returns any non-nil value to match.
		-- If that value is a string, it is used for the default-inserted text.
		s("mat4", {
			i(1, { "sample_text" }),
			t(": "),
			m(1, function(text)
				return (#text % 2 == 0 and text) or nil
			end),
		}),
		-- The nonempty-node inserts text depending on whether the arg-node is
		-- empty.
		s("nempty", {
			i(1, "sample_text"),
			n(1, "i(1) is not empty!"),
		}),
	},
	java = {
		-- Very long example for a java class.
		s("fn", {
			d(6, jdocsnip, { 2, 4, 5 }),
			t("", ""),
			c(1, {
				t("public "),
				t("private "),
			}),
			c(2, {
				t("void"),
				t("String"),
				t("char"),
				t("int"),
				t("double"),
				t("boolean"),
				i(nil, ""),
			}),
			t(" "),
			i(3, "myFunc"),
			t("("),
			i(4),
			t(")"),
			c(5, {
				t(""),
				sn(nil, {
					t({ "", " throws " }),
					i(1),
				}),
			}),
			t({ " {", "\t" }),
			i(0),
			t({ "", "}" }),
		}),
	},
	tex = {
		-- rec_ls is self-referencing. That makes this snippet 'infinite' eg. have as many
		-- \item as necessary by utilizing a choiceNode.
		s("ls", {
			t({ "\\begin{itemize}", "\t\\item " }),
			i(1),
			d(2, rec_ls, {}),
			t({ "", "\\end{itemize}" }),
		}),
	},
}
