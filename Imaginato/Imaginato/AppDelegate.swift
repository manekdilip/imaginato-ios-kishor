//
//  AppDelegate.swift
//  Imaginato


import UIKit
import CoreData
import IQKeyboardManagerSwift
import SVProgressHUD

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true        
        return true
    }
}

