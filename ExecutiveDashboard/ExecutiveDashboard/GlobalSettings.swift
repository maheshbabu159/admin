//
//  GlobalSettings.swift
//  GameFramework
//
//  Created by apple on 1/16/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation

class GlobalSettings {
    
    class func addUserDefaults(){
        
        
        GlobalVariables.globalUserDefaults.setInteger(0, forKey: GlobalVariables.user_defaults_app_iteration_number_key)
        
        GlobalVariables.globalUserDefaults.setBool(false, forKey: GlobalVariables.user_defaults_app_purchased_flag_key)
        
        GlobalVariables.globalUserDefaults.setInteger(-1,forKey:GlobalVariables.user_defaults_match_id_key)
        
        GlobalVariables.globalUserDefaults.setInteger(-1,forKey:GlobalVariables.user_defaults_location_id_key)
        
        GlobalVariables.globalUserDefaults.setInteger(-1,forKey:GlobalVariables.user_defaults_tournment_id_key)
        
        GlobalVariables.globalUserDefaults.setBool(false,forKey:GlobalVariables.user_defaults_remember_me_key)
     
        GlobalVariables.globalUserDefaults.setBool(false,forKey:GlobalVariables.user_defaults_signed_in_key)

        GlobalVariables.globalUserDefaults.setValue("", forKey: GlobalVariables.user_defaults_session_id_key)
      
        GlobalVariables.globalUserDefaults.setValue("", forKey: GlobalVariables.user_defaults_username_key)
    
        GlobalVariables.globalUserDefaults.setValue("", forKey: GlobalVariables.user_defaults_password_key)
        
        GlobalVariables.globalUserDefaults.setValue("", forKey: GlobalVariables.user_defaults_user_id_key)
        
        GlobalVariables.globalUserDefaults.setValue("", forKey: GlobalVariables.user_defaults_role_name_key)


        NSUserDefaults.standardUserDefaults().synchronize()
        
        
    }
    class func increaseAppIterationNumber(){
        
        var iterationNumber = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_app_iteration_number_key)
        
        iterationNumber = iterationNumber+1;
        
        GlobalVariables.globalUserDefaults.setInteger(iterationNumber, forKey: GlobalVariables.user_defaults_app_iteration_number_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    class func udateSessionId(value:NSString){
        
        GlobalVariables.globalUserDefaults.setValue(value, forKey: GlobalVariables.user_defaults_session_id_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }

    class func getNewMatchId() -> Int{
        
        var currentValue = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_match_id_key)
        
        currentValue = currentValue+1;
        
        GlobalVariables.globalUserDefaults.setInteger(currentValue, forKey: GlobalVariables.user_defaults_match_id_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        return GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_match_id_key)
        
    }
    
    class func getNewLocationId() -> Int{
        
        var currentValue = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_location_id_key)
        
        currentValue = currentValue+1;
        
        GlobalVariables.globalUserDefaults.setInteger(currentValue, forKey: GlobalVariables.user_defaults_location_id_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
    
        return GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_location_id_key)
    }
    
    
    class func updateRemeberMeDefaultValue(boolValue : Bool){
        
        GlobalVariables.globalUserDefaults.setBool(boolValue, forKey: GlobalVariables.user_defaults_remember_me_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()

    }

    class func updateSignedInDefaultValue(boolValue : Bool){
        
        
        GlobalVariables.globalUserDefaults.setBool(boolValue, forKey: GlobalVariables.user_defaults_signed_in_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    class func updateUsernameDefaultValue(value : NSString){
        
        
        GlobalVariables.globalUserDefaults.setValue(value, forKey: GlobalVariables.user_defaults_username_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    class func updateFromYearDefaultValue(value : Int){
        
        
        GlobalVariables.globalUserDefaults.setInteger(value, forKey: GlobalVariables.user_defaults_from_year_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    class func updateToYearDefaultValue(value : Int){
        
        
        GlobalVariables.globalUserDefaults.setInteger(value, forKey: GlobalVariables.user_defaults_to_year_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    class func updateFromMonthDefaultValue(value : Int){
        
        
        GlobalVariables.globalUserDefaults.setInteger(value, forKey: GlobalVariables.user_defaults_from_month_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    class func updateToMonthDefaultValue(value : Int){
        
        
        GlobalVariables.globalUserDefaults.setInteger(value, forKey: GlobalVariables.user_defaults_to_month_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    class func updateRoleNameDefaultValue(value : NSString){
        
        
        GlobalVariables.globalUserDefaults.setValue(value, forKey: GlobalVariables.user_defaults_role_name_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    class func updatePasswordDefaultValue(value : NSString){
        
        GlobalVariables.globalUserDefaults.setValue(value, forKey: GlobalVariables.user_defaults_password_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    class func getNewTournmentId()-> Int{
        
        var currentValue = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_tournment_id_key)
        
        currentValue = currentValue+1;
        
        GlobalVariables.globalUserDefaults.setInteger(currentValue, forKey: GlobalVariables.user_defaults_tournment_id_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        return GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_tournment_id_key)
        
    }
    
    class func updateUserIdDefaultValue(value: NSString)
    {
        GlobalVariables.globalUserDefaults.setValue(value, forKey: GlobalVariables.user_defaults_user_id_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }


    // MARK: Colours functions
    class func RGBA(#r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor{
        
        let color: UIColor = UIColor( red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: CGFloat(a) )
        return color
    }
    class func isAdmin()->Bool {
    
        var currentValue:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_role_name_key) as! NSString
        
        if(currentValue=="Admin"){
            return true
        }else{
            return false
        }
        
        
    
    
    }
    
    class func RGBColor(hexColor : NSString) -> UIColor{
        
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hexColorCode = hexColor as String
        
        if hexColorCode.hasPrefix("#")
        {
            let index   = advance(hexColorCode.startIndex, 1)
            let hex     = hexColorCode.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            
            if scanner.scanHexLongLong(&hexValue)
            {
                if count(hex) == 6
                {
                    red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF) / 255.0
                }
                else if count(hex) == 8
                {
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                }
                else
                {
                    print("invalid hex code string, length should be 7 or 9")
                }
            }
            else
            {
                println("scan hex error")
            }
        }
        
        let color: UIColor =  UIColor(red:CGFloat(red), green: CGFloat(green), blue:CGFloat(blue), alpha: 1.0)
        return color
    }
}