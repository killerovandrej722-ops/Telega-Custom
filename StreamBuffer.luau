--!native
--!optimize 2

local bcreate = buffer.create
local bcopy = buffer.copy
local breadstring = buffer.readstring
local bwritestring = buffer.writestring
local bwriteu8 = buffer.writeu8
local bwriteu16 = buffer.writeu16
local bwriteu32 = buffer.writeu32
local bwritei8 = buffer.writei8
local bwritei16 = buffer.writei16
local bwritei32 = buffer.writei32
local bwritef32 = buffer.writef32
local bwritef64 = buffer.writef64

local StreamBuffer = {}
StreamBuffer.__index = StreamBuffer

-- Создаёт растущий буфер. buf — текущий buffer, len — сколько байт уже занято.
function StreamBuffer.new(capacity)
	capacity = math.max(capacity or 64, 16)
	return setmetatable({
		buf = bcreate(capacity), -- свежий buffer всегда заполнен нулями
		len = 0,
		cap = capacity,
	}, StreamBuffer)
end

-- Гарантирует место под ещё n байт после len.
-- ВАЖНО: может заменить self.buf, поэтому после reserve/allocRegion
-- нужно перечитывать sbuf.buf.
function StreamBuffer:reserve(n)
	local need = self.len + n
	local cap = self.cap
	if need <= cap then
		return
	end

	repeat
		cap *= 2
	until cap >= need

	local newBuf = bcreate(cap)
	if self.len > 0 then
		bcopy(newBuf, 0, self.buf, 0, self.len)
	end
	self.buf = newBuf
	self.cap = cap
end

-- Резервирует n нулевых байт и возвращает смещение начала региона (с нуля).
function StreamBuffer:allocRegion(n)
	self:reserve(n)
	local offset = self.len
	self.len = offset + n
	return offset
end

function StreamBuffer:writeu8(v)
	self:reserve(1)
	bwriteu8(self.buf, self.len, v)
	self.len += 1
end

function StreamBuffer:writei8(v)
	self:reserve(1)
	bwritei8(self.buf, self.len, v)
	self.len += 1
end

function StreamBuffer:writeu16(v)
	self:reserve(2)
	bwriteu16(self.buf, self.len, v)
	self.len += 2
end

function StreamBuffer:writei16(v)
	self:reserve(2)
	bwritei16(self.buf, self.len, v)
	self.len += 2
end

function StreamBuffer:writeu32(v)
	self:reserve(4)
	bwriteu32(self.buf, self.len, v)
	self.len += 4
end

function StreamBuffer:writei32(v)
	self:reserve(4)
	bwritei32(self.buf, self.len, v)
	self.len += 4
end

function StreamBuffer:writef32(v)
	self:reserve(4)
	bwritef32(self.buf, self.len, v)
	self.len += 4
end

function StreamBuffer:writef64(v)
	self:reserve(8)
	bwritef64(self.buf, self.len, v)
	self.len += 8
end

-- Сырая строка без префикса длины.
function StreamBuffer:writestring(s)
	local n = #s
	if n == 0 then
		return
	end
	self:reserve(n)
	bwritestring(self.buf, self.len, s)
	self.len += n
end

-- Строка с префиксом длины u32 (формат .rbxl).
function StreamBuffer:writeLenString(s)
	local n = #s
	self:reserve(4 + n)
	local buf, o = self.buf, self.len
	bwriteu32(buf, o, n)
	if n > 0 then
		bwritestring(buf, o + 4, s)
	end
	self.len = o + 4 + n
end

-- Возвращает занятую часть буфера как строку.
function StreamBuffer:tostring()
	return breadstring(self.buf, 0, self.len)
end

-- Возвращает копию занятой части как новый buffer.
function StreamBuffer:tobuffer()
	local out = bcreate(self.len)
	bcopy(out, 0, self.buf, 0, self.len)
	return out
end

return StreamBuffer
