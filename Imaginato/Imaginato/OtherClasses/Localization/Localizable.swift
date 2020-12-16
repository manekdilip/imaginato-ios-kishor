//
//  Localizable.swift


import Foundation
import UIKit

//Localizable
public protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
  
    public var localized: String {
       return NSLocalizedString(self, comment: "\(self)_comment")
     }
     
     func localized(_ args: [CVarArg]) -> String {
       return localized(args)
     }
     
     func localized(_ args: CVarArg...) -> String {
       return String(format: localized, args)
     }
}

//XIBLocalizable
public protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
    
    @IBInspectable public var xibCapSentLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized.capitalized
        }
    }
    
    @IBInspectable public var xibCapLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized.uppercased()
        }
    }
    
    @IBInspectable public var xibLowLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized.lowercased()
        }
    }
}

extension UITextField: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
    
    @IBInspectable public var xibCapSentLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized.capitalized, for: .normal)
        }
    }
    
    @IBInspectable public var xibCapLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized.uppercased(), for: .normal)
        }
    }
    
    @IBInspectable public var xibLowLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized.lowercased(), for: .normal)
        }
    }
}
