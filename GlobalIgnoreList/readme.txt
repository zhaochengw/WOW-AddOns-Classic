== GLOBAL IGNORE LIST AND SPAM FILTER

Global Ignore List is a quality of life addon that provides a greatly enhanced (unlimited) character ignore system, and has a robust chat/spam filtering engine to eliminate gold sellers/spammers, guild recruitment, community recruitment, annoying trends like Thunderfury, non-latin text, and more. All of these can be enabled or disabled as you please or you can even create your own:

Global Ignore also gives you full access to its chat filtering engine so you can create your own filters whether they are as simple as a single word or complex statements that requirement boolean evaluations.

* Unlimited ignore list size, synchronized across all characters, factions, and servers
* Account wide ignore system
* Ability to ignore players, NPCs, monsters, and entire servers
* Ability to set notes for ignored entries, and expiration times for automatic removal from ignore
* Chat spam filtering with robust chat spam filter editor, allowing players to create their own custom filters.
* Default spam filters catch the majority of gold sellers and spammers (defaults for English servers) including gold spam, Guild recruitment, community invites, Asian languages, political spam, and so on.
* Warnings to prevent inviting or being a member of a group with a player on your ignore list
* Automatic decline of duels and party invites from ignored players
* Greatly improved UI over the default
* Enhancements to existing UI such as being able to ignore by right clicking target or from raid frames
* Small and efficient created with pure WoW API only (no libs like ACE)

Type /gi in game for chat help, or open your ignore list for features and options

**NOTES, ISSUES AND FREQUENT QUESTIONS:**

* Unfortunately I cannot add guild-wide ignores.  Blizzard does not supply guild information with the chat data and they've limited the ability for addons to collect their own data on guilds (Census addons were causing server lag).  If I can find a way to do it properly in the future I will try to add it in.

* There is a bug where WoW sometimes reports all members of the ignore list as "Unknown" during login which prevents GIL from synchronizing your character ignore lists. If this happens, GIL will print a message duing login and then attempt to synchronize when you open the GIL UI. You can also force a sync by a chat command line.

* There is an issue where WoW reports the wrong server name when ignoring someone from right clicking chat. When a character with no server name is reported, GIL will search the members of your current raid, battleground, instance, and so on to try to find someone with that name. It will check your chat tab history and search for any reference of the name in order to determine the server. If no data is found during this search, GIL will ultimately assume the person is on your server.

* Account wide ignore only works for up to 50 accounts per character due to a WoW limitation. GIL uses logic to select the "best" 50 players on a per-character basis, in an attempt to maximize usefulness of account wide ignore limitations. No other ignore addon can do this. This is significant because it prevents you from messages, duel requests, being grouped in a dungeon, BG, or LFR queue system for not only their main character but for their alts that you don't know about too. GIL will also perform all of those same checks and warnings for non-account wide ignore.

----


== HOW TO CREATE SPAM FILTERS

GIL has a series of default spam filters that will be periodically updated as
new annoying chat spam is encountered, but it also allows you to create your
own custom chat filters! Filters can be edited by double clicking them, or
added and deleted with UI buttons.

Each chat filter consists of a series of tags which define what to "search" for
in each chat message. When one of these tags is "TRUE" in a chat message, then
the message will be filtered. The filter system also allows for built in logic
to create complex filters, but more on that later.

Tags are enclosed within [] characters and can be used to filter items, spells,
achievements, word matches, partial word matches, and any link. The following
tags are available to perform each of those types of filtering:

**[word]**

The word tag looks for a whole word within the chat message. The word to search
for must be provided within the tag with an equals sign such as: "[word=anal]".

Word and partial word matches are case insensitive, so ANAL anal and AnAL will
all match the tag shown above.

**[contains]**

The contains tag is similar to the word filter, but performs a partial match of
a word instead of a whole word match. If for example, you see people spamming
analanalanal [Thunderfury], then you might want to add a tag with something like
[contains=analan] so that it will catch people who do that sort of spam.

**[link]**

The link tag matches if the chat contains any linked content at all, which can
mean a spell, item, achievement, etc.

**[spell]**

The spell tag allows one to filter out specific spell links or all spell links
from chat. If the spell tag exists with no equals, then it will filter when
the message contains ANY spell link at all. For example "[spell]". If the
equals sign is provided and followed by a Spell ID, then only that specific
spell ID will be filtered. Such as "[spell=17]" would filter any message with
the Power Word Shield spell linked in it.

**[item]**

The item tag allows one to filter out all item links or specific item links.
This tag works in the same way that the spell tag does. For example "[item]"
will filter if any item at all is linked, whereas "[item=19019]" would filter
any chat message that contained a link for Thunderfury.

**[talent]**

The talent tag works just the same as the spell and item tags.

**[achievement]**

The achievement tag works just the same as the spell and item tags. For the
sake of trying to keep this short and refer you to the item and spell examples
above.

**[pet]**

The pet tag works just the same as the spell and item tags. For the
sake of trying to keep this short and refer you to the item and spell examples
above.

**[icon]**

The icon tag allows filtering based on raid icons in the chat text. The
"[icon]" tag by itself will result in a filtered message if the chat message
has any icon at all in the text. A number can also be provided to filter
based on if a message has a specific number or greater of raid icons. For
example "[icon=3]" would filter if the message has 3 or more raid icons in
it.

**[community]**

This tag allows filters to be created to filter out community Join requests.
No other data is used for this tag; If you wish to filter anything that
contains a Join request, simply include this tag

**[trade]**

This tag allows filters to be created to filter out tradeskill links.
No other data is used for this tag; If you wish to filter anything that
contains a tradeskill link, simply include this tag.

