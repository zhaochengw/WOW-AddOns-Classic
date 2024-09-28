-- this file contains some of the type definitions used in this library

---@class treeCurrencyInfo
---@field traitCurrencyID number
---@field quantity number
---@field maxQuantity number?
---@field spent number
---@field isClassCurrency boolean? # true if the currency is a class currency, nil otherwise
---@field isSpecCurrency boolean? # true if the currency is a spec currency, nil otherwise
---@field subTreeID number? # the sub tree ID that the currency is associated with if any, nil otherwise

---@alias edgeType
---| 0 # VisualOnly
---| 1 # DeprecatedRankConnection
---| 2 # SufficientForAvailability
---| 3 # RequiredForAvailability
---| 4 # MutuallyExclusive
---| 5 # DeprecatedSelectionOption

---@alias visualStyle
---| 0 # None
---| 1 # Straight

---@alias nodeType
---| 0 # single
---| 1 # Tiered
---| 2 # Selection

---@alias nodeFlags
---| 1 # ShowMultipleIcons
---| 2 # NeverPurchasable
---| 4 # TestPositionLocked
---| 8 # TestGridPositioned

---@class visibleEdge
---@field type edgeType # see Enum.TraitNodeEdgeType
---@field visualStyle visualStyle # see Enum.TraitEdgeVisualStyle
---@field targetNode number # TraitNodeID

---@class libNodeInfo
---@field ID number # TraitNodeID
---@field posX number
---@field posY number
---@field type nodeType # see Enum.TraitNodeType
---@field maxRanks number
---@field flags nodeFlags # see Enum.TraitNodeFlag
---@field groupIDs number[]
---@field visibleEdges visibleEdge[] # The order does not always match C_Traits
---@field conditionIDs number[]
---@field entryIDs number[] # TraitEntryID - generally, choice nodes will have 2, otherwise there's just 1
---@field specInfo table<number, number[]> # specID: conditionType[] Deprecated, will be removed in 10.1.0; see Enum.TraitConditionType
---@field visibleForSpecs table<number, boolean> # specID: true/false, true if a node is visible for a spec; added in 10.1.0
---@field grantedForSpecs table<number, boolean> # specID: true/false, true if a node is granted for free, for a spec; added in 10.1.0
---@field isClassNode boolean
---@field subTreeID number? # the sub tree ID that the node is associated with if any, nil otherwise; added in 11.0.0
---@field isSubTreeSelection boolean? # true if the node is a sub tree selection node, nil otherwise; added in 11.0.0

---@class entryInfo
---@field definitionID number # TraitDefinitionID
---@field type number # see Enum.TraitNodeEntryType
---@field maxRanks number
---@field isAvailable boolean # LibTalentTree always returns true
---@field conditionIDs number[] # list of TraitConditionID, LibTalentTree always returns an empty table
---@field subTreeID number? # the sub tree ID that the entry will select if any, nil otherwise; added in 11.0.0

---@class gateInfo
---@field topLeftNodeID number # TraitNodeID - the node that is the top left corner of the gate
---@field conditionID number # TraitConditionID
---@field spentAmountRequired number # the total amount of currency required to unlock the gate
---@field traitCurrencyID number # TraitCurrencyID

---@class subTreeInfo
---@field ID number # SubTreeID
---@field name string # localized name
---@field description string # localized description
---@field iconElementID string # icon atlas
---@field maxCurrency number # the maximum amount of currency that can be spent in this sub tree
---@field posX number # generally corresponds to posX of the top center node (generally the initial starting node)
---@field posY number # generally corresponds to posY of the top center node (generally the initial starting node)
---@field requiredPlayerLevel number
---@field traitCurrencyID number # TraitCurrencyID spent when learning talents in this sub tree
---@field subTreeSelectionNodeIDs number[] # TraitNodeID - the selection nodes that specify whether the sub tree is selected
---@field isActive boolean # hardcoded to false
