# Auctionator

## [9.2.42](https://github.com/Auctionator/Auctionator/tree/9.2.42) (2022-10-08)
[Full Changelog](https://github.com/Auctionator/Auctionator/compare/9.2.41...9.2.42) 

- Convert to using dropdown library to avoid taint, again. (#1226)  
    This resolves a taint error in the Dragonflight pre-patch for edit mode  
- [Fixes #1202] Shopping: Autocomplete searches with seen search terms  
- DBKeyFromLink: Fix nil reference error in some cases  
- Shopping: Isolate recents management code  
- Code cleanup (no functionality changes)  
- Rename ShoppingLists variable to Shopping  
