# RangeDisplay

## [v6.3.0](https://github.com/mitchnull/RangeDisplay/tree/v6.3.0) (2026-02-07)
[Full Changelog](https://github.com/mitchnull/RangeDisplay/compare/v6.2.8...v6.3.0) 

- minor tidy-up  
- Fix all current pre-patch errors for Midnight 12.0.0 - Merge pull request #9 from Hinos/master  
- Update RangeDisplay.toc  
- Fix: Prevent secret value errors; Restore display values for target  
    This fix resolves all current pre-patch errors (Midnight 12.0.0).  
    - Handles value requests in a function to prevent errors if it returns  secret values  
    - Displays range even if a secret value was returned  
    - Works in dungeons as well as outside! Tested all.  