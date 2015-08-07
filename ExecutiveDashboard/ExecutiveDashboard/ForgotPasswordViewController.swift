//
//  ForgotPasswordViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 7/6/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    var delegate: CenterViewControllerDelegate?
    enum ControlTags: Int {
        
        // enumeration definition goes here
        case kUsernameTextFiledTag = 1000
        case kEmailTextFiledTag = 1001
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
    @IBAction func cancelButtonClick(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func forgotPasswordButtonClick(sender: AnyObject) {
        
        
        let usernameTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kUsernameTextFiledTag.rawValue)) as! UITextField
        let emailTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kEmailTextFiledTag.rawValue)) as! UITextField
        
        if(usernameTextField.text == ""||usernameTextField.text == nil){
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please enter Username."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else if(emailTextField.text == ""||emailTextField.text == nil){
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please enter email."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else{
            
            
            var aPersonDictionary = [ "username":"\(usernameTextField.text)", "email":"\(emailTextField.text)"]
            var bytes = NSJSONSerialization.dataWithJSONObject(aPersonDictionary, options: NSJSONWritingOptions.allZeros, error: nil)
            let resstr = NSString(data:bytes!, encoding: NSUTF8StringEncoding)
            
            NetworkManager.forgotPasswordDataServiceCall(GlobalVariables.RequestAPIMethods.ForgotPassword.rawValue, bodyData: resstr!, viewController: self)
        }
    }

}
extension ForgotPasswordViewController : UITextFieldDelegate  {
    
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
