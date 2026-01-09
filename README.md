# weather-owm

## Overview

This document provide the considerations on this version of the app

---
## Considerations

### 1. Different schemes are not created for DEV/UAT/PROD since only the PROD version of Open Weather Map API is available

### 2. The API key should not be hard coded in the source code. For the scope of this version I will loading the API keys from a JSON file. However, this is not a best practice and definetively is not a solution suitable for PROD environment

### 3. The predefined/ user defined locations are hard coded in the source code. Ideally this should be stored/fetched from the backend or at least stored in the keychain/user defaults

### 4. When developing this version I realized I could create a reusable card to display the weather for current location and other cities location


## Next steps

### 1. Provide better handling for Location Permission. 
This version is not handling situations such as the user denying the persmision.
This version doesn't allow the user to use the app in case the permision is not granted.
 

### 2. Refactor the UI to use reusable component for displaying the weather
### 3. Provide an UI to add, delete and manually search the locations
### 4. Add caching strategies and offline mode
### 5. Provide an UI to display detailed data of the weather.
### 6. Add deep linking to iOS Setting when the app detects the permission is denied.
### 7. Add pull to refresh or a button for manual refresh
### 8. Add navigation using coordinator and hosting view controllers
### 9. Add testing.

 
