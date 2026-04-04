-- blockmarks by @kraftwerk28
-- updated and improved by @dmyTRUEk and ChatGPT
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
			-- [[
			-- 	(struct_item
			-- 		name: (type_identifier) @name
			-- 	) @body
			-- ]],
			-- [[
			-- 	(enum_item
			-- 		name: (type_identifier) @name
			-- 	) @body
			-- ]],
			[[
				(impl_item
					type: (_) @name
					body: (declaration_list) @body
				)
			]],
			-- [[
			-- 	(impl_item
			-- 		trait: (_) @name
			-- 	) @body
			-- ]],
			[[
				(trait_item
					name: (type_identifier) @name
					body: (declaration_list) @body
				)
			]],
			[[
				(for_expression
					pattern: (_) @pat
					value: (_) @val
					body: (block) @body
				)
			]],
			-- TODO: loop_expression with label
			[[
				(if_expression
					condition: (_) @name
					consequence: (block) @body
				)
			]],
			-- [[
			-- 	(let_declaration
			-- 		pattern: (identifier) @name
			-- 	) @body
			-- ]],
			-- [[
			-- 	(block
			-- 		pattern: (identifier) @name
			-- 	) @body
			-- ]],
			-- [[
			-- 	(mod_item
			-- 		name: (identifier) @name
			-- 	) @body
			-- ]],
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

		if query_code:find("function_item") then
			q.format = function(name)
				return "end of fn " .. name
			end

		elseif query_code:find("if_expression") then
			q.format = function(name)
				return "end of if " .. name
			end

		elseif query_code:find("for_expression") then
			q.format = function(_, match, get_node, bufnr)
				local pat = get_node(match, q.pat_cap_id)
				local val = get_node(match, q.val_cap_id)

				if not pat or not val then return "end of for" end

				local psr, psc, per, pec = pat:range()
				local vsr, vsc, ver, vec = val:range()

				local ptxt = vim.api.nvim_buf_get_text(bufnr, psr, psc, per, pec, {})[1]
				local vtxt = vim.api.nvim_buf_get_text(bufnr, vsr, vsc, ver, vec, {})[1]

				return "end of for " .. ptxt .. " in " .. vtxt
			end

		elseif query_code:find("impl_item") then
			q.format = function(name)
				return "end of impl " .. name
			end

		elseif query_code:find("trait_item") then
			q.format = function(name)
				return "end of trait " .. name
			end

		-- TODO: lua for_statement
		end

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

local function get_text(node, bufnr)
	local sr, sc, er, ec = node:range()
	return vim.api.nvim_buf_get_text(bufnr, sr, sc, er, ec, {})[1]
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

			if not body_node then
				goto continue
			end

			local body_srow, body_scol = body_node:start()
			local body_erow, body_ecol = body_node:end_()

			if body_erow - body_srow >= 10 then
				local name_text = name_node and get_text(name_node, bufnr) or ""

				local label
				if query.format then
					label = query.format(name_text, match, get_node, bufnr)
				else
					label = "end of " .. name_text
				end

				api.nvim_buf_set_extmark(bufnr, ns, body_erow, body_ecol, {
					virt_text = {
						{ query.comment .. label, 'Comment' },
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

