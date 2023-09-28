
import UIKit

class LocalizationManager: NSObject {
    
    let languageList: [LanguageType] = [.english, .burmese, .chinese]
    
    static let sharedInstance = LocalizationManager()
    var lprojBasePath = String()
    let keyLanguageCode = "kCFLocaleLanguageCodeKey"
    
    override fileprivate init() {
        super.init()
        lprojBasePath =  getSelectedLocale()
    }
    
    fileprivate func getSelectedLocale()->String{
        
        let lang = Locale.preferredLanguages
        let languageComponents: [String : String] = [ keyLanguageCode : lang.first ?? "en"]
        
        if let languageCode: String = languageComponents[keyLanguageCode]{
            return languageList.filter{ $0.rawValue == languageCode }.first?.rawValue ?? "en"
        }
        
        return "en"
    }
    
    func getCurrentBundle()->Bundle?{
        
        if let bundle = Bundle.main.path(forResource: lprojBasePath, ofType: "lproj"){
            
            return Bundle(path: bundle)
            
        }else{
            
            fatalError("lproj files not found on project directory. /n Hint:Localize your strings file")
        }
    }
    
    func setLocale(_ langCode: LanguageType){
        
        UserDefaults.standard.set([langCode.rawValue], forKey: "AppleLanguages")//replaces Locale.preferredLanguages
        UserDefaults.standard.synchronize()
        let selectedLocale = getSelectedLocale()
        lprojBasePath =  selectedLocale
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didChangeLanguage"), object: nil )
    }
    
    func getLocale() -> LanguageType {
        let selectedLang = getSelectedLocale()
        return LanguageType(rawValue: selectedLang) ?? .english
    }
}
