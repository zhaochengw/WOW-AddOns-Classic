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

### Quick reference
Most of the information returned matches the in-game C_Traits API, which has up-to-date documentation on [wiki C_Traits](https://warcraft.wiki.gg/wiki/Category:API_namespaces/C_Traits).
 * `nodeInfo = LibTalentTree:GetNodeInfo(nodeId)` [#GetNodeInfo](#getnodeinfo)
   * Returns a table containing all the information for a given node, enriched with C_Traits data if available.
 * `nodeInfo = LibTalentTree:GetLibNodeInfo(nodeId)` [#GetLibNodeInfo](#getlibnodeinfo)
   * Returns a table containing all the information for a given node, without any C_Traits data.
 * `entryInfo = LibTalentTree:GetEntryInfo(entryId)` [#GetEntryInfo](#getentryinfo)
   * Returns a table containing all the information for a given node entry.
 * `treeId = LibTalentTree:GetTreeIdForNode(nodeId)` [#GetTreeIdForNode](#gettreeidfornode)
   * Returns the treeId for a given node.
 * `treeId = LibTalentTree:GetTreeIdForEntry(entryId)` [#GetTreeIdForEntry](#gettreeidforentry)
   * Returns the treeId for a given NodeEntry.
 * `treeId = LibTalentTree:GetClassTreeId(classId | classFileName)` [#GetClassTreeId](#getclasstreeid)
   * Returns the treeId for a given class.
 * `classId = LibTalentTree:GetClassIdByTreeId(treeId)` [#GetClassIdByTreeId](#getclassidbytreeid)
   * Returns the classId for a given tree.
 * `isVisible = LibTalentTree:IsNodeVisibleForSpec(specId, nodeId)` [#IsNodeVisibleForSpec](#isnodevisibleforspec)
   * Returns whether or not a node is visible for a given spec.
 * `isGranted = LibTalentTree:IsNodeGrantedForSpec(specId, nodeId)` [#IsNodeGrantedForSpec](#isnodegrantedforspec)
   * Returns whether or not a node is granted by default for a given spec.
 * `posX, posY = LibTalentTree:GetNodePosition(nodeId)` [#GetNodePosition](#getnodeposition)
   * Returns the position of a node in a given tree.
 * `column, row = LibTalentTree:GetNodeGridPosition(nodeId)` [#GetNodeGridPosition](#getnodegridposition)
   * Returns an abstracted grid position of a node in a given tree.
 * `isClassNode = LibTalentTree:IsClassNode(nodeId)` [#IsClassNode](#isclassnode)
   * Returns whether a node is a class node, or a spec node.
 * `edges = LibTalentTree:GetNodeEdges(nodeId)` [#GetNodeEdges](#getnodeedges)
   * Returns a list of edges for a given node.
 * `gates = LibTalentTree:GetGates(specId)` [#GetGates](#getgates)
   * Returns a list of gates for a given spec.
 * `isCompatible = LibTalentTree:IsCompatible()` [#IsCompatible](#iscompatible)
   * Returns the library is compatible with the current game version.

### GetNodeInfo
if available, C_Traits nodeInfo is used instead, and specInfo is mixed in.
If C_Traits nodeInfo returns a zeroed out table, the table described below is mixed in.
#### Syntax
```
nodeInfo = LibTalentTree:GetNodeInfo(nodeId)
nodeInfo = LibTalentTree:GetNodeInfo(treeId, nodeId)
```
#### Arguments
* [number] nodeId - The TraitNodeID of the node you want to get the info for.

For backwards compatibility, the following syntax is also supported: 
* [number] treeId - TraitTreeID
* [number] nodeId - The TraitNodeID of the node you want to get the info for.
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
| [table] specInfo      | Lib-only field                                                      | table of [number] [specId](https://warcraft.wiki.gg/wiki/SpecializationID) = [table] list of conditionTypes; specId 0 means global; see Enum.TraitConditionType |
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
local treeId = LibTalentTree:GetClassTreeId('PALADIN');
local nodes = C_Traits.GetTreeNodes(treeId);
local configId = C_ClassTalents.GetActiveConfigID();
for _, nodeId in ipairs(nodes) do
    local nodeInfo = LibTalentTree:GetNodeInfo(nodeId);
    local entryInfo = C_Traits.GetEntryInfo(configId, nodeInfo.entryIDs[1]);
end
```


### GetLibNodeInfo
Get node info as stored in the library
#### Syntax
```
nodeInfo = LibTalentTree:GetLibNodeInfo(nodeId)
nodeInfo = LibTalentTree:GetLibNodeInfo(treeId, nodeId)
```
#### Arguments
* [number] nodeId - The TraitNodeID of the node you want to get the info for.

For backwards compatibility, the following syntax is also supported:
* [number] treeId - The TraitTreeID of the tree you want to get the node info for.
* [number] nodeId - The TraitNodeID of the node you want to get the info for.
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
| [table] specInfo      | Lib-only field                                                      | table of [number] [specId](https://warcraft.wiki.gg/wiki/SpecializationID) = [table] list of conditionTypes; specId 0 means global; see Enum.TraitConditionType |
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
local treeId = LibTalentTree:GetClassTreeId('PALADIN');
local nodes = C_Traits.GetTreeNodes(treeId);
local configId = C_ClassTalents.GetActiveConfigID();
for _, nodeId in ipairs(nodes) do
    local nodeInfo = LibTalentTree:GetLibNodeInfo(nodeId);
    local entryInfo = C_Traits.GetEntryInfo(configId, nodeInfo.entryIDs[1]);
end
```


### GetEntryInfo
Get the entry info for a node entry
#### Syntax
```
entryInfo = LibTalentTree:GetEntryInfo(entryId)
entryInfo = LibTalentTree:GetEntryInfo(treeId, entryId)
```
#### Arguments
* [number] entryId - The TraitEntryID of the node entry you want to get the info for.

For backwards compatibility, the following syntax is also supported:
* [number] treeId - The TraitTreeID of the tree you want to get the node entry info for.
* [number] entryId - The TraitEntryID of the node entry you want to get the info for.
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


### GetTreeIdForNode
Get the TreeId for a node
#### Syntax
`treeId = LibTalentTree:GetTreeIdForNode(nodeId)`
#### Arguments
* [number] nodeId - The TraitNodeID of the node you want to get the TraitTreeID for.
#### Returns
* [number|nil] treeId - TraitTreeID for the node, nil if not found.


### GetTreeIdForEntry
Get the TreeId for a node entry
#### Syntax
`treeId = LibTalentTree:GetTreeIdForEntry(entryId)`
#### Arguments
* [number] entryId - The TraitEntryID of the node entry you want to get the TraitTreeID for.
#### Returns
* [number|nil] treeId - TraitTreeID for the node entry, nil if not found.


### GetClassTreeId
Get the TreeId for a class
#### Syntax
`treeId = LibTalentTree:GetClassTreeId(classId | classFileName)`
#### Arguments
* [number] classId - The [ClassId](https://warcraft.wiki.gg/wiki/ClassId) of the class you want to get the TraitTreeID for.
* [string] classFile - Locale-independent name, e.g. `"WARRIOR"`.
#### Returns
* [number|nil] treeId - TraitTreeID for the class' talent tree, nil for invalid arguments.
#### Example
```lua
local LibTalentTree = LibStub("LibTalentTree-1.0")
-- the following 2 lines are equivalent
local treeId = LibTalentTree:GetClassTreeId(2)
local treeId = LibTalentTree:GetClassTreeId('PALADIN')
local nodes = C_Traits.GetTreeNodes(treeId)
```


### GetClassIdByTreeId
Get the ClassId for a tree
#### Syntax
`classId = LibTalentTree:GetClassIdByTreeId(treeId)`
#### Arguments
* [number] treeId - The TraitTreeID of the tree you want to get the ClassId for.
#### Returns
* [number|nil] classId - [ClassId](https://warcraft.wiki.gg/wiki/ClassId) for the tree, nil if not found.


### IsNodeVisibleForSpec
Get node visibility
#### Syntax
`isVisible = LibTalentTree:IsNodeVisibleForSpec(specId, nodeId)`
#### Arguments
* [number] specId - [SpecializationID](https://warcraft.wiki.gg/wiki/SpecializationID)
* [number] nodeId - TraitNodeID
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
`isGranted = LibTalentTree:IsNodeGrantedForSpec(specId, nodeId)`
#### Arguments
* [number] specId - [SpecializationID](https://warcraft.wiki.gg/wiki/SpecializationID)
* [number] nodeId - TraitNodeID
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
posX, posY = LibTalentTree:GetNodePosition(nodeId)
posX, posY = LibTalentTree:GetNodePosition(treeId, nodeId)
```
#### Arguments
* [number] nodeId - TraitNodeID

For backwards compatibility, the following syntax is also supported:
* [number] treeId - TraitTreeID
* [number] nodeId - TraitNodeID
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
column, row = LibTalentTree:GetNodeGridPosition(nodeId)
column, row = LibTalentTree:GetNodeGridPosition(treeId, nodeId)
```
#### Arguments
* [number] nodeId - TraitNodeID

For backwards compatibility, the following syntax is also supported:
* [number] treeId - TraitTreeID
* [number] nodeId - TraitNodeID
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
isClassNode = LibTalentTree:IsClassNode(nodeId)
isClassNode = LibTalentTree:IsClassNode(treeId, nodeId)
```
#### Arguments
* [number] nodeId - TraitNodeID

For backwards compatibility, the following syntax is also supported:
* [number] treeId - TraitTreeID
* [number] nodeId - TraitNodeID
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
edges = LibTalentTree:GetNodeEdges(nodeId)
edges = LibTalentTree:GetNodeEdges(treeId, nodeId)
```
#### Arguments
* [number] nodeId - TraitNodeID

For backwards compatibility, the following syntax is also supported:
* [number] treeId - TraitTreeID
* [number] nodeId - TraitNodeID
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
`gates = LibTalentTree:GetGates(specId)`
#### Arguments
* [number] specId - The [specId](https://warcraft.wiki.gg/wiki/SpecializationID) of the spec you want to get the gates for.
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
