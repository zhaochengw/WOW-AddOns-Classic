-- =====================================================
-- File: Modules/TI_Compatibility.lua
-- Author: Domekologe
-- Description: Global API compatibility shims for MoP Classic (API 11.2)
-- Fixes embedded Examiner / old Inspect modules
-- =====================================================

if C_SpecializationInfo and not _G._TinyInspectTalentShimApplied then
    _G._TinyInspectTalentShimApplied = true

    ------------------------------------------------------------
    -- Old GetTalentInfo shim (returns MoP-style data)
    ------------------------------------------------------------
    if not GetTalentInfo then
        function GetTalentInfo(tier, column, isInspect, unit)
            local specIndex
            if isInspect and unit and C_SpecializationInfo.GetInspectSelectedSpec then
                specIndex = C_SpecializationInfo.GetInspectSelectedSpec(unit)
            else
                specIndex = C_SpecializationInfo.GetSpecialization()
            end
            if not specIndex then return end
            -- MoP API
            local talentID, name, icon, selected, available, spellID, row, col =
                C_SpecializationInfo.GetTalentInfo(tier, column, specIndex)
            -- Return in legacy order so old addons work
            return name, icon, tier, column, selected, available, spellID
        end
    end

    ------------------------------------------------------------
    -- Old GetSpecializationInfo shim
    ------------------------------------------------------------
    if not GetSpecializationInfo then
        function GetSpecializationInfo(specIndex)
            return C_SpecializationInfo.GetSpecializationInfo(specIndex)
        end
    end

    ------------------------------------------------------------
    -- Old GetInspectSpecialization shim
    ------------------------------------------------------------
    if not GetInspectSpecialization then
        function GetInspectSpecialization(unit)
            return C_SpecializationInfo.GetInspectSelectedSpec(unit)
        end
    end
end
