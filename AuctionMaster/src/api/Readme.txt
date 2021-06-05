AuctionMaster-API

Addon developers should never rely directly on the implementing classes of AuctionMaster. This code may change at any time without any warning.

A safe way to use AuctionMaster functionality in your addon is using the api functions found in this directory. This code will remain stable as long as it's possible. If there are changes needed, they will be well-documented for easy adaption to the new functionality.

Each API-file has it's own version of the form MAJOR.MINOR.PATCH. The meaning of the three parts is choosen according to the apache versioning convention:

* A change in the MAJOR number stands for incompatible changes.
* A change in the MINOR number stands for backward compatible changes.
* A change in the PATCH number is both backward and forward compatible.
