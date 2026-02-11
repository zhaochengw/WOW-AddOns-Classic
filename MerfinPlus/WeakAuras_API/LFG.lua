local MerfinPlus = LibStub("AceAddon-3.0"):GetAddon("MerfinPlus")

local db

function MerfinPlus:LFGEnable()
  db = self.db.profile

  self:RegisterEvent("LFG_PROPOSAL_SHOW", "HandleProposalShow")
  self:RegisterEvent("LFG_PROPOSAL_SUCCEEDED", "HandleProposalSucceeded")
  self:RegisterEvent("LFG_PROPOSAL_FAILED", "HandleProposalFailed")
  self:RegisterEvent("LFG_PROPOSAL_DONE", "HandleProposalDone")
end

local function HandleLFGProposal(show)
  if show then
    db.lfgStartTimer = time()
    db.lfgExpTimer = db.lfgStartTimer + 40
    WeakAuras.ScanEvents("WA_MERFIN_PROPOSAL", "SHOW")
  else
    db.lfgStartTimer = 0
    db.lfgExpTimer = 0
    WeakAuras.ScanEvents("WA_MERFIN_PROPOSAL", "HIDE")
  end
end

function MerfinPlus:HandleProposalShow()
  HandleLFGProposal(true)
end

function MerfinPlus:HandleProposalSucceeded()
  HandleLFGProposal(false)
end

function MerfinPlus:HandleProposalFailed()
  HandleLFGProposal(false)
end

function MerfinPlus:HandleProposalDone()
  HandleLFGProposal(false)
end

function Merfin.GetLFGTimer()
  local curTime = time()
  if (db.lfgExpTimer or 0) > curTime then
    return db.lfgExpTimer - curTime, db.lfgExpTimer - db.lfgStartTimer
  end
end
