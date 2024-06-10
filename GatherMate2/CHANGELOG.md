# GatherMate2

## [1.47.3-classic](https://github.com/Nevcairiel/GatherMate2/tree/1.47.3-classic) (2024-02-23)
[Full Changelog](https://github.com/Nevcairiel/GatherMate2/compare/1.47.2-classic...1.47.3-classic) [Previous Releases](https://github.com/Nevcairiel/GatherMate2/releases)

- Optimize tooltip and pin menu display + micro optimizations  
    I noticed a large delay when opening the minimap and also when mousing over, so Im optimizing the parts that were a noticable hotspot in the loading process. This should make it so pins no longer loop through all pins to determine what the text contents of the tooltip will be. Also lightly optimized the loading of pins but its not significant,  
    Sadly not much can be done about the initialization stage as of yet as I don't understand how this codebase fully interacts yet. Give me some time and I can probably make it run fit as a fiddle.  
- Fix addon loaded check for data providers  
- Update TOCs  