**[journal]**

This tag allows filters to be created to filter out dungeon journal links.
No other data is used for this tag; If you wish to filter anything that
contains a journal link, simply include this tag.

**[mount]**

This tag allows filters to be created to filter out mount links.
No other data is used for this tag; If you wish to filter anything that
contains a mount link, simply include this tag.

**[guild]**

This tag allows filters to be created to filter out guild links.
No other data is used for this tag; If you wish to filter anything that
contains a guild link, simply include this tag.

**[outfit]**

This tag allows filters to be created to filter out outfit links.
No other data is used for this tag; If you wish to filter anything that
contains an outfit link, simply include this tag.

**[nonlatin]**

This tag allows filters messages that contain Chinese/Japanese/Korean characters
for those who play on English servers that have a strong native Asian speaking
community

**[words]**

This tag allows filters to test that a line of text contains only a specific number
of words.  For example: [words=2] would be true only if the text contained only two
words.

**[channel]**

This tag allows filters to test that a line of text sourced from a specific channel
number.  For example, channel 1 would be zone, 2 would be city/trade, and so on.  If
you wanted a filter to apply only to trade chat you could do "[channel=2]" somewhere
in your filter.

**[chname=name]**

This tag allows filters to test that a line of text sourced from a specific channel
name.  When the text sourced from a channel that does not have a chat channel name
GIL will set the name to a value that corresponds to the type of chat it is, as
follows:  say, yell, whisper, officer, guild, party, raid, raid_leader,
instance_chat, instance_chat_leader, battleground, battleground_leader.

As with other filter tags paces must be escaped with the backslash character. For
example to create a filter that only applies to Trade chat you would use a tag with
the spaces escaped: [chname=Trade\ -\ City].  If want to apply a filter only to guild
chat you would use [chname=guild].

The "Never filter party, guild, yourself, private messages" options still apply here,
so if those are enabled even a filter with a channel name will not apply to those
channels as they are configured to never be filtered.

**SPECIAL CHARACTERS IN FILTERS**

Spaces can be used in a [Contains] tag by escaping the character using a forward
slash before the space (\).  Other characters can be escaped the same
way: parenthesis (), brackets [], and backslash.  For example:

  [contains=filter\ this]

Here are some other examples:

   \( would mean (
   \) would mean )
   \[ would mean [
   \] would mean ]
   \\ would mean \

**USING LOGICAL EVALUATION:**

Chat filters can include some logical evaluations by enclosing tags within
parenthesis and using boolean "and or not" keywords. This is really what can
tie everything together and allow for some pretty nice filters to be created.

For example, here is the default "Anal" spam filter which comes with GIL:

([word=anal] or [contains=analan]) and [link]

The parenthesis and the or keyword allow the filter to specify that if the
chat message has a complete word match of "anal" OR it contains a partial
word match with "analan" AND the chat message contains any link meaning
any item spell or achievement, then the filter is TRUE and the message
will be filtered by GIL.

=> CHAT COMMANDS

The following commands are accessible by typing /gignore or /gi in the chat box:

/gi - Show a list of available chat commands

/gi gui - Open GIL ignore list GUI

/gi list [days] - Show a list of all players on the global ignore list, along with their server, faction, and the date they were added to the list.  An optional number of days can be added if you'd like to only show people who have been on the list for [days] or more days

/gi clear - Clear the global ignore list.  Please understand that clearing this list means that you are clearing everything on all characters that you've previous logged in as!  You will need to provide a follow up confirmation command before the clear will work.  This is a tricky command and most likely needs to be done on every character you have otherwise GIL will keep trying to add/remove people to the list when you login to other characters.

/gi add player_name - This provides a way to add a player to the list, but the Blizzard UI and /ignore works too!  You can optionally add a reason as well.  If a server name is involved all spaces should be removed.  For example: /gi add mytoon-Area52 this is an ignore reason

/gi ignore player_name - This provides a way to add a player to the list, but the Blizzard UI and /ignore works too!  You can optionally add a reason as well.  If a server name is involved all spaces should be removed.  For example: /gi add mytoon-Area52 this is an ignore reason

/gi remove player_name - This provides a way to remove a player from the list, but the Blizzard UI and /unignore works too!  GIL also applies a number to each person on the list (see the list function) and the number can be used to remove too.

/gi delete player_name - This provides a way to remove a player from the list, but the Blizzard UI and /unignore works too!  GIL also applies a number to each person on the list (see the list function) and the number can be used to remove too.

/gi filter on|off - If on, GIL will check all incoming chat messages and compare them to the ignore list.  If a message is found from someone on the ignore list, the chat message will be filtered.  This provides a "simulated" ignore effect if the ignore list grows beyond 50 characters.

/gi showmsg on|off - GIL will synchronize the list upon logging into a character, and any actions taken will be printed into the chat window unless this option is turned off.  For example, if a person is added or removed from the ignore list a message will be printed in the chat.

/gi sameserver on|off - Synchronize only with same-server characters.  If on, only characters on the same server and faction will share ignore lists.  If off, characters on the same faction but on different servers will share ignore lists.  Remember!  There is a limit of 50 ignored players, so using cross-server ignore lists can really make you hit the limit quickly if you have an itchy ignore finger!

/gi prune days - This will remove all persons from the list that have been on the list more than [days] days.  For example "/gi prune 90" would remove anyone who has been ignored for 90 or more days.  You will need to provide a follow up confirmation command before the clear will work

/gi expire character days - Sets expiration for [character] after a number of [days]

/gi npc npcname - Toggle NPC ignore for npcname

/gi server servername - Add or remove a whole-server ignore
