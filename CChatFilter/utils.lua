

bfwf_split_str = function(str, sp)
    local strs = {}
    if not sp then
        sp = 0x2c
    else
        sp,_ = string.byte(sp,1,1)
    end
    if not str then
        return strs
    end

    local bs = {string.byte(str,1,-1)}
    local tmp = {}
    for i=1,#bs do
        local b = bs[i]
        if b == sp then
            if #tmp>0 then
                table.insert(strs,table.concat(tmp))
                tmp = {}
            end
        elseif b ~= 0xd and b ~= 0xa then
            table.insert(tmp,string.char(b))
        end
    end

    if #tmp>0 then
        table.insert(strs,table.concat(tmp))
    end

    return strs
end

function bfwf_start_whith(s1,s2)
    if not s1 or not s2 then
        return false
    end

    if type(s1) ~= 'string' or type(s2) ~= 'string' then
        return false
    end
    return s2 == string.sub(s1,1,string.len(s2))
end
