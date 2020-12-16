//
//  HomeVC.swift
//  Imaginato

import UIKit

class HomeVC: BaseVC {

    //MARK: IBOutlet Declaration
    
    @IBOutlet weak var lblUserID : UILabel!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblCreateAtDate : UILabel!
    
    @IBOutlet weak var btnLogout: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Get user detail from Local database
        setUserDetail()

    }
    
    //Display User Detail
    func setUserDetail(){
        
        let arruserDetail :[User] = retrieveData()
        self.lblUserID.text = "UserId :- " + String(arruserDetail[0].userId!)
        self.lblUserName.text = "Username :- " + String(arruserDetail[0].userName ?? "")
        self.lblCreateAtDate.text = "Date :- " + String(arruserDetail[0].createdAt?.convertToYYYY_MM_dd() ?? "")
    }
}

//MARK: IBActoin Declaration
extension HomeVC {
    
    @IBAction func clickOnLogout(_ sender: UIControl) {
        
        showAlertAction(title: "Alert", message: "message_Logout".localized, cancelTitle: "No", okTitle: "Yes", okCompletion: {            
            self.poptoViewController()
        })
    }
}
