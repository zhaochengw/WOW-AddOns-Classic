local _G = getfenv(0)
--[[
	Usage: zBar3:GetDefault("zMainBar")
	or : zBar3:GetDefault("zMainBar", "pos")
--]]
function zBar3:GetDefault(name, key, subkey)
	local k,v,m,n

	if type(name) == "table" then
		name = name:GetName()
	end

	-- copy
	local set = {}
	for k,v in pairs(zBar3.defaults[name]) do
		if type(v) == "table" then
			set[k] = {}
			for m,n in pairs(v) do
				set[k][m] = n
			end
		else
			set[k] = v
		end
	end

	-- common values
	for k,v in pairs(zBar3.defaults["*"]) do
		if set[k] then
		  if type(v) == "table" then
        for m,n in pairs(v) do
          if set[k][m] == nil then set[k][m] = n end
        end
      else
        set[k] = v
			end
		end
	end

	if key then
		set = set[key]
		if subkey then set = set[subkey] end
	end

	return set
end

-- zBar3 defaults
zBar3.defaults = {
	["*"] = {
	  init = {width=36,height=36,frameStrata="MEDIUM"},
	  saves = {num = 12, inset = 0, layout = "line", linenum = 2, alpha = 1,},
	},
	["zExBar1"] = {
	  init = {id=1},
	  saves = {hide=true,num=6,linenum=1,},
	  pos = {"CENTER",36,72},
	},
	["zShadow1"] = {
	  init = {id=-1},
	  saves = {hide=true,num=6,linenum=1, max=6,},
	  pos = {"CENTER",72,72},
	},
	["zExBar2"] = {
	  init = {id=2},
	  saves = {hide=true,num=6,linenum=1,},
	  pos = {"CENTER",-36,72},
	},
	["zShadow2"] = {
	  init = {id=-2},
	  saves = {hide=true,num=6,linenum=1, max=6,},
	  pos = {"CENTER",0,72},
	},

	["zExBar3"] = {
	  init = {id=3},
    saves = {hide=true,num=6,linenum=1,},
    pos = {"CENTER",108,72},
	},
	["zShadow3"] = {
	  init = {id=-3},
    saves = {hide=true,num=6,linenum=1, max=6,},
    pos = {"CENTER",144,72},
	},
	["zExBar4"] = {
	  init = {id=4},
    saves = {hide=true,num=6,linenum=1,},
    pos = {"CENTER",-108,72},
	},
	["zShadow4"] = {
	  init = {id=-4},
    saves = {hide=true,num=6,linenum=1, max=6,},
    pos = {"CENTER",-72,72},
	},

	["zCastBar"] = {
	  init = {id=16,width=34,height=13},
		saves = {num = 2, max = 2, hideTab=true,hide=false,},
		pos={"BOTTOM",0,210},
	},
}