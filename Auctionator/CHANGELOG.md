# Auctionator

## [10.2.38](https://github.com/Auctionator/Auctionator/tree/10.2.38) (2024-05-06)
[Full Changelog](https://github.com/Auctionator/Auctionator/compare/10.2.37...10.2.38) 

- Classic: Prevent other addons interfering with full scan and causing lag  
    AllTheThings registers for the AUCTION\_ITEM\_LIST\_UPDATE event and  
    repeatedly processes it thousands of times when Auctionator is trying to  
    load the item data causing so much lag a player can get an AFK kick.  
