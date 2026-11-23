-- sort rules
-- src: claude

local SORT_KEYS = {
	alphabetical = true,
	btime = true,
	extension = true,
	mtime = true,
	natural = true,
	random = true,
	size = true,
}

-- "mtime_reverse" -> { key = "mtime", reverse = true }
local function parse(name)
	local parts = {}
	for w in name:gmatch("[^_]+") do parts[#parts + 1] = w end

	if not SORT_KEYS[parts[1]] then
		return nil, ("unknown sort key '%s' in '%s'"):format(parts[1] or "", name)
	end
	if #parts > 2 or (parts[2] and parts[2] ~= "reverse") then
		return nil, ("'%s': only an optional '_reverse' may follow the sort key"):format(name)
	end
	return { name = name, key = parts[1], reverse = parts[2] == "reverse" }
end

-- relative -> $HOME/..., strip trailing slashes
local function normalize(path, home)
	if path:sub(1, 1) ~= "/" then path = home .. "/" .. path end
	path = path:gsub("/+$", "")
	return path == "" and "/" or path
end

local function setup(_, opts)
	local home = os.getenv("HOME")
	local dir_first = opts.dir_first ~= false
	local errors = {}
	local exact, tree = {}, {} -- "Downloads" -> exact, "Downloads/" -> tree

	local default, derr = parse(opts.default or "natural")
	if not default then
		errors[#errors + 1] = "default: " .. derr
		default = { key = "natural", reverse = false }
	end

	local function add(tbl, abs, label, rule)
		local prev = tbl[abs]
		if prev then
			errors[#errors + 1] = prev.name == rule.name
				and ("'%s' is listed twice in '%s'"):format(label, rule.name)
				or ("'%s' is in both '%s' and '%s'"):format(label, prev.name, rule.name)
		else
			tbl[abs] = rule
		end
	end

	local names = {}
	for name in pairs(opts.rules or {}) do names[#names + 1] = name end
	table.sort(names)

	for _, name in ipairs(names) do
		local rule, err = parse(name)
		if not rule then
			errors[#errors + 1] = err
		else
			for _, p in ipairs(opts.rules[name]) do
				local abs = normalize(p, home)
				if p:sub(-1) == "/" then
					add(tree, abs, abs == "/" and "/" or abs .. "/", rule)
				else
					add(exact, abs, abs, rule)
				end
			end
		end
	end

	-- exact match first, then walk up from cwd to "/" and take the deepest "dir/" rule
	local function lookup(cwd)
		local r = exact[cwd]
		if r then return r end
		local p = cwd
		while true do
			r = tree[p]
			if r then return r end
			if p == "/" then return nil end
			p = p:match("^(.*)/[^/]*$")
			if p == "" then p = "/" end
		end
	end

	local reported = false
	ps.sub("ind-sort", function(opt)
		if #errors > 0 and not reported then
			reported = true
			ya.notify {
				title = "sort-rules",
				content = table.concat(errors, "\n"),
				timeout = 15,
				level = "error",
			}
		end

		local cwd = normalize(tostring(cx.active.current.cwd), home)
		local r = lookup(cwd) or default
		opt.by, opt.reverse, opt.dir_first = r.key, r.reverse, dir_first
		return opt
	end)
end

return { setup = setup }
