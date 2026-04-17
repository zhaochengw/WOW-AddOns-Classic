-- Add this to your Hekili addon for testing spec detection
-- Run /hek spectest in-game to test

local addon, ns = ...

local function TestSpecDetection()
    print("=== Hekili WeakAuras-Style Spec Detection Test ===")
    
    -- Test if our new system is available
    if ns.GetSpecializationInfoForClassID then
        print("✓ ns.GetSpecializationInfoForClassID is available")
    else
        print("✗ ns.GetSpecializationInfoForClassID is NOT available")
    end
    
    if ns.GetSpecialization then
        print("✓ ns.GetSpecialization is available")
    else
        print("✗ ns.GetSpecialization is NOT available")
    end
    
    -- Test current player
    local className, classFile = UnitClass("player")
    print("Player class:", className, classFile)
    
    -- Test current spec detection
    if ns.GetSpecialization then
        local currentSpec = ns.GetSpecialization()
        print("Current spec index:", currentSpec or "nil")
        
        if currentSpec and ns.GetSpecializationInfo then
            local specID, specName, description, icon, role = ns.GetSpecializationInfo(currentSpec)
            print("Current spec info:", specID or "nil", specName or "nil", role or "nil")
        end
    end
    
    -- Test class-specific spec detection
    local classIDMap = {
        WARRIOR = 1, PALADIN = 2, HUNTER = 3, ROGUE = 4, PRIEST = 5,
        DEATHKNIGHT = 6, SHAMAN = 7, MAGE = 8, WARLOCK = 9, MONK = 10, DRUID = 11
    }
    
    local classID = classIDMap[classFile]
    if classID and ns.GetSpecializationInfoForClassID then
        print("Testing GetSpecializationInfoForClassID for", classFile, "(ID:", classID..")")
        
        -- Try to get spec info for each spec of this class
        for specIndex = 1, 4 do -- Max 4 specs (Druid has 4)
            local specID, specName, description, icon, role = ns.GetSpecializationInfoForClassID(classID, specIndex)
            if specID then
                print("  Spec", specIndex..":", specID, specName or "Unknown", role or "Unknown")
            else
                print("  Spec", specIndex..": No data")
            end
        end
    end
    
    -- Test the original broken APIs for comparison
    print("=== Testing Original APIs (should be broken) ===")
    if C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo then
        print("✓ C_SpecializationInfo.GetSpecializationInfo exists")
    else
        print("✗ C_SpecializationInfo.GetSpecializationInfo does NOT exist")
    end
    
    if GetSpecializationInfoForClassID then
        print("✓ GetSpecializationInfoForClassID exists")
        -- Test original API
        if classID then
            local specID, specName = GetSpecializationInfoForClassID(classID, 1)
            print("Original API result for spec 1:", specID or "nil", specName or "nil")
        end
    else
        print("✗ GetSpecializationInfoForClassID does NOT exist")
    end

    print("=== Test complete ===")
end

-- Make the test function available to the main addon
ns.TestSpecDetection = TestSpecDetection
