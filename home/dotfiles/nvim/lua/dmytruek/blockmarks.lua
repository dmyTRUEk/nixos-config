-- blockmarks by @kraftwerk28
-- queries by @dmyTRUEk
--
-- to make queries: `:TSPlaygroundToggle`

local api = vim.api

local queries = {
	-- cpp = {
	-- 	comment = "// ",
	-- 	queries = {
	-- 		[[
	-- 			(namespace_definition
	-- 				name: (_) @name
	-- 				body: (_) @body)
	-- 		]],
	-- 	},
	-- },
	lua = {
		comment = '-- ',
		queries = {
			[[
				(function_declaration
					name: (identifier) @name
				) @body
			]],
			[[
				(assignment_statement
					(variable_list name: (_) @name)
					(expression_list value: (_) @body)
				)
			]],
			[[
				(for_statement
					clause: (for_generic_clause) @name
				) @body
			]],
			[[
				(field
					name: (identifier) @name
				) @body
			]],
			-- [[
			-- 	(field
			-- 		TODO
			-- 	)
			-- ]],
			-- TODO: end of function call/params
			-- TODO: end of if
		},
	},
	nix = {
		comment = '# ',
		queries = {
			[[
				(binding
					attrpath: (attrpath) @name
				) @body
			]],
		}
	},
	rust = {
		comment = '// ',
		queries = {
			[[
				(function_item
					name: (identifier) @name
				) @body
			]],
			[[
				(struct_item
					name: (type_identifier) @name
				) @body
			]],
			[[
				(enum_item
					name: (type_identifier) @name
				) @body
			]],
			[[
				(impl_item
					type: (_) @name
				) @body
			]],
			[[
				(impl_item
					trait: (_) @name
				) @body
			]],
			[[
				(trait_item
					name: (_) @name
				) @body
			]],
			[[
				(for_expression
					pattern: (_) @name
				) @body
			]],
			[[
				(if_expression
					condition: (_) @name
				) @body
			]],
			[[
				(let_declaration
					pattern: (identifier) @name
				) @body
			]],
			-- [[
			-- 	(block
			-- 		pattern: (identifier) @name
			-- 	) @body
			-- ]],
			[[
				(mod_item
					name: (identifier) @name
				) @body
			]],
		},
	},
}

local parsed_queries = {}
for lang, qdef in pairs(queries) do
	for _, query_code in ipairs(qdef.queries) do
		local q = vim.treesitter.query.parse(lang, query_code)
		for id, name in ipairs(q.captures) do
			q[name .. '_cap_id'] = id
		end
		q.comment = qdef.comment
		table.insert(parsed_queries, q)
	end
end

local ns = api.nvim_create_namespace('blockmark')

local function get_node(m, id)
	local n = m[id]
	if type(n) == "table" then
		return n[1]
	end
	return n
end

local function update_extmarks(bufnr)
	api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

	local parser = vim.treesitter.get_parser(bufnr)
	local tree = parser:parse()[1]
	local root = tree:root()

	for _, query in ipairs(parsed_queries) do
		for _, match in query:iter_matches(root, bufnr) do
			local body_node = get_node(match, query.body_cap_id)
			local name_node = get_node(match, query.name_cap_id)

			if not body_node or not name_node then
				goto continue
			end

			local body_srow, body_scol = body_node:start()
			local body_erow, body_ecol = body_node:end_()

			if body_erow - body_srow >= 10 then
				local name_srow, name_scol = name_node:start()
				local name_erow, name_ecol = name_node:end_()

				local name_content = api.nvim_buf_get_text(
					bufnr,
					name_srow, name_scol,
					name_erow, name_ecol,
					{}
				)[1]

				api.nvim_buf_set_extmark(bufnr, ns, body_erow, body_ecol, {
					virt_text = {
						{ query.comment .. 'end of ', 'Comment' },
						{ name_content, 'Constant' },
					},
					virt_text_pos = "eol",
				})
			end

			::continue::
		end
	end
end

vim.api.nvim_create_autocmd({
	"BufEnter",
	"BufWinEnter",
	"TextChanged",
	"TextChangedI",
}, {
	-- TODO: just use `queries`
	pattern = {
		--"*.c",
		--"*.cpp",
		"*.lua",
		"*.nix",
		"*.py",
		"*.rs",
	},
	callback = function(ev)
		local bufnr = ev.buf
		vim.schedule(function()
			update_extmarks(bufnr)
		end)
	end,
})

