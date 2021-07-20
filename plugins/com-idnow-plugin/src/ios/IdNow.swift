import AppCenter
import IDnowSDK
@objc(IdNow) class IdNow : CDVPlugin {
    private var companyId = ""
    private var showVideoOverviewCheck = false
    private var showErrorSuccessScreen = false
    private var language = "en"
    private var defaultTextColor: UIColor?
    private var primaryBrandColor: UIColor?
    private var proceedButtonBackgroundColor: UIColor?
    private var proceedButtonTextColor: UIColor?
    private var photoIdentRetakeButtonBackgroundColor: UIColor?
    private var photoIdentRetakeButtonTextColor: UIColor?
    private var textFieldColor: UIColor?
    private var failureColor: UIColor?
    private var successColor: UIColor?
    private var cqcOuterRingColor: UIColor?
    private var cqcDefaultInnerRingColor: UIColor?
    private var cqcPoorQualityInnerColor: UIColor?
    private var cqcModerateQualityInnerColor: UIColor?
    
    private var cqcExcellentQualityInnerColor: UIColor?
    
    private var fontNameRegular: String?
    private var fontNameMedium: String?
    private var fontNameLight: String?
    
    private var enableStatusBarLightContent: Bool?
    
    private var modalPresent: Bool?
    private var isTestEnvironment: Bool?
    var pluginResult = CDVPluginResult(
        status: CDVCommandStatus_ERROR
    )
    
    @objc(startIdNowSdk:)
    func startIdNowSdk(command: CDVInvokedUrlCommand) {
        let token = command.argument(at: 0)
        let settings = IDnowSettings(companyID: companyId)
        let appereance = IDnowAppearance.shared()
        settings.environment = .live
        
        if let defaultTextColor = defaultTextColor {
            appereance.defaultTextColor = defaultTextColor
        }
        
        if let primaryBrandColor = primaryBrandColor {
            appereance.primaryBrandColor = primaryBrandColor
        }
        
        if let proceedButtonBackgroundColor = proceedButtonBackgroundColor {
            appereance.proceedButtonBackgroundColor = proceedButtonBackgroundColor
        }
        
        if let proceedButtonTextColor = proceedButtonTextColor {
            appereance.proceedButtonTextColor = proceedButtonTextColor
        }
        
        if let photoIdentRetakeButtonBackgroundColor = photoIdentRetakeButtonBackgroundColor {
            appereance.photoIdentRetakeButtonBackgroundColor = photoIdentRetakeButtonBackgroundColor
        }
        
        if let photoIdentRetakeButtonTextColor = photoIdentRetakeButtonTextColor {
            appereance.photoIdentRetakeButtonTextColor = photoIdentRetakeButtonTextColor
        }
        
        if let textFieldColor = textFieldColor {
            appereance.textFieldColor = textFieldColor
        }
        
        if let failureColor = failureColor {
            appereance.failureColor = failureColor
        }
        
        if let successColor = successColor {
            appereance.successColor = successColor
        }
        
        if let cqcOuterRingColor = cqcOuterRingColor {
            appereance.cqcOuterRingColor = cqcOuterRingColor
        }
        
        if let cqcDefaultInnerRingColor = cqcDefaultInnerRingColor {
            appereance.cqcDefaultInnerRingColor = cqcDefaultInnerRingColor
        }
        
        if let cqcPoorQualityInnerColor = cqcPoorQualityInnerColor {
            appereance.cqcPoorQualityInnerColor = cqcPoorQualityInnerColor
        }
        
        if let cqcModerateQualityInnerColor = cqcModerateQualityInnerColor {
            appereance.cqcModerateQualityInnerColor = cqcModerateQualityInnerColor
        }
        
        if let cqcExcellentQualityInnerColor = cqcExcellentQualityInnerColor {
            appereance.cqcExcellentQualityInnerColor = cqcExcellentQualityInnerColor
        }
        
        if let fontNameRegular = fontNameRegular {
            appereance.fontNameRegular = fontNameRegular
        }
        
        if let fontNameMedium = fontNameMedium {
            appereance.fontNameMedium = fontNameMedium
        }
        
        if let fontNameLight = fontNameLight {
            appereance.fontNameLight = fontNameLight
        }
        
        if let enableStatusBarLightContent = enableStatusBarLightContent {
            appereance.enableStatusBarStyleLightContent = enableStatusBarLightContent
        }
        
        if let isTestEnvironment = isTestEnvironment {
            if isTestEnvironment {
                settings.environment = .test
            } else {
                settings.environment = .live
            }
        }
        
        
        settings.companyID = companyId
        settings.showVideoOverviewCheck = showVideoOverviewCheck
        settings.showErrorSuccessScreen = showErrorSuccessScreen
        settings.transactionToken = token as? String
        settings.userInterfaceLanguage = language
        settings.showVideoOverviewCheck = false
        if let modalPresent = modalPresent {
            settings.forceModalPresentation = modalPresent
        }
        self.commandDelegate.run(inBackground: {
            print("in background")
            let controller = IDnowController(settings: settings)
            controller.initialize(completionBlock: { [weak self]  success, error, cancelByUser in
                guard let self = self else { return }
                if success {
                    controller.startIdentification(from: self.viewController, withCompletionBlock: { success, error, cancelByUser in
                        if success {
                            self.pluginResult = CDVPluginResult(
                                status: CDVCommandStatus_OK,
                                messageAs: "Success"
                            )
                        }
                        else if cancelByUser {
                            self.pluginResult = CDVPluginResult(
                                status: CDVCommandStatus_OK,
                                messageAs: "Canceled by user"
                            )
                        }
                        else if (error != nil) {
                            self.pluginResult = CDVPluginResult(
                                status: CDVCommandStatus_ERROR,
                                messageAs: error?.localizedDescription
                            )
                        }
                        self.commandDelegate?.send(self.pluginResult, callbackId: command.callbackId)
                    }
                    )
                } else if (error != nil) {
                    self.showMessage(error: error!)
                }
            })
        })
        
    }
    @objc(presentModaly:)
    func presentModaly(command: CDVInvokedUrlCommand) {
        if let modalPresent = command.argument(at: 0) as? Bool {
            self.modalPresent = modalPresent
        }
    }
    @objc(setCompanyId:)
    func setCompanyId(command: CDVInvokedUrlCommand) {
        companyId = command.argument(at: 0) as? String ?? ""
    }
    
