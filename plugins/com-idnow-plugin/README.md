# Cordova IdNow plugin

* `startIdNowSdk` method: initialises the id now sdk by sending the transaction token to the native component and starting the idnow service - passes a string value
* `setCompanyId` method: sets the company id to be pass when the sdk is initialized - passes a string value 
* `setShowVideoOverviewCheck` method: sets if wheter the initial check overview screen should appear in the video ident flow - passes a boolean value 
* `setAppGoogleRating` method: sets if wheter the app google rating screen will be visible at the end of the indet flow(only for android)  - passe a boolean value
* `setShowErrorSuccessScreen` method: sets if wheter the completion error or success screnn is shwon at the end of the ident flow 
* `setIdNowLanguage` method: sets the sdk language
* `presentModaly` method: sets if the native view controller is presented modally (ios)
* `isTestEnvironment` method: switches between test and live environments 

# iOS apperance 
* `setDefaultTextColor` Optional color, that replaces the default text color. Default: A nearly black color Recommendation: Should be some kind of a dark color that does not collide with white color.
* `setPrimaryBrandColor:` method: Optional color, that replaces the default brand color. Default: defaultTextColor Used in headlines, checkboxes, links, alerts etc. Recommendation: Should be a color that does not collide with white color.
* `setProceedButtonBackgroundColor:` method: Optional color, that replaces the proceed button background color. Default: An orange color
* `setProceedButtonTextColor` method: Optional color, that replaces the proceed button text color. Default value: White color
* `setPhotoIdentRetakeButtonBackgroundColor` method: Optional color, that replaces the photo ident retake button background color. Default value: defaultTextColor
* `setPhotoIdentRetakeButtonTextColor` method: Optional color, that replaces the photo ident retake button text color. Default value: proceedButtonTextColor
* `setTextFieldColor` method: Optional color, that replaces the default color of textfield backgrounds and borders Default: defaultTextColor
* `setFailureColor` method: Optional color, that replaces the text color in the result screen, when an identification failed. Default: A red color
* `setSuccessColor` method: Optional color, that replaces the text color in the result screen, when an identification was successful. Default: A green color
* `setCqcOuterRingColor` method: Optional color that replaces default dark gray for the outer ring indicator on the quality check screen. Default: dark gray
* `setCqcDefaultInnerRingColor` method: Optional color that replaces default light gray for the inner ring indicator on the quality check screen. Default: light gray
* `setCqcPoorQualityInnerColor` method: Optional color that replaces default bright red for the inner ring indicator in case bad network quality on the quality check screen. Default: bright red
* `setCqcModerateQualityInnerColor` method:Optional color that replaces default bright orange for the inner ring indicator in case moderate network quality on the quality check screen. Default: bright orange
* `setCqcExcellentQualityInnerColor` method: Optional color that replaces default strong yellow for the inner ring indicator in case excellent network quality on the quality check screen. Default: strong yellow (almost green).
* `setFontNameRegular` method: An optional font name that can be used to replace the regular font used by the SDK. Default: System Font: Helvetica Neue Regular (< iOS 9), San Francisco Regular (>= iOS 9)
* `setFontNameMedium` method: An optional font name that can be used to replace the medium font used by the SDK. Default: System Font: Helvetica Neue Medium (< iOS 9), San Francisco Medium (>= iOS 9)
* `setFontNameLight` method: An optional font name that can be used to replace the light font used by the SDK. Default: System Font: Helvetica Neue Light (< iOS 9), San Francisco Light (>= iOS 9)
* `enableStatusBarStyleLightContent` method: Optional: Forces the light status bar style to match dark navigation bars. If you tint your navigation bar with a dark color by adjusting navigation bar appearance (e.g. a blue color) you can set this value to true. The statusbar style will then be adjusted to light in screens where the navigation bar is visible.

# android apperance 
Create colors xml and modify the desired colors 

example of xml colors in cordova project: 

<?xml version="1.0" encoding="utf-8"?>

<resources>

    <!-- Used by theme as default color for display and editable texts -->
    <color name="text_default">#4A4A4A</color>

    <!-- Primary color is used for headlines and links -->
    <color name="primary">#F95602</color>

    <!-- background color for confirmation/continue button, which is usually placed at the bottom of a screen -->
    <color name="proceed_button_background">@color/primary</color>

    <!-- "Wiederholen" button when a photo was taken in photo ident -->
    <color name="photo_ident_retake_button_background">@color/text_default</color>

    <!-- Colors of the result screen -->
    <color name="success">#A4AC49</color>
    <color name="failure">#E0727A</color>

</resources>













