local _, ns = ...

local GetBuildInfo = _G.GetBuildInfo
local GetSpellInfo = _G.GetSpellInfo
local UnitFactionGroup = _G.UnitFactionGroup

-- ============================================================
-- 版本检测与定义
-- ============================================================
local EXP_CLASSIC = 1 -- 1.x
local EXP_TBC     = 2 -- 2.x
local EXP_WLK     = 3 -- 3.x
local EXP_CATA    = 4 -- 4.x
local EXP_MOP     = 5 -- 5.x
local EXP_RETAIL  = 9 -- 9.x+

local function GetCurrentExpansion()
    local toc = select(4, GetBuildInfo())
    if toc < 20000 then return EXP_CLASSIC end
    if toc < 30000 then return EXP_TBC end
    if toc < 40000 then return EXP_WLK end
    if toc < 50000 then return EXP_CATA end
    if toc < 60000 then return EXP_MOP end
    return EXP_RETAIL
end

local CURRENT_EXP = GetCurrentExpansion()

-- ============================================================
-- 数据容器 (按扩展包版本)
-- ============================================================
local DATA = {}

-- ============================================================
-- 数据: WLK (当前版本: 3.x)
-- ============================================================
DATA[EXP_WLK] = {
    portals = {
        runes = { portal = 17032, teleport = 17031 },
        list = {
            -- [中立主城]
            { name="达拉然", short="达拉", icon=237509, portal=53140, tele=53140, faction=nil },
            { name="沙塔斯", short="沙城", icon=135760, portal=33690, tele=35715, faction=nil },
            
            -- [部落主城]
            { name="奥格瑞玛", short="奥格", icon=135759, portal=11417, tele=3567, faction="Horde" },
            { name="幽暗城",   short="幽暗", icon=135766, portal=11418, tele=3563, faction="Horde" },
            { name="雷霆崖",   short="雷霆", icon=135765, portal=11420, tele=3566, faction="Horde" },
            { name="银月城",   short="银月", icon=135761, portal=32267, tele=32272, faction="Horde" },
            { name="斯通纳德", short="斯通", icon=135762, portal=49361, tele=49358, faction="Horde" },
            
            -- [联盟主城]
            { name="暴风城",   short="暴风", icon=135763, portal=10059, tele=3561, faction="Alliance" },
            { name="铁炉堡",   short="铁炉", icon=135757, portal=11416, tele=3562, faction="Alliance" },
            { name="达纳苏斯", short="达纳", icon=135755, portal=11419, tele=3565, faction="Alliance" },
            { name="埃索达",   short="埃索", icon=135756, portal=32266, tele=32271, faction="Alliance" },
            { name="塞拉摩",   short="塞拉", icon=135764, portal=49360, tele=49359, faction="Alliance" },
        }
    }
}

-- ============================================================
-- 数据: TBC (未来支持: 2.x) - 仅作结构示例
-- ============================================================
-- [开发说明] 目前 TBC 数据不完整，暂时屏蔽以防错误加载
-- 只有在 TBC 版本下才会加载此表
-- DATA[EXP_TBC] = {
--     consumables = {
--         ["Test"] = { { id = 6948, name = "炉石" } },
--         -- 待填充 TBC 药水数据...
--     },
--     portals = {
--         runes = { portal = 17032, teleport = 17031 },
--         list = {
--             -- TBC 只有沙塔斯，没有达拉然，没有斯通纳德/塞拉摩传送
--              { name="沙塔斯", short="沙城", icon=135760, portal=33690, tele=35715, faction=nil },
--              -- ... 基础主城同上 ...
--         }
--     }
-- }

-- ============================================================
-- 数据: MoP (5.x)
-- ============================================================
DATA[EXP_MOP] = {
    consumables = {
        ["Test"] = { { id = 6948, name = "炉石" } },
        -- 待填充 MoP 药水数据...
    },
    portals = {
        runes = { portal = 17032, teleport = 17031 },
        list = {
            -- [中立主城]
            { name="锦绣谷", short="锦绣", icon=851297, portal=132626, tele=132627, faction=nil },
            { name="托尔巴拉德", short="托巴", icon=nil, portal=88345, tele=88342, faction=nil },
            { name="达拉然", short="达拉", icon=237509, portal=53140, tele=53140, faction=nil },
            { name="沙塔斯", short="沙城", icon=135760, portal=33690, tele=35715, faction=nil },

            -- [部落主城]
            { name="奥格瑞玛", short="奥格", icon=135759, portal=11417, tele=3567, faction="Horde" },
            { name="幽暗城",   short="幽暗", icon=135766, portal=11418, tele=3563, faction="Horde" },
            { name="雷霆崖",   short="雷霆", icon=135765, portal=11420, tele=3566, faction="Horde" },
            { name="银月城",   short="银月", icon=135761, portal=32267, tele=32272, faction="Horde" },
            { name="斯通纳德", short="斯通", icon=135762, portal=49361, tele=49358, faction="Horde" },
            
            -- [联盟主城]
            { name="暴风城",   short="暴风", icon=135763, portal=10059, tele=3561, faction="Alliance" },
            { name="铁炉堡",   short="铁炉", icon=135757, portal=11416, tele=3562, faction="Alliance" },
            { name="达纳苏斯", short="达纳", icon=135755, portal=11419, tele=3565, faction="Alliance" },
            { name="埃索达",   short="埃索", icon=135756, portal=32266, tele=32271, faction="Alliance" },
            { name="塞拉摩",   short="塞拉", icon=135764, portal=49360, tele=49359, faction="Alliance" },
        }
    }
}

-- ============================================================
-- 数据加载与处理
-- ============================================================
ns.IsPortalReagentFree = (CURRENT_EXP >= EXP_MOP)

local activeData = DATA[CURRENT_EXP]

if activeData then
    -- 1. 加载并处理法术/传送门数据
    ns.SpellBarData = {}
    local runes = activeData.portals.runes
    local myFaction = UnitFactionGroup("player")
    
    for _, p in ipairs(activeData.portals.list) do
        -- [Fix] 强过滤：仅加载当前阵营或中立的传送门
        if not p.faction or p.faction == myFaction then
            local icon = p.icon
            if not icon then
                local _, _, spellIcon = GetSpellInfo(p.portal or 0)
                if not spellIcon then
                    _, _, spellIcon = GetSpellInfo(p.tele or 0)
                end
                icon = spellIcon
            end
            table.insert(ns.SpellBarData, {
                type = "custom_portal",
                name = p.name,
                icon = icon,
                overlayText = p.short,
                
                spellLeft = "传送门："..p.name,
                itemPortal = runes.portal,
                
                spellRight = "传送："..p.name,
                itemTeleport = runes.teleport,
                
                portalID = p.portal,
                teleportID = p.tele,
                cdSpellID = p.tele,
                requiredFaction = p.faction
            })
        end
    end
else
    -- 如果当前版本没有数据支持，则设为 nil，这将导致 Module 在 Core.lua 中自动禁用
    ns.SpellBarData = nil
end
