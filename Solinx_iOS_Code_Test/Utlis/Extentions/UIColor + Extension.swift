
import UIKit

extension UIColor {
    
    convenience init(_ hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init("ff0000") // return red color for wrong hex input
          return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
      }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIColor {
    convenience init(
            light lightModeColor: @escaping @autoclosure () -> UIColor,
            dark darkModeColor: @escaping @autoclosure () -> UIColor
         ) {
            self.init { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light:
                    return lightModeColor()
                case .dark:
                    return darkModeColor()
                case .unspecified:
                    return darkModeColor()
                @unknown default:
                    return lightModeColor()
                }
            }
        }
    //#F3F3F5
    class var black_8_color : UIColor {#colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9607843137, alpha: 1)}
    
    //#205ACA
    class var primary_color : UIColor {#colorLiteral(red: 0.1254901961, green: 0.3529411765, blue: 0.7921568627, alpha: 1)}
    
    //#F5F5F5
    class var white_text_color : UIColor {#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)}
    
    //#FFFFFF
    class var white_color : UIColor {#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)}
    
    //#F4F7FC
    class var p4_color : UIColor {#colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9882352941, alpha: 1)}
    
    //#E9EEFA
    class var p3_color : UIColor {#colorLiteral(red: 0.9137254902, green: 0.9333333333, blue: 0.9803921569, alpha: 1)}
    
    //#C7D6F2
    class var p2_color : UIColor {#colorLiteral(red: 0.7803921569, green: 0.8392156863, blue: 0.9490196078, alpha: 1)}
    
    //#8FACE4
    class var p1_color : UIColor {#colorLiteral(red: 0.5607843137, green: 0.6745098039, blue: 0.8941176471, alpha: 1)}
    
    //#093996
    class var p_dark_color : UIColor {#colorLiteral(red: 0.03529411765, green: 0.2235294118, blue: 0.5882352941, alpha: 1)}
    
    //#1f7a8c
    class var secondary_color : UIColor {#colorLiteral(red: 0.1882352941, green: 0.6901960784, blue: 0.7803921569, alpha: 1)}
}
