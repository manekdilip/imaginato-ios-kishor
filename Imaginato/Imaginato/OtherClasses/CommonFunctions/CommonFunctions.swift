//
//  CommonFunctions.swift
//  Imaginato


import Foundation
import SystemConfiguration
import UIKit
import SVProgressHUD

//MARK: - StoryBoards Constant
struct StoryBoards{
    
    static let Main = UIStoryboard(name: "Main", bundle: Bundle.main)
}

struct ImageName {
    static let imgViewPassword = "icon_viewpassword"
    static let imgHidePassword = "icon_hidepassword"
}

//Check Password
func checkPasswordField(password:String) -> Bool{
    
    
  
    let strPassword = password
    
    //checking condiion variable
   
    var isSpecialChar = false
    var isContainNo = false
    var upperCase = 0
    
    // - > check string contain special character
    let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
    if strPassword.rangeOfCharacter(from: characterset.inverted) != nil {
        isSpecialChar = true
    }
    //- > check string contain lower and upper character
    for chr in strPassword {
        
        let str = String(chr)
        if str.lowercased() != str {
            upperCase += 1
        }
    }
    
    //- >check string contain digital num character
    let decimalCharacters = CharacterSet.decimalDigits
    let decimalRange = strPassword.rangeOfCharacter(from: decimalCharacters)
    if decimalRange != nil {
        isContainNo = true
    }
    
    if isContainNo && upperCase > 0 {
        return false
    }
    return true
}


//MARK: - Check internet connection event
func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}


//TODO: showHud
func showHud(){
    SVProgressHUD.setDefaultStyle(.custom)
    SVProgressHUD.setBackgroundColor(UIColor.clear)
    SVProgressHUD.setBackgroundLayerColor(UIColor.clear)
    SVProgressHUD.setForegroundColor(hexStringToUIColor(hex: "F26722"))
    SVProgressHUD.setRingNoTextRadius(25.0)
    SVProgressHUD.show()
    
    if !UIApplication.shared.isIgnoringInteractionEvents {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
}

//TODO: showPocessHudHud
func showProgressHud(processDone : Float){
    SVProgressHUD.setDefaultStyle(.custom)
    SVProgressHUD.setBackgroundColor(UIColor.black.withAlphaComponent(0.5))
    SVProgressHUD.setBackgroundLayerColor(UIColor.clear)
    SVProgressHUD.setForegroundColor(hexStringToUIColor(hex: "F26722"))
    SVProgressHUD.setRingNoTextRadius(50.0)
    SVProgressHUD.showProgress(processDone, status: "Uploading...")
    
    if !UIApplication.shared.isIgnoringInteractionEvents {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
}

//TODO: hideHud
func hideHud(){
    DispatchQueue.main.async {
        SVProgressHUD.dismiss()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
