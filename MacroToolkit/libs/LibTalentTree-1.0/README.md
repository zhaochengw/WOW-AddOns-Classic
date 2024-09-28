# LibTalentTree-1.0

LibTalentTree-1.0 is a library that provides an interface for accessing talent trees and talent node information.

Blizzard's C_Traits API isn't always easy to use, and getting talent information for other classes/specs can be tedious. This library aims to make your life easier.
> If you're interested in using the library, but have questions or feedback, I would love to hear from you!

## Known issues
 * None, let me know if you find any!

## License
Full permission is granted to publish, distribute, or otherwise share **unmodified** versions of this library with your addon.
All API functions and other data objects exposed by this library, may be freely used by your addon, without restriction.
All other rights are reserved.

## Usage

### Distributing the library with your addon
If you want to distribute the library with your addon, you can do so by including the following entry in your .pkgmeta file (this is just an example!):
```
externals:
    libs/LibStub: https://repos.wowace.com/wow/ace3/trunk/LibStub
    libs/LibTalentTree-1.0:
        url: https://github.com/NumyAddon/LibTalentTree-1.0
        curse-slug: libtalenttree
```
Add `libs\LibTalentTree-1.0\LibTalentTree-1.0.xml`, as well as LibStub, to your toc file, and you're good to go!

### Upgrade notes
Previous versions of the library, used `Id` instead of `ID` in most function names.
These functions are still available, but are undocumented, deprecated, and may be removed in a future version.

Table structures are not affected, as these were already using `ID`.

#### Expansion and minor patch features
When a new expansion or minor patch is available for early testing, the library will be updated to support the new features in a backwards compatible manor.
It is intended that the library will always work on the current live game version, and generally for any upcoming PTR/Beta versions.

