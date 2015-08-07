//
//  ChangePasswordViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 7/6/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    var delegate: CenterViewControllerDelegate?
    
    
    enum ControlTags: Int {
        
        // enumeration definition goes here
        case kOldPasswordTextFiledTag = 1000
        case kNewPasswordTextFiledTag = 1001
        case kConfirmPasswordTextFiledTag = 1002
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: Button actions
    @IBAction func menuButtonClick(sender: AnyObject) {
        
        delegate?.toggleLeftPanel?()
    }
    @IBAction func clearButtonClick(sender: AnyObject) {
        
        
        let oldPassworTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kOldPasswordTextFiledTag.rawValue)) as!
        UITextField
        let newPasswordTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kNewPasswordTextFiledTag.rawValue)) as! UITextField
        let confirmPasswordTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kConfirmPasswordTextFiledTag.rawValue)) as! UITextField
        
        oldPassworTextField.text = ""
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""

    }

    @IBAction func changePasswordButtonClick(sender: AnyObject) {
        
        
        let oldPassworTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kOldPasswordTextFiledTag.rawValue)) as! UITextField
        let newPasswordTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kNewPasswordTextFiledTag.rawValue)) as! UITextField
        let confirmPasswordTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kConfirmPasswordTextFiledTag.rawValue)) as! UITextField

        let newPassword:NSString = newPasswordTextField.text
        
        if(oldPassworTextField.text == ""||oldPassworTextField.text == nil){
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please enter old password."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)

        }else if(newPasswordTextField.text == ""||newPasswordTextField.text == nil){
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please enter new password."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else if(confirmPasswordTextField.text == ""||confirmPasswordTextField.text == nil){
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please enter confirm password."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else if(!(newPassword.isEqualToString(confirmPasswordTextField.text))){
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Passwords does not match. Please enter again."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else{
            
            
            var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
            let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
            
            var aPersonDictionary = ["sessionId":"\(sessionId)", "oldPassword":"\(oldPassworTextField.text)", "newPassword":"\(newPasswordTextField.text)"]
            var bytes = NSJSONSerialization.dataWithJSONObject(aPersonDictionary, options: NSJSONWritingOptions.allZeros, error: nil)
            let resstr = NSString(data:bytes!, encoding: NSUTF8StringEncoding)
            
            NetworkManager.changePasswordDataServiceCall(GlobalVariables.RequestAPIMethods.ChangePassword.rawValue, bodyData: resstr!, viewController: self)
        }
    }

}

extension ChangePasswordViewController : UITextFieldDelegate  {
    
    // MARK: - Textfiled delegate methods
    func textFieldDidBeginEditing(textField: UITextField) {    //delegate method
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {  //delegate method
     
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        
        textField.resignFirstResponder()
        
        return true
    }
    
}


