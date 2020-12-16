//
//  UIColorExtension.swift


import UIKit

//MARK: - UIColor Extension
extension UIColor {
    
    class func appBlue() -> UIColor {
        return UIColor.init(red: 0.0/255.0, green: 1.0/255.0, blue: 91.0/255.0, alpha: 1.0)
    }
    
    class func appWhite() -> UIColor {
        return UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    class func textPlaceholder() -> UIColor {
        return UIColor.init(red: 31.0/255.0, green: 26.0/255.0, blue: 26.0/255.0, alpha: 1.0)
    }
    
    //Keyboard header color
    static var keyboardColor:UIColor {
        return UIColor.init(red: 12.0/255.0, green: 108.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    }
    
}

// MARK: - Hex to UIcolor
func hexStringToUIColor (hex:String) -> UIColor {
    
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

// MARK: - Hex to UIcolor
func hexStringToUIColorWithAlpha (hex:String,valueof : Int) -> UIColor {
    
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(valueof)
    )
}