    @objc(isTestEnvironment:)
    func isTestEnvironment(command: CDVInvokedUrlCommand) {
        if let isTestEnvironment = command.argument(at: 0) as? Bool {
            self.isTestEnvironment = isTestEnvironment
        }
    }
    
    @objc(setShowVideoOverviewCheck:)
    func setShowVideoOverviewCheck(command: CDVInvokedUrlCommand) {
        if let showVideoOverview = command.argument(at: 0) as? Bool {
            showVideoOverviewCheck = showVideoOverview
        }
    }
    
    @objc(setAppGoogleRating:)
    func setAppGoogleRating(command: CDVInvokedUrlCommand) {
        print("unsupported method")
    }
    
    @objc(setShowErrorSuccessScreen:)
    func setShowErrorSuccessScreen(command: CDVInvokedUrlCommand) {
        if let showErrorSuccess = command.argument(at: 0) as? Bool {
            showErrorSuccessScreen = showErrorSuccess
        }
    }
    @objc(setIdNowLanguagce:)
    func setIdNowLanguage(command: CDVInvokedUrlCommand) {
        if let language = command.argument(at: 0) as? String {
            self.language = language
        }
    }
    //apperance
    @objc(setDefaultTextColor:)
    func setDefaultTextColor(command: CDVInvokedUrlCommand) {
        if let defaultColor = command.argument(at: 0) as? String {
            defaultTextColor = UIColor().hexStringToUIColor(hex: defaultColor)
        }
    }
    
    @objc(setPrimaryBrandColor:)
    func setPrimaryBrandColor(command: CDVInvokedUrlCommand) {
        if let primaryBrandColor = command.argument(at: 0) as? String {
            self.primaryBrandColor = UIColor().hexStringToUIColor(hex: primaryBrandColor)
        }
    }
    
    @objc(setProceedButtonBackgroundColor:)
    func setproceedButtonBackgroundColor(command: CDVInvokedUrlCommand) {
        if let proceedButtonBackgroundColor = command.argument(at: 0) as? String {
            self.proceedButtonBackgroundColor = UIColor().hexStringToUIColor(hex: proceedButtonBackgroundColor)
        }
    }
    
    @objc(setProceedButtonTextColor:)
    func setProceedButtonTextColor(command: CDVInvokedUrlCommand) {
        if let proceedButtonTextColor = command.argument(at: 0) as? String {
            self.proceedButtonTextColor = UIColor().hexStringToUIColor(hex: proceedButtonTextColor)
        }
    }
    
