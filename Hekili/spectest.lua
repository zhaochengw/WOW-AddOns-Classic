-- Add this to your Hekili addon for testing spec detection
-- Run /hek spectest in-game to test

local addon, ns = ...

local function TestSpecDetection()
    print("=== Hekili WeakAuras 风格专精检测测试 ===")
    
    -- Test if our new system is available
    if ns.GetSpecializationInfoForClassID then
        print("✓ ns.GetSpecializationInfoForClassID 已可用")
    else
        print("✗ ns.GetSpecializationInfoForClassID 不可用")
    end
    
    if ns.GetSpecialization then
        print("✓ ns.GetSpecialization 已可用")
    else
        print("✗ ns.GetSpecialization 不可用")
    end
    
    -- Test current player
    local className, classFile = UnitClass("player")
    print("玩家职业:", className, classFile)
    
    -- Test current spec detection
    if ns.GetSpecialization then
        local currentSpec = ns.GetSpecialization()
        print("当前专精索引:", currentSpec or "nil")
        
        if currentSpec and ns.GetSpecializationInfo then
            local specID, specName, description, icon, role = ns.GetSpecializationInfo(currentSpec)
            print("当前专精信息:", specID or "nil", specName or "nil", role or "nil")
        end
    end
    
    -- Test class-specific spec detection
    local classIDMap = {
        WARRIOR = 1, PALADIN = 2, HUNTER = 3, ROGUE = 4, PRIEST = 5,
        DEATHKNIGHT = 6, SHAMAN = 7, MAGE = 8, WARLOCK = 9, MONK = 10, DRUID = 11
    }
    
    local classID = classIDMap[classFile]
    if classID and ns.GetSpecializationInfoForClassID then
        print("针对 GetSpecializationInfoForClassID 测试", classFile, "(ID:", classID..")")
        
        -- Try to get spec info for each spec of this class
        for specIndex = 1, 4 do -- Max 4 specs (Druid has 4)
            local specID, specName, description, icon, role = ns.GetSpecializationInfoForClassID(classID, specIndex)
            if specID then
                print("  专精", specIndex..":", specID, specName or "未知", role or "未知")
            else
                print("  专精", specIndex..": 没有数据")
            end
        end
    end
    
    -- Test the original broken APIs for comparison
    print("=== 测试原始 API (应该是不可用的) ===")
    if C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo then
        print("✓ C_SpecializationInfo.GetSpecializationInfo 已存在")
    else
        print("✗ C_SpecializationInfo.GetSpecializationInfo 不存在")
    end
    
    if GetSpecializationInfoForClassID then
        print("✓ GetSpecializationInfoForClassID 已存在")
        -- Test original API
        if classID then
            local specID, specName = GetSpecializationInfoForClassID(classID, 1)
            print("原始 API 结果 专精 1:", specID or "nil", specName or "nil")
        end
    else
        print("✗ GetSpecializationInfoForClassID 不存在")
    end

    print("=== 测试完成 ===")
end

-- Make the test function available to the main addon
ns.TestSpecDetection = TestSpecDetection
