Callbacks details
=================


See the [API documentation][api] for a complete example and details on how to register to these callbacks.

The `plateData` table
---------------------

Several of the following callbacks have a *plateData* argument. This argument
is a table containing the following fields:

- **.unitToken**: The unitToken of the nameplate's associated unit (added in WoW 7.0).
- **.name**: The name of the nameplate's associated unit.
- **.reaction**: The reaction of the unit as returned by the [:GetPlateReaction() API](https://www.wowace.com/projects/libnameplateregistry-1-0/pages/api#w-addon-get-plate-reaction-plate-frame)
- **.type**: The type of the nameplate as returned by the [:GetPlateType() API](https://www.wowace.com/projects/libnameplateregistry-1-0/pages/api#w-addon-get-plate-type-plate-frame)
- **.GUID**: The GUID of the nameplate's associated unit **which may be nil if it's not been found and cached already.**

This *plateData* argument is a direct reference to the library internal
registry. It's safe to use when inside a callback's firing scope but in other
cases **you must use the related API** to get accurate and up to date information.

**Do not modify *plateData* content in any way**, it's meant to be read only.
Modifying it or adding fields is not allowed and may break the library current
and futur releases.

* * * * * * * *

Main callbacks
--------------

Most of your code related to nameplates will rely on the following callbacks.

### `LNR_ON_NEW_PLATE`

*Fires when a nameplate appears on screen*

**Args:**

- *callbackName*: The name of the callback
- *plateFrame*: The nameplate's root frame
- *plateData*: The up to date data associated to the nameplate (see the plateData table details above)

* * * * * * * *

### `LNR_ON_RECYCLE_PLATE`

*Fires when a nameplate disappears from the screen.*

As you may have noticed, this callback contains the word 'recycle'. It's
important to understand that a nameplate isn't tied to a single unit but is
reused to display other units.

**Args:**

- *callbackName*: The name of the callback
- *plateFrame*: The nameplate's root frame
- *plateData*: The up to date data associated to the nameplate (see the plateData table details above)

* * * * * * * *

### `LNR_ON_GUID_FOUND`

*Fires when a GUID is successfully linked to a nameplate*

**NOTE:** This callback will *not fire* in normal cases as it is found directly
on nameplate creation since WoW 7.0.

The library detects these changes in the nameplates and is able to precisely
link nameplates to unit GUIDs.

**Args:**

- *callbackName*: The name of the callback
- *plateFrame*: The root frame of the nameplate whose GUID was found
- *GUID*: the GUID that was discovered
- *methodUsed*: either 'mouseover' or 'target'

* * * * * * * *

### `LNR_ON_TARGET_PLATE_ON_SCREEN`

*Fires whenever a targeted unit's nameplate becomes visible or when a currently
displayed nameplate is targeted*

**Args:**

- *callbackName*: The name of the callback
- *plateFrame*: The root frame of the nameplate
- *plateData*: The up to date data associated to the nameplate (see the plateData table details above)

* * * * * * * *


Diagnostic callbacks
--------------------

These are not necessary to register to use the library but are very useful to
diagnose issues your users could face.
These callbacks allows you to react to incompatibility situations and inform
your users accurately on what's happening.

### `LNR_ERROR_FATAL_INCOMPATIBILITY`

*Fires when LibNameplateRegistry internal diagnostics detect something
terribly wrong*

When this callback fires, a Lua error is also raised and the library
self-destructs (through a precisely controlled implosion without causing any
collateral damages).

This usually happens when inconsistencies are detected while tracking nameplate's frames.

When not in combat LibNameplateRegistry checks its tracking consistency every 10 seconds.

**Args:**

- *callbackName*: The name of the callback
- *incompatibilityType*: A short text string describing the problem:

    - *"TRACKING: OnHide"* or *"TRACKING: OnShow"*: LibNameplateRegistry missed several nameplate show and hide events.
    - *"TRACKING: OnShow missed"* a nameplate is hidden but was never shown...

* * * * * * * *

### `LNR_DEBUG`

*Fires at every 'Debug()' call in LibNameplateRegistry*

Useful when developing, you should register this callback before `LNR_ON_NEW_PLATE`.


**Args:**

- *callbackName*: The name of the callback
- *level*: The level of debugging (1 to 4 where 1 is an error, 2 a warning, 3 and 4 informational)
- *libMinor*: The MINOR revision of LibNameplateRegistry
- *...*: unlimited list of debug arguments that can be past to print();


[api]: https://www.wowace.com/projects/libnameplateregistry-1-0/pages/api
