local CreateClass = LibStub("Poncho-1.0");

TrackerHelperBase = CreateClass("Frame", "TrackerHelperBase");
local Base = TrackerHelperBase;
local cache = {
    hex = {}
};

function Base:_distance(x1, y1, x2, y2)
	return math.sqrt( (x2-x1)^2 + (y2-y1)^2 );
end

function Base:_count(t)
    local _count = 0;
    if t then
        for _, _ in pairs(t) do _count = _count + 1 end
    end
    return _count;
end

function Base:_hex2rgb(hex)
    if not cache.hex[hex] then
        hex = hex:gsub("#", "");

        if #hex == 8 then
            cache.hex[hex] = {
                r = tonumber("0x" .. hex:sub(3,4)) / 255,
                g = tonumber("0x" .. hex:sub(5,6)) / 255,
                b = tonumber("0x" .. hex:sub(7,8)) / 255,
                a = tonumber("0x" .. hex:sub(1,2)) / 255
            };
        else
            cache.hex[hex] = {
                r = tonumber("0x" .. hex:sub(1,2)) / 255,
                g = tonumber("0x" .. hex:sub(3,4)) / 255,
                b = tonumber("0x" .. hex:sub(5,6)) / 255,
                a = 1.0
            };
        end
    end

    return cache.hex[hex];
end

function Base:_normalizeColor(value)
    if not value then return end

    if type(value) == "string" then
        value = self:_hex2rgb(value);
    end

    return {
        r = value.r or 0.0,
        g = value.g or 0.0,
        b = value.b or 0.0,
        a = value.a or 1.0,
    };
end

function Base:OnCreate()
    local setHeight = self.SetHeight;
    function self:SetHeight(height)
        self.height = height;
        setHeight(self, math.max(1, height));
    end
end

function Base:OnRelease()
    self.height = nil;
end

function Base:GetRealHeight()
    return self.height or self:GetHeight();
end
