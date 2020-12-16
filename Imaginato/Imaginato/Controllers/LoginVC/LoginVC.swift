//
//  ViewController.swift
//  Imaginato
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

//View Password Tag Enum
enum viewPasswordTag: Int {
    
    case viewpassword = 1
    case hidepassword = 0
}

class LoginVC: BaseVC {
    
    //MARK: IBOutlet Declaration
    
    @IBOutlet weak var tfEmail : UITextField!
    @IBOutlet weak var tfPassword : UITextField!
    
    @IBOutlet weak var lblEmail : UILabel!
    @IBOutlet weak var lblPassword : UILabel!
    @IBOutlet weak var lblBtnSaveTitle : UILabel!
    
    @IBOutlet weak var viewEmail : UIView!
    @IBOutlet weak var viewPassword : UIView!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnViewPassword: UIControl!
    
    @IBOutlet weak var imgViewPassword: UIImageView!
    
    //MARK: Variables Declaration
    var strValid = ""
    
    //MARK: Views Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Set Color for TextField Background View
        self.setTextFieldViewBackgaoundColor()
       
        //Disable Login Button
        self.loginButtonDisable()
    }
}

//MARK: IBActoin Declaration
extension LoginVC {
    
    //Login button Click
    @IBAction func clickOnLogin(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        //Call Login API
        self.callLoginApi()

    }
    
    //View Password
    @IBAction func clickOnViewPassword(_ sender: UIControl) {
        
        //Check if password string enter or not
        if self.tfPassword.text == "" {
            return
        }
        
        self.tfPassword.isSecureTextEntry = !self.tfPassword.isSecureTextEntry
        
        self.imgViewPassword.image = self.tfPassword.isSecureTextEntry ? UIImage(named: ImageName.imgHidePassword) : UIImage(named: ImageName.imgViewPassword)
        
    }
}

//MARK: Other Functions
extension LoginVC {
    
    //Set Color for TextField Background View
    func setTextFieldViewBackgaoundColor(){
        
        viewEmail.backgroundColor = AppColor.clrViewPlaceHolderBG
        viewPassword.backgroundColor = AppColor.clrViewPlaceHolderBG
    }
    
    //Login button Active
    func loginButtonActive(){
        
        self.btnLogin.borderColor = UIColor.clear
        self.lblBtnSaveTitle.textColor = UIColor.white
        self.btnLogin.backgroundColor = AppColor.clrCommon
        self.btnLogin.isUserInteractionEnabled = true
    }
    
    //Login button Disable
    func loginButtonDisable(){
        
        self.btnLogin.borderColor = AppColor.clrLightGray
        self.btnLogin.borderwidth = 0.5
        self.lblBtnSaveTitle.textColor = AppColor.clrLightGray
        self.btnLogin.backgroundColor = UIColor.clear
        self.btnLogin.isUserInteractionEnabled = false
        
    }
    
    //For Validation
    func isValid(isTextField : UITextField) -> Bool {
        
        if isTextField == self.tfEmail {
            
            if self.tfEmail.text == "" {
                
                strValid =  "error_email".localized
                return false
                
            }else if  self.tfEmail.isValidEmail(emailStr: tfEmail.text ?? "") == false {
                
                strValid =  "error_email".localized
                return false
            }
        }
        
        if isTextField == self.tfPassword {
            
            if self.tfPassword.text == ""  {
                
                strValid = "error_password".localized
                return false
                
            }else if checkPasswordField(password: self.tfPassword.text!) {
                
                strValid = "error_password".localized
                return false
            }
        }
        return true
    }
    
    //Clear TextField values
    func clearEnterValues(){
        
        self.tfEmail.text = ""
        self.tfPassword.text = ""
    }
}

//MARK: UITextFieldDelegate
extension LoginVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.removeWhiteSpace() == "" && string.removeWhiteSpace() == "" {
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.loginButtonDisable()
        
        //Changed TextField Background View Color
        if (textField == tfEmail) {
            
            lblEmail.textColor =  AppColor.clrCommonText
            viewEmail.borderColor = AppColor.clrCommon
            viewEmail.borderwidth = 1.0
            
        }else if (textField == tfPassword) {
            
            lblPassword.textColor =  AppColor.clrCommonText
            viewPassword.borderColor = AppColor.clrCommon
            viewPassword.borderwidth = 1.0
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //Check Validation
        if isValid(isTextField: textField) {
            
            if !(self.tfEmail.text?.removeWhiteSpace() == "") && !(self.tfPassword.text?.removeWhiteSpace() == "") {
                
                self.loginButtonActive()
            }
        }else {
            
            self.loginButtonDisable()
            self.alertController(title: "", msg: self.strValid)
        }
        
        //Changed TextField Background View Color
        if (textField == tfEmail) {
            
            lblEmail.textColor =  AppColor.clrCommonTextLight
            viewEmail.borderColor = AppColor.clrCommonText
            viewEmail.borderwidth = 0.0
            
        }else if (textField == tfPassword) {
            
            lblPassword.textColor =  AppColor.clrCommonTextLight
            viewPassword.borderColor = AppColor.clrCommonText
            viewPassword.borderwidth = 0.0
        }
    }
}

//MARK: Call APIS
extension LoginVC {
    
    //Call Login API
    func callLoginApi() {
        
        //Show Loding indicator
        showHud()
        
        //Check Internet Connections
        if !isConnectedToNetwork() {
            
            hideHud()
            self.alertController(title: "", msg: "error_Network".localized)
            return
        }
        
        //Create a request parameters
        let parameter:[String:Any] = [
            
            "email": self.tfEmail.text ?? "",
            "password": self.tfPassword.text ?? ""
        ]
        
        //Send a Login request
        request(WebURL.Login, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers:nil).responseJSON{ (response) in
            
            //Hide Loding indicator
            hideHud()
            if response.result.isSuccess {
                
                //Clear Textfield values
                self.clearEnterValues()
                
                //Add Login response in the Model classes
                let json = JSON(response.result.value!)
                let objUserModel = UserModel(json: json)
                
                //Check API Status
                if objUserModel.result  == 1 {
                    
                    //Show a Toast for login success
                    self.view.makeToast("success_login".localized)
                    
                    //Stored a Login user detail
                    createData(userData: objUserModel.userData?.user ?? User.init())
                    
                    //After login redirect next controller
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.pushtoViewController()
                    })
                    
                } else {
                    
                    self.alertController(title: "", msg: objUserModel.errorMessage ?? "")
                }
            }else {
                
                self.alertController(title: "", msg: "error_webServiceFail".localized)
            }
        }
    }
}