### Quick reference
Most of the information returned matches the in-game C_Traits API, which has up-to-date documentation on [wiki C_Traits](https://warcraft.wiki.gg/wiki/Category:API_namespaces/C_Traits).
 * `nodeInfo = LibTalentTree:GetNodeInfo(nodeID)` [#GetNodeInfo](#getnodeinfo)
   * Returns a table containing all the information for a given node, enriched with C_Traits data if available.
 * `nodeInfo = LibTalentTree:GetLibNodeInfo(nodeID)` [#GetLibNodeInfo](#getlibnodeinfo)
   * Returns a table containing all the information for a given node, without any C_Traits data.
 * `entryInfo = LibTalentTree:GetEntryInfo(entryID)` [#GetEntryInfo](#getentryinfo)
   * Returns a table containing all the information for a given node entry.
 * `treeID = LibTalentTree:GetTreeIDForNode(nodeID)` [#GetTreeIDForNode](#gettreeidfornode)
   * Returns the treeID for a given node.
 * `treeID = LibTalentTree:GetTreeIDForEntry(entryID)` [#GetTreeIDForEntry](#gettreeidforentry)
   * Returns the treeID for a given NodeEntry.
 * `treeID = LibTalentTree:GetClassTreeID(classID | classFileName)` [#GetClassTreeID](#getclasstreeid)
   * Returns the treeID for a given class.
 * `classID = LibTalentTree:GetClassIDByTreeID(treeID)` [#GetClassIDByTreeID](#getclassidbytreeid)
   * Returns the classID for a given tree.
 * `isVisible = LibTalentTree:IsNodeVisibleForSpec(specID, nodeID)` [#IsNodeVisibleForSpec](#isnodevisibleforspec)
   * Returns whether or not a node is visible for a given spec.
 * `isGranted = LibTalentTree:IsNodeGrantedForSpec(specID, nodeID)` [#IsNodeGrantedForSpec](#isnodegrantedforspec)
   * Returns whether or not a node is granted by default for a given spec.
 * `posX, posY = LibTalentTree:GetNodePosition(nodeID)` [#GetNodePosition](#getnodeposition)
   * Returns the position of a node in a given tree.
 * `column, row = LibTalentTree:GetNodeGridPosition(nodeID)` [#GetNodeGridPosition](#getnodegridposition)
   * Returns an abstracted grid position of a node in a given tree.
 * `isClassNode = LibTalentTree:IsClassNode(nodeID)` [#IsClassNode](#isclassnode)
   * Returns whether a node is a class node, or a spec node.
 * `edges = LibTalentTree:GetNodeEdges(nodeID)` [#GetNodeEdges](#getnodeedges)
   * Returns a list of edges for a given node.
 * `gates = LibTalentTree:GetGates(specID)` [#GetGates](#getgates)
   * Returns a list of gates for a given spec.
 * `isCompatible = LibTalentTree:IsCompatible()` [#IsCompatible](#iscompatible)
   * Returns the library is compatible with the current game version.

### GetNodeInfo
if available, C_Traits nodeInfo is used instead, and specInfo is mixed in.
If C_Traits nodeInfo returns a zeroed out table, the table described below is mixed in.
#### Syntax
```
nodeInfo = LibTalentTree:GetNodeInfo(nodeID)
nodeInfo = LibTalentTree:GetNodeInfo(treeID, nodeID)
```
#### Arguments
* [number] nodeID - The TraitNodeID of the node you want to get the info for.

For backwards compatibility, the following syntax is also supported: 
* [number] treeID - TraitTreeID
* [number] nodeID - The TraitNodeID of the node you want to get the info for.
#### Returns
* [table] nodeInfo

##### nodeInfo
| Field                 | Differences from C_Traits                                           | Extra info                                                                                                                                                         |
|-----------------------|---------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [number] ID           | None                                                                |                                                                                                                                                                    |
| [number] posX         | None                                                                | some class trees have a global offset                                                                                                                              |
| [number] posY         | None                                                                | some class trees have a global offset                                                                                                                              |
| [number] type         | None                                                                | 0: single, 1: Tiered, 2: Selection                                                                                                                                 |
| [number] maxRanks     | None                                                                |                                                                                                                                                                    |
| [number] flags        | None                                                                | &1: ShowMultipleIcons                                                                                                                                              |
| [table] groupIDs      | None                                                                | list of [number] groupIDs                                                                                                                                          |
| [table] visibleEdges  | isActive field is missing, the order does not always match C_Traits | list of [table] visibleEdges                                                                                                                                       |
| [table] conditionIDs  | None                                                                | list of [number] conditionIDs                                                                                                                                      |
| [table] entryIDs      | None                                                                | list of [number] entryIDs; generally, choice nodes will have 2, otherwise there's just 1                                                                           |
| [table] specInfo      | Lib-only field                                                      | table of [number] [specID](https://warcraft.wiki.gg/wiki/SpecializationID) = [table] list of conditionTypes; specID 0 means global; see Enum.TraitConditionType |
| [boolean] isClassNode | Lib-only field                                                      | whether the node is part of the class tree or spec tree                                                                                                            |

##### visibleEdges
| Field                | Differences from C_Traits | Extra info                                                                                                                                               |
|----------------------|---------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| [number] type        | None                      | 0: VisualOnly, 1: DeprecatedRankConnection, 2: SufficientForAvailability, 3: RequiredForAvailability, 4: MutuallyExclusive, 5: DeprecatedSelectionOption |
| [number] visualStyle | None                      | 0: None, 1: Straight                                                                                                                                     |
| [number] targetNode  | None                      | TraitNodeID                                                                                                                                              |
#### Example

```lua
local LibTalentTree = LibStub("LibTalentTree-1.0");
local treeID = LibTalentTree:GetClassTreeID('PALADIN');
local nodes = C_Traits.GetTreeNodes(treeID);
local configID = C_ClassTalents.GetActiveConfigID();
for _, nodeID in ipairs(nodes) do
    local nodeInfo = LibTalentTree:GetNodeInfo(nodeID);
    local entryInfo = C_Traits.GetEntryInfo(configID, nodeInfo.entryIDs[1]);
end
```


### GetLibNodeInfo
Get node info as stored in the library
#### Syntax
```
nodeInfo = LibTalentTree:GetLibNodeInfo(nodeID)
nodeInfo = LibTalentTree:GetLibNodeInfo(treeID, nodeID)
```
#### Arguments
* [number] nodeID - The TraitNodeID of the node you want to get the info for.

For backwards compatibility, the following syntax is also supported:
* [number] treeID - The TraitTreeID of the tree you want to get the node info for.
* [number] nodeID - The TraitNodeID of the node you want to get the info for.
#### Returns
* [table|nil] nodeInfo, nil if not found
##### nodeInfo
| Field                 | Differences from C_Traits                                           | Extra info                                                                                                                                                         |
|-----------------------|---------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [number] ID           | None                                                                |                                                                                                                                                                    |
| [number] posX         | None                                                                | some class trees have a global offset                                                                                                                              |
| [number] posY         | None                                                                | some class trees have a global offset                                                                                                                              |
| [number] type         | None                                                                | 0: single, 1: Tiered, 2: Selection                                                                                                                                 |
| [number] maxRanks     | None                                                                |                                                                                                                                                                    |
| [number] flags        | None                                                                | &1: ShowMultipleIcons                                                                                                                                              |
| [table] groupIDs      | None                                                                | list of [number] groupIDs                                                                                                                                          |
| [table] visibleEdges  | isActive field is missing, the order does not always match C_Traits | list of [table] visibleEdges                                                                                                                                       |
| [table] conditionIDs  | None                                                                | list of [number] conditionIDs                                                                                                                                      |
| [table] entryIDs      | None                                                                | list of [number] entryIDs; generally, choice nodes will have 2, otherwise there's just 1                                                                           |
| [table] specInfo      | Lib-only field                                                      | table of [number] [specID](https://warcraft.wiki.gg/wiki/SpecializationID) = [table] list of conditionTypes; specID 0 means global; see Enum.TraitConditionType |
| [boolean] isClassNode | Lib-only field                                                      | whether the node is part of the class tree or spec tree                                                                                                            |

##### visibleEdges
| Field                | Differences from C_Traits | Extra info                                                                                                                                               |
|----------------------|---------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| [number] type        | None                      | 0: VisualOnly, 1: DeprecatedRankConnection, 2: SufficientForAvailability, 3: RequiredForAvailability, 4: MutuallyExclusive, 5: DeprecatedSelectionOption |
| [number] visualStyle | None                      | 0: None, 1: Straight                                                                                                                                     |
| [number] targetNode  | None                      | TraitNodeID                                                                                                                                              |
#### Example
```lua
local LibTalentTree = LibStub("LibTalentTree-1.0");
local treeID = LibTalentTree:GetClassTreeID('PALADIN');
local nodes = C_Traits.GetTreeNodes(treeID);
local configID = C_ClassTalents.GetActiveConfigID();
for _, nodeID in ipairs(nodes) do
    local nodeInfo = LibTalentTree:GetLibNodeInfo(nodeID);
    local entryInfo = C_Traits.GetEntryInfo(configID, nodeInfo.entryIDs[1]);
end
```


### GetEntryInfo
Get the entry info for a node entry
#### Syntax
```
entryInfo = LibTalentTree:GetEntryInfo(entryID)
entryInfo = LibTalentTree:GetEntryInfo(treeID, entryID)
```
#### Arguments
* [number] entryID - The TraitEntryID of the node entry you want to get the info for.

For backwards compatibility, the following syntax is also supported:
* [number] treeID - The TraitTreeID of the tree you want to get the node entry info for.
* [number] entryID - The TraitEntryID of the node entry you want to get the info for.
#### Returns
* [table|nil] entryInfo, nil if not found
##### entryInfo
| Field                 | Differences from C_Traits         | Extra info                                                        |
|-----------------------|-----------------------------------|-------------------------------------------------------------------|
| [number] definitionID | None                              |                                                                   |
| [number] type         | None                              | see Enum.TraitNodeEntryType                                       |
| [number] maxRanks     | None                              |                                                                   |
| [boolean] isAvailable | LibTalentTree always returns true |                                                                   |
| [table] conditionIDs  | LibTalentTree always returns {}   | talent node entries generally have no conditions attached to them |
#### Example
```lua
local LibTalentTree = LibStub("LibTalentTree-1.0");
local entryInfo = LibTalentTree:GetEntryInfo(123);
local definitionInfo = entryInfo and C_Traits.GetDefinitionInfo(entryInfo.definitionID);
local spellID = definitionInfo and definitionInfo.spellID;
```


### GetTreeIDForNode
Get the TreeID for a node
#### Syntax
`treeID = LibTalentTree:GetTreeIDForNode(nodeID)`
#### Arguments
* [number] nodeID - The TraitNodeID of the node you want to get the TraitTreeID for.
#### Returns
* [number|nil] treeID - TraitTreeID for the node, nil if not found.


### GetTreeIDForEntry
Get the TreeID for a node entry
#### Syntax
`treeID = LibTalentTree:GetTreeIDForEntry(entryID)`
#### Arguments
* [number] entryID - The TraitEntryID of the node entry you want to get the TraitTreeID for.
#### Returns
* [number|nil] treeID - TraitTreeID for the node entry, nil if not found.


### GetClassTreeID
Get the TreeID for a class
#### Syntax
`treeID = LibTalentTree:GetClassTreeID(classID | classFileName)`
#### Arguments
* [number] classID - The [ClassID](https://warcraft.wiki.gg/wiki/ClassID) of the class you want to get the TraitTreeID for.
* [string] classFile - Locale-independent name, e.g. `"WARRIOR"`.
#### Returns
* [number|nil] treeID - TraitTreeID for the class' talent tree, nil for invalid arguments.
#### Example
```lua
local LibTalentTree = LibStub("LibTalentTree-1.0")
-- the following 2 lines are equivalent
local treeID = LibTalentTree:GetClassTreeID(2)
local treeID = LibTalentTree:GetClassTreeID('PALADIN')
local nodes = C_Traits.GetTreeNodes(treeID)
```


### GetClassIDByTreeID
Get the ClassID for a tree
#### Syntax
`classID = LibTalentTree:GetClassIDByTreeID(treeID)`
#### Arguments
* [number] treeID - The TraitTreeID of the tree you want to get the ClassID for.
#### Returns
* [number|nil] classID - [ClassID](https://warcraft.wiki.gg/wiki/ClassID) for the tree, nil if not found.


### IsNodeVisibleForSpec
Get node visibility
#### Syntax
`isVisible = LibTalentTree:IsNodeVisibleForSpec(specID, nodeID)`
#### Arguments
* [number] specID - [SpecializationID](https://warcraft.wiki.gg/wiki/SpecializationID)
* [number] nodeID - TraitNodeID
#### Returns
* [boolean] isVisible - Whether the node is visible for the given spec.
#### Example
```lua
local LibTalentTree = LibStub("LibTalentTree-1.0")
local isVisible = LibTalentTree:IsNodeVisibleForSpec(65, 12345)
```


### IsNodeGrantedForSpec
Check if a node is granted by default
#### Syntax
`isGranted = LibTalentTree:IsNodeGrantedForSpec(specID, nodeID)`
#### Arguments
* [number] specID - [SpecializationID](https://warcraft.wiki.gg/wiki/SpecializationID)
* [number] nodeID - TraitNodeID
#### Returns
* [boolean] isGranted - Whether the node is granted by default for the given spec.
#### Example
```lua
local LibTalentTree = LibStub("LibTalentTree-1.0")
local isGranted = LibTalentTree:IsNodeGrantedForSpec(65, 12345)
```


### GetNodePosition
Returns the x / y position of a node. Note that some trees have a global offset.
#### Syntax
```
posX, posY = LibTalentTree:GetNodePosition(nodeID)
posX, posY = LibTalentTree:GetNodePosition(treeID, nodeID)
```
#### Arguments
* [number] nodeID - TraitNodeID

For backwards compatibility, the following syntax is also supported:
* [number] treeID - TraitTreeID
* [number] nodeID - TraitNodeID
#### Returns
* [number|nil] posX - X position of the node
* [number|nil] posY - Y position of the node
#### Example
```lua
local LibTalentTree = LibStub("LibTalentTree-1.0")
local posX, posY = LibTalentTree:GetNodePosition(12345)
```


### GetNodeGridPosition
Returns an abstraction of the node positions into a grid of columns and rows.\
Some specs may have nodes that sit between 2 columns, these columns end in ".5". This happens for example in the Druid and Demon Hunter trees.\
\
The top row is 1, the bottom row is 10\
The first class column is 1, the last class column is 9\
The first spec column is 10
#### Syntax
```
column, row = LibTalentTree:GetNodeGridPosition(nodeID)
column, row = LibTalentTree:GetNodeGridPosition(treeID, nodeID)
```
#### Arguments
* [number] nodeID - TraitNodeID

For backwards compatibility, the following syntax is also supported:
* [number] treeID - TraitTreeID
* [number] nodeID - TraitNodeID
#### Returns
* [number|nil] column - Column of the node, nil if not found. Can be a decimal with .5 for nodes that sit between 2 columns.
* [number|nil] row - Row of the node, nil if not found
#### Example
```lua
local LibTalentTree = LibStub("LibTalentTree-1.0")
local column, row = LibTalentTree:GetNodeGridPosition(12345)
```


### IsClassNode
Check if a node is part of the class or spec tree
#### Syntax
```
isClassNode = LibTalentTree:IsClassNode(nodeID)
isClassNode = LibTalentTree:IsClassNode(treeID, nodeID)
```
#### Arguments
* [number] nodeID - TraitNodeID

For backwards compatibility, the following syntax is also supported:
* [number] treeID - TraitTreeID
* [number] nodeID - TraitNodeID
#### Returns
* [boolean|nil] isClassNode - Whether the node is part of the class tree, or the spec tree.
#### Example
```lua
local LibTalentTree = LibStub("LibTalentTree-1.0")
local isClassNode = LibTalentTree:IsClassNode(12345)
```


### GetNodeEdges
#### Syntax
```
edges = LibTalentTree:GetNodeEdges(nodeID)
edges = LibTalentTree:GetNodeEdges(treeID, nodeID)
```
#### Arguments
* [number] nodeID - TraitNodeID

For backwards compatibility, the following syntax is also supported:
* [number] treeID - TraitTreeID
* [number] nodeID - TraitNodeID
#### Returns
* [table] edges - A list of visibleEdges.
##### visibleEdges
| Field                | Differences from C_Traits | Extra info                                                                                                                                               |
|----------------------|---------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| [number] type        | None                      | 0: VisualOnly, 1: DeprecatedRankConnection, 2: SufficientForAvailability, 3: RequiredForAvailability, 4: MutuallyExclusive, 5: DeprecatedSelectionOption |
| [number] visualStyle | None                      | 0: None, 1: Straight                                                                                                                                     |
| [number] targetNode  | None                      | TraitNodeID                                                                                                                                              |

#### Example
```lua
local LibTalentTree = LibStub("LibTalentTree-1.0")
local edges = LibTalentTree:GetNodeEdges(12345)
for _, edge in ipairs(edges) do
  print(edge.targetNode)
end
```


### GetGates
Returns a list of gates for a given spec.
The data is similar to C_Traits.GetTreeInfo and C_Traits.GetConditionInfo, essentially aiming to supplement both APIs.
#### Syntax
`gates = LibTalentTree:GetGates(specID)`
#### Arguments
* [number] specID - The [specID](https://warcraft.wiki.gg/wiki/SpecializationID) of the spec you want to get the gates for.
#### Returns
* [table] gates - list of [table] gateInfo - the order is not guaranteed to be the same as C_Traits.GetTreeInfo, but is will always be sorted by spentAmountRequired
##### gateInfo
| Field                        | Differences from C_Traits                                                                                  | Extra info                                                                                                     |
|------------------------------|------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
| [number] topLeftNodeID       | (TraitGateInfo) None                                                                                       | The UI uses this node to anchor the Gate UI element to                                                         |
| [number] conditionID         | (TraitGateInfo) None                                                                                       |                                                                                                                |
| [number] spentAmountRequired | (TraitCondInfo) Always gives the **total** spending required, rather than [ totalRequired - alreadySpent ] | Especially useful for finding out the real gate cost when you're already spend points in your character's tree |
| [number] traitCurrencyID     | (TraitCondInfo) None                                                                                       |                                                                                                                |


### IsCompatible
Returns whether the library is compatible with the current game version.
This is generally always true for Retail, and always false for Classic.
#### Syntax
` [boolean] isCompatible = LibTalentTree:IsCompatible()`
#### Returns
* [boolean] isCompatible - Whether the library is compatible with the current game version.
