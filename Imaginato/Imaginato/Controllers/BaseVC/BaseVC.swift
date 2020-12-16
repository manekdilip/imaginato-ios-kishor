//
//  BaseVC.swift
//  Imaginato


import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//MARK:- PushViewController
//MARK:-

extension BaseVC {

    func pushtoViewController(strControllerIdentifire : String = "HomeVC",animated:Bool=true) {
     
        guard let vc = StoryBoards.Main.instantiateViewController(withIdentifier: strControllerIdentifire) as? HomeVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: animated)
    }
}

//MARK:- PopToViewController
//MARK:-

extension BaseVC {
    
    func poptoViewController(animated:Bool=true) {
        
        self.navigationController?.popViewController(animated: animated)
    }
}