    @objc(setPhotoIdentRetakeButtonBackgroundColor:)
    func setPhotoIdentRetakeButtonBackgroundColor(command: CDVInvokedUrlCommand) {
        if let photoIdentRetakeButtonBackgroundColor = command.argument(at: 0) as? String {
            self.photoIdentRetakeButtonBackgroundColor = UIColor().hexStringToUIColor(hex: photoIdentRetakeButtonBackgroundColor)
        }
    }
    
    
    @objc(setPhotoIdentRetakeButtonTextColor:)
    func setPhotoIdentRetakeButtonTextColor(command: CDVInvokedUrlCommand) {
        if let photoIdentRetakeButtonTextColor = command.argument(at: 0) as? String {
            self.photoIdentRetakeButtonTextColor = UIColor().hexStringToUIColor(hex: photoIdentRetakeButtonTextColor)
        }
    }
    
    @objc(setTextFieldColor:)
    func setTextFieldColor(command: CDVInvokedUrlCommand) {
        if let  textFieldColor = command.argument(at: 0) as? String {
            self.textFieldColor = UIColor().hexStringToUIColor(hex: textFieldColor)
        }
    }
    
    @objc(setFailureColor:)
    func setFailureColor(command: CDVInvokedUrlCommand) {
        if let failureColor = command.argument(at: 0) as? String {
            self.failureColor = UIColor().hexStringToUIColor(hex: failureColor)
        }
    }
    
    @objc(setSuccessColor:)
    func setSuccessColor(command: CDVInvokedUrlCommand) {
        if let successColor = command.argument(at: 0) as? String {
            self.successColor = UIColor().hexStringToUIColor(hex: successColor)
        }
    }
    
    @objc(setCqcOuterRingColor:)
    func setCqcOuterRingColor(command: CDVInvokedUrlCommand) {
        if let cqcOuterRingColor = command.argument(at: 0) as? String {
            self.cqcOuterRingColor = UIColor().hexStringToUIColor(hex: cqcOuterRingColor)
        }
    }
    
    
    @objc(setCqcDefaultInnerRingColor:)
    func setCqcDefaultInnerRingColor(command: CDVInvokedUrlCommand) {
        if let cqcDefaultInnerRingColor = command.argument(at: 0) as? String {
            self.cqcDefaultInnerRingColor = UIColor().hexStringToUIColor(hex: cqcDefaultInnerRingColor)
        }
    }
    
    
    @objc(setCqcPoorQualityInnerColor:)
    func setCqcPoorQualityInnerColor(command: CDVInvokedUrlCommand) {
        if let cqcPoorQualityInnerColor = command.argument(at: 0) as? String {
            self.cqcPoorQualityInnerColor = UIColor().hexStringToUIColor(hex: cqcPoorQualityInnerColor)
        }
    }
    
    @objc(setCqcModerateQualityInnerColor:)
    func setCqcModerateQualityInnerColor(command: CDVInvokedUrlCommand) {
        if let cqcModerateQualityInnerColor = command.argument(at: 0) as? String {
            self.cqcModerateQualityInnerColor = UIColor().hexStringToUIColor(hex: cqcModerateQualityInnerColor)
        }
    }
    
    @objc(setCqcExcellentQualityInnerColor:)
    func setCqcExcellentQualityInnerColor(command: CDVInvokedUrlCommand) {
        if let cqcExcellentQualityInnerColor = command.argument(at: 0) as? String {
            self.cqcExcellentQualityInnerColor = UIColor().hexStringToUIColor(hex: cqcExcellentQualityInnerColor)
        }
    }
    
    //apperance
    
    //fonts
    
    @objc(setFontNameRegular:)
    func setFontNameRegular(command: CDVInvokedUrlCommand) {
        if let fontNameRegular = command.argument(at: 0) as? String {
            self.fontNameRegular = fontNameRegular
        }
    }
    
    @objc(setFontNameMedium:)
    func setFontNameMedium(command: CDVInvokedUrlCommand) {
        if let fontNameMedium = command.argument(at: 0) as? String {
            self.fontNameMedium = fontNameMedium
        }
    }
    
    @objc(setFontNameLight:)
    func setFontNameLight(command: CDVInvokedUrlCommand) {
        if let fontNameLight = command.argument(at: 0) as? String {
            self.fontNameLight = fontNameLight
        }
    }
    
    @objc(enableStatusBarStyleLightContent:)
    func enableStatusBarStyleLightContent(command: CDVInvokedUrlCommand) {
        if let enableStatusBarLightContent = command.argument(at: 0) as? Bool {
            self.enableStatusBarLightContent = enableStatusBarLightContent
        }
    }
    
    func showMessage(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                        switch action.style{
                                        case .default:
                                            print("default")
                                        case .cancel:
                                            print("cancel")
                                        case .destructive:
                                            print("destructive")
                                            
                                        }}))
        self.viewController.present(alert, animated: true, completion: nil)
    }
}

extension UIColor {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
