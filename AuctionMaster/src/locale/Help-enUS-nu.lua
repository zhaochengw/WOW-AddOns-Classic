local L = LibStub("AceLocale-3.0"):NewLocale("AuctionMaster-Help", "enUS", true)
if (L) then
	
	-- "|r" is used to avoid the decimal point replacement with a comma

	L["BetaHeader"] = "<br/><p>|cffee4400Thank you for installing the beta/alpha version %s of AuctionMaster!|r Please report any errors you may encounter in the AuctionMaster forum on Curse or send a PM to the addon author Udorn. Thanks a lot for helping to improve the quality of this addon.</p><br/>"

	L["Help"] = true
	L["Documentation"] = true
	L["DocumentationStatus"] = "Documentation of AuctionMaster."
	L["DocumentationSectionStatus"] = "Single section of the the documentation."
	
	L["doc_1_title"] = "Introduction"
	L["doc_1"] = [[
	<h1>Introduction</h1>
	<p>AuctionMaster is a compact auction house tool for being able to sell items like the wind, scanning auctions for item statistics, searching for wanted items in the auction house, looking for good opportunities among the current auctions and displaying the statistics gathered so far in the tooltip of any item.</p>
<p>AuctionMaster was formerly named Vendor, which seemed to be a missleading name for the purpose of the addon.</p>]]

	L["doc_2_title"] = "Why another one?"
	L["doc_2"] = [[
	<h1>Why another auction addon?</h1>
	<p>There are already well known and established auction tools available. But I wasn't very comfortable with them. I wanted to have a tool which is very compact, which doesn't overstrain me in the tooltip with too much information. On the other side it should be ease in use and totally driven by gui elements.</p>

	<p>And last but not least I just had fun to learn many new things while programming it.</p>]]

	L["doc_3_title"] = "Compatibility"
	L["doc_3"] = [[
	<h1>Compatibility with other auction addons</h1>

	<p>AuctionMaster adds a new tab to the auction window. It does that as compatible as possible. This way some other addons, which also add new tabs to the auction window won't get disturbed. But there is no gurantee, that all other auction addons, modifying the auction frame, will be compatible with AuctionMaster. It depends on how cautious the addon author was.</p>]]

	L["doc_4_title"] = "Features"
	L["doc_4"] = [[
	<h1>Features</h1>

	<p>AuctionMaster comes in a single directory, without any other dependencies. The needed Ace2 libraries are already contained in the AuctionMaster installation directory.</p>

	<p>The following sections will explain some of the main features of AuctionMaster.</p>

	<h2>Using the UI</h2>

	<p>All UI elements of AuctionMaster do have a tooltip description. Just point to the button in question and the tooltip with a short description will appear.</p>

	<p>If you still have a question, just look again in this text or write a comment in the forum.</p>

	<h2>Control buttons</h2>

	<p>After installing AuctionMaster you will see a button named AuctionMaster in the top right corner of the auction house window. There you will find shortcuts for beeing able to configure AuctionMaster, scan for all current auctions.</p>

	<p>All three aspects will be explained in detail in the next sections.</p>

	<h2>Scanning auctions</h2>

	<p>AuctionMaster is able to scan all current auctions by pressing the Scan button. This may be done in the AuctionMaster popup menu or by using the portrait icon of the auction house. Afterwards a progress dialog will appear, which informs about the progress of the scan. If AuctionMaster encounters an auction with promising prices, it will ask you to bid for it or even buy it immediately. The limits for the latter feature may be configured. They shouldn't be set to low, otherwise the dialog will ask you too oftenly.</p>

	<p>The search for promising items will get better after some scans over a few days. Otherwise some odd prices may influence the statistics too much.</p>

	<p>AuctionMaster will maintain statistics of the scanned auctions. The prices are corrected by a standard deviation method. This may be configured in the statistic section of the configuration.</p>

	<h2>Selling items</h2>

	<p>AuctionMaster will add a fourth tab to the auction house for efficiently selling your items. The left section of the window is used to  describe the sale. The right section will display all current auctions of the same type.</p> 
	<p>By pressing the Refresh button, you may search for more current auctions of the same type. If the last scan is too old, AuctionMaster will automatically scan again - only for the selected item. This time may be configured (like many other things).</p>

	<p>You have to drag the item to be sold in the image in the upper left corner. Alternatively you may just shift left click the item to be sold in your inventory. AuctionMaster will automatically select the last prices, you have used the last time for this item.</p>

	<p>Beside that you are able to select the duration, the prices for bid and buyout, the stack size and the number of stacks. You don't have to prepare the stacks by yourself. AuctionMaster will do it for you. Just select the desired stack size and you're done.</p>

	<p>With Price calculation you can select the following price modes:</p>

<h3>Fixed price:</h3> 
<p>Just selects the bid and buyout prices you have used the last time.</p>

<h3>Current price:</h3> 
<p>Selects the average prices of the current auctions for the selected item. This may be influenced by a configurable percent amount. Will be modified by the configurable percentage value.</p>

<h3>Undercut:</h3> 
<p>Selects the lowest prices of the current auctions for the selected item. This may be influenced by a configurable percent amount. Will be modified by the configurable percentage value.</p>

<h3>Lower market threshold:</h3>
<p>Sets the buyout price to the first auction above the configured lower market threshold (defaults to 30% of the market price). The min bid price is set to exactly the lower market threshold. Will be modified by the configurable percentage value.</p>

<h3>Selling price:</h3>
<p>Selects the selling price of the given item. Will be modified by the configurable percentage value.</p>

<h3>Market price:</h3>
<p>Selects the average bid and buyout prices calculated for the last scans. Will be modified by the configurable percentage value.</p>

	<h2>Auction statistics in the tooltip</h2>

	<p>AuctionMaster will gather statistics for the scanned auction items. It will calculate the median for the prices found. The tooltip of any item will display the overall statistics for the bid and buyout prices and the same for the last scan. Additionally the sell price at the vendor will be displayed.</p>

	<p>For stacked items there will be displayed two prices. The first is for single items and the second (in parens) is for the price of the complete stack.</p>

	<p>The averages for the current server and faction will be displayed.</p>]]

	L["doc_5_title"] = "Configuration"
	L["doc_5"] = [[
	<h1>Configuration</h1>

	<p>Many things of the features described above are configurable. Just press the "Configuration" button and have a look at it. All configuration options are described by a tooltip. You have to point at it for a few seconds, then it will appear.</p>

	<p>There are too many options to describe them here in detail. Hopefully they are self-explaining.</p>]]

	L["doc_6_title"] = "Author"
	L["doc_6"] = [[
	<h1>Author</h1>

	<p>AuctionMaster was written by Udorn, a dusky shadow priest, always looking for some opposing souls to be consumed.</p>]]

	L["doc_7_title"] = "Acknowledgments"
	L["doc_7"] = [[
	<h1>Acknowledgements</h1>

	<p>A big thanks goes to the users of the AuctionMaster forum at Curse, for their support and many good suggestions.</p>

	<p>And some special thanks for translations and bug reporting go to:</p>

	<p>* GloomySunday@CWDG (Simplified Chinese and Bug reporting)</p>
	<p>* Juha@CWDG (Traditional Chinese)</p>
	<p>* StingerSoft (Russian)</p>
	<p>* Cremor (Bug reporting)</p>
	<p>* Kaktus (Bug reporting)</p>]]

end
