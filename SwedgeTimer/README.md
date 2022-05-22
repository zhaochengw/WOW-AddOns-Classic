# swedgetimer
Retribution Paladin seal twisting swing timer for WoW Classic TBC.
Based on some code and assets from the WeaponSwingTimer addon.

![](https://i.imgur.com/qvdZef9.png)

## What is SwedgeTimer?

SwedgeTimer is a standalone swing timer bar to help Retribution Paladins seal twist more effectively.
It is not a WeakAura, it is built from the ground up in lua, and does not use the WeakAura API in any way.

SwedgeTimer replicates all the standard features of the current WeakAura state-of-the-art, including the GCD overlay, timing markers, and colour coding.

It does not aim to replace any of the other components of a typical Ret UI or heads-up-display; it is simply a moderately configurable swing timer bar at present, meant to be used in conjunction with more conventional weak auras for Retribution paladins like seal indicators and cooldown/proc trackers.

## Why use this over a WeakAura swing timer?

There are some advantages in using the SwedgeTimer addon over a traditional weak aura bar.

### Seal of the Crusader snapshotting

Seal of the Crusader uses haste snapshotting to prevent taking advantage of the shortened attack timer by switching to (or from) another seal mid-swing.
This has been brought to the attention of the weak aura developers by members of the ret community but they refuse to incorporate a fix.
As such, rets commonly use a patched version of weak auras, with the patched `generictrigger.lua` file being available on the Light Club and other paladin discords.

SwedgeTimer handles Seal of the Crusader haste snapshotting implicitly, meaning no need to manually patch weak auras after every release, and no need for the patch maintainers to ensure compatibility with new WeakAura versions.

### Accurate in Retribution edge cases

Traditional WeakAura swing timers do not recognise that the player's swing timer is reset by some of our abilities.
The most notable of these is Repentance, a crucial ability in PvP play.
Players must guess themselves when a swing is up after casting Repentence, impacting the player's ability to promptly re-open with a twist following a cast.

SwedgeTimer correctly resets the paladin's swing timer upon any relevant ability cast. These include:
- Repentance
- Holy Wrath
- Hammer of Justice

### Customisable

WeakAuras allows for extensive customisation of the appearance of a given WA, but there is no way to easily persist a player's customisation when the WA is updated.
Instead a player must re-implement any cosmetic changes each time their WA of choice is updated.

SwedgeTimer features in-built and persistent customisation options.
At present, the bar width, bar height, and font size are all customisable in the built-in settings panel.

![](https://i.imgur.com/6LIzzDK.png)

In a future update, font and bar texture customisation will also be implemented.

### Lag Detection

At high haste, many rets will be familiar with the experience of attempting a twist that your swing timer indicates that you can make, only to end up landing a Seal of Command swing due to lag, with the Seal of Blood cast taking you out of SoC and denying your ability to twist.

SwedgeTimer features an experimental lag detection feature, whereby the roundtrip latency to the world server is cross-checked against the time window for a twist to be made at the end of a close swing.
When the addon detects that lag is likely to push the Seal of Blood cast into the next swing, the bar turns yellow.
This indicates to the player that they should either stopattack to land the twist, or to instead filler and ride the SoC swing into a twist on the next attempt, optimising dps output.

This feature works best on connections where the latency is relatively stable, as it relies on the WoW API's `GetNetStats` endpoint which only updates once every 30s.
More experimental methods of maintaining a more up-to-date measurement of the lag are being looked into, so stay tuned.

Due to the way the server batches actions from the client, this is not a hard guarantee that your twist attempt will be possible or impossible.
You may still get lucky and land a miracle late twist, or miss one that seemed a sure thing.
However, testing has shown a high rate of prediction for missed twists, with very few false positives being identified.

## Install Instructions

Simply download the latest release zip file and extract it to your adddons directory.

## Usage Instructions

SwedgeTimer's config can be opened with the slashcommand `\st` in the chat box.
The bar itself can be clicked and dragged, and then locked inplace when the player is happy with the positioning via. the config menu.

The lag detection settings are experimental, but to ensure the best result a player may wish to experiment with the following options:
- "Lag Multiplier" is the value the world latency roundtrip can be multiplied by, defaulting to 1.5. In internal testing, this value was found to result in the most consistent prediction of impossible twists that the client and traditional weak aura bars believed possible.
- "Lag Threshold" is a flat value of latency the player can add, in seconds, defaulting to 0.0. This might be useful in fine tuning for some player's connections to the game world.

