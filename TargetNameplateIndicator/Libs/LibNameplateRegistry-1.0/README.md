**LibNameplateRegistry-1.0** is an embeddable library providing an abstraction layer for tracking and querying Blizzard's Nameplate frames with ease and efficiency.

Features:
---------
- Links GUID to nameplates (now reliably since WoW 7)
- Provides [callbacks][callbacks] to track nameplate appearance and disappearance
- Caches and maintain nameplates' related data
- Provides a simple [API][api] to get information about nameplate frames

Do not hesitate to [request features via WoWAce's ticket system][tickets] or using
[GitHub's issue tracker][issues].


* * * * *

To implement **LibNameplateRegistry-1.0** in your add-on:

- Add the following line in your .pkgemeta file:

    `Libs/LibNameplateRegistry-1.0: git://git.wowace.com/wow/libnameplateregistry-1-0/mainline.git/LibNameplateRegistry-1.0`

- Add LibNameplateRegistry-1.0 to the **OptionalDeps** and **X-embeds** fields of your add-on's TOC file. Example:

    `## OptionalDeps: Ace3, LibNameplateRegistry-1.0`

    `## X-Embeds: Ace3, LibNameplateRegistry-1.0`

- Add the following line in your embeds.xml file:

    `<Include file="Libs\LibNameplateRegistry-1.0\LibNameplateRegistry-1.0.xml" />`

- Finally, check the [API documentation][api] which provides a fully working example and [callbacks details][callbacks].



For general discussion about this library, use the [dedicated thread][forum] on WoWAce.com forum.



Bitcoin donation address: [**12wJu3fX2HyNttg4bvsTmpBf66bzFqwVNy**](bitcoin:12wJu3fX2HyNttg4bvsTmpBf66bzFqwVNy)

![stats](https://www.2072productions.com/to/libnameplateregistrystat.gif)

[tickets]: https://www.wowace.com/addons/libnameplateregistry-1-0/tickets/
[issues]: https://github.com/2072/LibNameplateRegistry-1.0/issues
[api]: https://www.wowace.com/projects/libnameplateregistry-1-0/pages/api
[callbacks]: https://www.wowace.com/projects/libnameplateregistry-1-0/pages/callbacks
[HHTD]: https://www.wowace.com/projects/h-h-t-d
[forum]: https://forums.wowace.com/showthread.php?t=20676

