--!native
--!optimize 2

-- Находит функции экзекутора по "предикатам": Lua-коду в виде строки,
-- который получает (имя_функции, имя_родительской_таблицы) через `...`
-- и возвращает truthy, если функция подходит.
--
-- finder(predicates, deep, maxDepth)
--   predicates : { [имя] = "lua-код предиката" }
--   deep       : искать ещё и во вложенных таблицах (crypt.base64encode и т.п.)
--   maxDepth   : максимальная глубина обхода (по умолчанию 10)

local global_container = {}

local function collectRoots()
	local roots, seen = {}, {}

	local function add(t)
		if type(t) == "table" and not seen[t] then
			seen[t] = true
			roots[#roots + 1] = t
		end
	end

	pcall(function()
		add(getgenv())
	end)
	pcall(function()
		add(getrenv())
	end)
	pcall(function()
		add(getfenv())
	end)
	pcall(function()
		add(_G)
	end)
	pcall(function()
		add(shared)
	end)

	return roots
end

local function compile(source)
	local fn = loadstring(source)
	return type(fn) == "function" and fn or nil
end

local function finder(predicates, deep, maxDepth)
	maxDepth = maxDepth or 10

	local compiled = {}
	local pending = 0

	for name, source in predicates do
		if global_container[name] == nil then
			local fn = compile(source)
			if fn then
				compiled[name] = fn
				pending += 1
			end
		end
	end

	if pending == 0 then
		return global_container
	end

	local roots = collectRoots()

	-- 1) Точное совпадение имени среди глобалов (самый надёжный вариант)
	for name in compiled do
		for _, env in roots do
			local ok, value = pcall(rawget, env, name)
			if ok and type(value) == "function" then
				global_container[name] = value
				compiled[name] = nil
				pending -= 1
				break
			end
		end
	end

	if pending == 0 then
		return global_container
	end

	-- 2) Нечёткий поиск по предикатам, обход в ширину
	-- (верхний уровень приоритетнее вложенных таблиц)
	local visited = {}
	local queue = {}
	local head, tail = 1, 0

	for _, env in roots do
		visited[env] = true
		tail += 1
		queue[tail] = { env, "", 1 }
	end

	while head <= tail and pending > 0 do
		local node = queue[head]
		head += 1

		local container, parentName, depth = node[1], node[2], node[3]

		pcall(function()
			for key, value in next, container do
				if type(key) ~= "string" then
					continue
				end

				local valueType = type(value)

				if valueType == "function" then
					for name, predicate in compiled do
						local ok, matched = pcall(predicate, key, parentName)
						if ok and matched then
							global_container[name] = value
							compiled[name] = nil
							pending -= 1
							if pending == 0 then
								return
							end
						end
					end
				elseif deep and valueType == "table" and depth < maxDepth and not visited[value] then
					visited[value] = true
					tail += 1
					queue[tail] = { value, key, depth + 1 }
				end
			end
		end)
	end

	return global_container
end

return finder, global_container
