//
//  NetworkManager.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/22/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

class NetworkManager: NSObject {
   
    
    class func initAFNetworkManager()-> AFHTTPRequestOperationManager {
    
        
        // initialize manager
        let manager = AFHTTPRequestOperationManager()
        
        manager.requestSerializer = AFJSONRequestSerializer()
        
        // set headers
        manager.requestSerializer.setValue(GlobalVariables.request_content_type_value, forHTTPHeaderField: GlobalVariables.request_content_type_key)
        manager.requestSerializer.setValue(GlobalVariables.x_parse_application_id_value, forHTTPHeaderField: GlobalVariables.x_parse_application_id_key)
        manager.requestSerializer.setValue(GlobalVariables.x_parse_rest_api_value, forHTTPHeaderField: GlobalVariables.x_parse_rest_api_key)
        
        return manager
    }
    class func getRootDictionaryFromResponseObject(responseObject: AnyObject)-> AnyObject! {
        
        var responseString: NSString = responseObject.description
        var data = responseString.dataUsingEncoding(NSUTF8StringEncoding)
        var localError: NSError?
        var jsonDictionary: AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &localError)
        return jsonDictionary
    }
    
    // MARK: Creating request object
    class func getRequestObject(apiMethod:NSString, bodyData:NSString)-> NSMutableURLRequest {
    
        var remoteUrl : NSURL? = NSURL(string: GlobalVariables.request_url + (apiMethod as String))
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: remoteUrl!)
        request.setValue(GlobalVariables.request_content_type_value, forHTTPHeaderField:GlobalVariables.request_content_type_key)
        request.setValue(GlobalVariables.x_parse_application_id_value, forHTTPHeaderField: GlobalVariables.x_parse_application_id_key)
        request.setValue(GlobalVariables.x_parse_rest_api_value, forHTTPHeaderField: GlobalVariables.x_parse_rest_api_key)
        request.setValue("\(bodyData.length)", forHTTPHeaderField: GlobalVariables.request_content_length_key)
        request.HTTPMethod = GlobalVariables.request_type_value
        
        request.HTTPMethod = "POST"
        request.HTTPBody = (bodyData as NSString).dataUsingEncoding(NSUTF8StringEncoding)

        return request
    }
    
    
    class func loginCheckServiceCall(apiMethod:NSString, bodyData:NSString, viewController:UIViewController) {
        

        let reachability = Reachability.reachabilityForInternetConnection()
        
        if(Reachability.isReachable(reachability)() == true){
            //Show the progress bard
            let progressHUD = MBProgressHUD.showHUDAddedTo(viewController.view, animated: true)
            progressHUD.labelText = "Loading..."
            
            
            NSURLConnection.sendAsynchronousRequest(NetworkManager.getRequestObject(apiMethod, bodyData:bodyData ), queue: NSOperationQueue.mainQueue(), completionHandler:{
                ( response:NSURLResponse!,  data:NSData!, error:NSError!) -> Void in
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                
                println(resstr)
                
                
                if((resstr) != nil){
                    
                    
                    var localError: NSError?
                    var jsonDictionary: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
                    
                    if let rootDictionary = jsonDictionary as? [String: AnyObject] {
                       
                        
                        //return (true, rootDictionary)
                    
                        if let resultString:NSString = rootDictionary["result"] as? NSString {
                            
                            println(resultString)
                            
                            if(resultString.isEqualToString("Invalid Credentials")){
                                
                                let alertController = UIAlertController(title:"Executive Dashboard", message:resultString as String
                                    , preferredStyle: UIAlertControllerStyle.Alert)
                                
                                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                
                                viewController.presentViewController(alertController, animated: true, completion: nil)
                                
                            }else{
                                
                                
                                //Save session id to user defaults
                                if let sessionId:NSString = rootDictionary["result"] as? NSString{
                                    
                                    GlobalSettings.udateSessionId(sessionId)
                                    GlobalSettings.updateSignedInDefaultValue(true)
                                    
                                    var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
                                    let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
                                  
                                   
                                    
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                                    
                                        //self.registerDeviceServiceCall("RegisterDevice", bodyData: jsonString, viewController: viewController)
                                        
                                    }
                                    
                                    
                                    //Initiate profile service call
                                    self.getProfileDataServiceCall(GlobalVariables.RequestAPIMethods.GetProfile.rawValue, bodyData: jsonString, viewController: viewController)
                                    
                                }else{
                                    
                                    let alertController = UIAlertController(title:"Executive Dashboard", message:"Session id not recieved."
                                        , preferredStyle: UIAlertControllerStyle.Alert)
                                    
                                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                    
                                    viewController.presentViewController(alertController, animated: true, completion: nil)
                                }
                                
                                
                            }
                            
                        }
                    }
                    
                }else{
                    
                    let alertController = UIAlertController(title:"Executive Dashboard", message:"Invalid response."
                        , preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                    
                    viewController.presentViewController(alertController, animated: true, completion: nil)
                }
                
                
            })
        }else{
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please check the internet connection."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }

        
      
    }
    
    // MARK: Getting profile 
    class func getProfileDataServiceCall(apiMethod:NSString, bodyData:NSString, viewController:UIViewController) {
        
        let reachability = Reachability.reachabilityForInternetConnection()

        //Check for internet connection
        if(Reachability.isReachable(reachability)() == true){
            
            //Show the progress bard
            let progressHUD = MBProgressHUD.showHUDAddedTo(viewController.view, animated: true)
            progressHUD.labelText = "Loading..."
            
            NSURLConnection.sendAsynchronousRequest(NetworkManager.getRequestObject(apiMethod, bodyData:bodyData ), queue: NSOperationQueue.mainQueue(), completionHandler:{
                ( response:NSURLResponse!,  data:NSData!, error:NSError!) -> Void in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                println(resstr)
                
                if((resstr) != nil){
                    
                    
                    var localError: NSError?
                    var rootDictionary: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
                    
                    //Remove existing profile
                    ProfileModel.deleteAllProfiles()
                    
                    //Save the latest profile dictionary to local database
                    ProfileModel.initWithDictionary(rootDictionary  as! NSDictionary)
                    
                    var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
                    let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
                    
                    var fromMonth:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_from_month_key)
                    var fromYear:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_from_year_key)
                    var toMonth:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_to_month_key)
                    var toYear:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_to_year_key)
                    
                    
                    var aPersonDictionary = ["sessionId":"\(sessionId)", "fromYear":fromYear, "fromMonth":fromMonth, "toYear":toYear, "toMonth":toMonth]
                    var bytes = NSJSONSerialization.dataWithJSONObject(aPersonDictionary, options: NSJSONWritingOptions.allZeros, error: nil)
                    let resstr = NSString(data:bytes!, encoding: NSUTF8StringEncoding)
                    

                    //Call Other servicess for getting remaining data
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        
                        
                        self.getWebSiteVisitsServiceCall(GlobalVariables.RequestAPIMethods.GetWebsiteVisits.rawValue, bodyData: resstr!, viewController: viewController)
                       
                        
                    }
                    
                    
                }else{
                    
                    
                }
                
            })
        }else{
            
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please check the internet connection."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    // MARK: Getting websites data
    class func getWebSiteVisitsServiceCall(apiMethod:NSString, bodyData:NSString, viewController:UIViewController) {
        
        let reachability = Reachability.reachabilityForInternetConnection()
        
        //Check for internet connection
        if(Reachability.isReachable(reachability)() == true){
            
            //Show the progress bard
            let progressHUD = MBProgressHUD.showHUDAddedTo(viewController.view, animated: true)
            progressHUD.labelText = "Loading..."
            
            
            NSURLConnection.sendAsynchronousRequest(NetworkManager.getRequestObject(apiMethod, bodyData:bodyData ), queue: NSOperationQueue.mainQueue(), completionHandler:{
                ( response:NSURLResponse!,  data:NSData!, error:NSError!) -> Void in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                println(resstr)
                
                if((resstr) != nil){
                    
                    
                    var localError: NSError?
                    var rootDictionary: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
                    
                    //Remove existing profile
                    WebsiteVisitModel.deleteAllWebsiteVisitObjects()
                    
                    //Save the latest profile dictionary to local database
                    WebsiteVisitModel.initWithDictionary(rootDictionary as! NSDictionary)
                    
                    var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
                    let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
                
                    var fromMonth:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_from_month_key)
                    var fromYear:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_from_year_key)
                    var toMonth:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_to_month_key)
                    var toYear:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_to_year_key)
                    
                    
                    var aPersonDictionary = ["sessionId":"\(sessionId)", "fromYear":fromYear, "fromMonth":fromMonth, "toYear":toYear, "toMonth":toMonth]
                    
                    var bytes = NSJSONSerialization.dataWithJSONObject(aPersonDictionary, options: NSJSONWritingOptions.allZeros, error: nil)
                    let resstr = NSString(data:bytes!, encoding: NSUTF8StringEncoding)
                    
                    
                    self.getRevenueServiceCall(GlobalVariables.RequestAPIMethods.GetRevenue.rawValue, bodyData: resstr!, viewController: viewController)
          
                    
                }else{
                    
                    
                }
                
            })
        }else{
            
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please check the internet connection."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    // MARK: Getting revenue data
    class func getRevenueServiceCall(apiMethod:NSString, bodyData:NSString, viewController:UIViewController) {
        
        let reachability = Reachability.reachabilityForInternetConnection()
        
        //Check for internet connection
        if(Reachability.isReachable(reachability)() == true){
            
            //Show the progress bard
            let progressHUD = MBProgressHUD.showHUDAddedTo(viewController.view, animated: true)
            progressHUD.labelText = "Loading..."
            
            
            NSURLConnection.sendAsynchronousRequest(NetworkManager.getRequestObject(apiMethod, bodyData:bodyData ), queue: NSOperationQueue.mainQueue(), completionHandler:{
                ( response:NSURLResponse!,  data:NSData!, error:NSError!) -> Void in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                println(resstr)
                
                if((resstr) != nil){
                    
                    
                    var localError: NSError?
                    var rootDictionary: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
                    
                    //Remove existing profile
                    RevenueModel.deleteAllRevenueObjects()
                    
                    //Save the latest profile dictionary to local database
                    RevenueModel.initWithDictionary(rootDictionary as! NSDictionary)
                    
                    var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
                    let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
                    
                    var fromMonth:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_from_month_key)
                    var fromYear:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_from_year_key)
                    var toMonth:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_to_month_key)
                    var toYear:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_to_year_key)
                    
                    
                    var aPersonDictionary = ["sessionId":"\(sessionId)", "fromYear":fromYear, "fromMonth":fromMonth, "toYear":toYear, "toMonth":toMonth]
                    
                    var bytes = NSJSONSerialization.dataWithJSONObject(aPersonDictionary, options: NSJSONWritingOptions.allZeros, error: nil)
                    let resstr = NSString(data:bytes!, encoding: NSUTF8StringEncoding)
                    
                    
                    //Call Other servicess for getting remaining data
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        
                        
                       
                        self.getProjectsServiceCall(GlobalVariables.RequestAPIMethods.GetActiveProjects.rawValue, bodyData: resstr!, viewController: viewController)
                        
                    }
                    
                    
                }else{
                    
                    
                }
                
            })
        }else{
            
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please check the internet connection."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    // MARK: Getting Projects data
    class func getProjectsServiceCall(apiMethod:NSString, bodyData:NSString, viewController:UIViewController) {
        
        let reachability = Reachability.reachabilityForInternetConnection()
        
        //Check for internet connection
        if(Reachability.isReachable(reachability)() == true){
            
            //Show the progress bard
            let progressHUD = MBProgressHUD.showHUDAddedTo(viewController.view, animated: true)
            progressHUD.labelText = "Loading..."
            
            
            NSURLConnection.sendAsynchronousRequest(NetworkManager.getRequestObject(apiMethod, bodyData:bodyData ), queue: NSOperationQueue.mainQueue(), completionHandler:{
                ( response:NSURLResponse!,  data:NSData!, error:NSError!) -> Void in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                println(resstr)
                
                if((resstr) != nil){
                    
                    
                    var localError: NSError?
                    var rootDictionary: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
                    
                    //Remove existing profile
                    ProjectModel.deleteAllProjectObjects()
                    
                    //Save the latest profile dictionary to local database
                    ProjectModel.initWithDictionary(rootDictionary as! NSDictionary)
                                    
                    
                    //Navigate to slider view of dashboard
                    let containerViewController = ContainerViewController()
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController = containerViewController
                                   
                }else{
                    
                    
                }
                
            })
        }else{
            
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please check the internet connection."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    // MARK: Passsword Changing
    class func changePasswordDataServiceCall(apiMethod:NSString, bodyData:NSString, viewController:UIViewController) {
        
        let reachability = Reachability.reachabilityForInternetConnection()
        
        //Check for internet connection
        if(Reachability.isReachable(reachability)() == true){
            
            //Show the progress bard
            let progressHUD = MBProgressHUD.showHUDAddedTo(viewController.view, animated: true)
            progressHUD.labelText = "Loading..."
            
            
            NSURLConnection.sendAsynchronousRequest(NetworkManager.getRequestObject(apiMethod, bodyData:bodyData ), queue: NSOperationQueue.mainQueue(), completionHandler:{
                ( response:NSURLResponse!,  data:NSData!, error:NSError!) -> Void in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                println(resstr)
                
                if((resstr) != nil){
                    
                    var localError: NSError?
                    var jsonDictionary: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
                    
                    if let rootDictionary = jsonDictionary as? [String: AnyObject] {
                        
                        
                        //return (true, rootDictionary)
                        
                        if let resultString:NSString = rootDictionary["result"] as? NSString {
                            
                            println(resultString)
                            
                            if(resultString.isEqualToString("Invalid Password") || resultString.isEqualToString("Invalid Session")){
                                
                                let alertController = UIAlertController(title:"Executive Dashboard", message:resultString as String
                                    , preferredStyle: UIAlertControllerStyle.Alert)
                                
                                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                
                                viewController.presentViewController(alertController, animated: true, completion: nil)
                                
                            }else{
                                
                                
                                //Save session id to user defaults
                                if let messsage:NSString = rootDictionary["result"] as? NSString{
                                    
                                    let alertController = UIAlertController(title:"Executive Dashboard", message:messsage as String
                                        , preferredStyle: UIAlertControllerStyle.Alert)
                                    
                                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                    
                                    viewController.presentViewController(alertController, animated: true, completion: nil)

                                    
                                }else{
                                    
                                    let alertController = UIAlertController(title:"Executive Dashboard", message:"Session id not recieved."
                                        , preferredStyle: UIAlertControllerStyle.Alert)
                                    
                                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                    
                                    viewController.presentViewController(alertController, animated: true, completion: nil)
                                }
                                
                                
                            }
                            
                        }
                    }
                    
                }else{
                    
                    
                }
                
            })
        }else{
            
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please check the internet connection."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    // MARK: Logout
    class func logoutDataServiceCall(apiMethod:NSString, bodyData:NSString, viewController:UIViewController) {
        
        let reachability = Reachability.reachabilityForInternetConnection()
        
        //Check for internet connection
        if(Reachability.isReachable(reachability)() == true){
            
            //Show the progress bard
            let progressHUD = MBProgressHUD.showHUDAddedTo(viewController.view, animated: true)
            progressHUD.labelText = "Loading..."
            
            
            NSURLConnection.sendAsynchronousRequest(NetworkManager.getRequestObject(apiMethod, bodyData:bodyData ), queue: NSOperationQueue.mainQueue(), completionHandler:{
                ( response:NSURLResponse!,  data:NSData!, error:NSError!) -> Void in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                println(resstr)
                
                if((resstr) != nil){
                    
                    var localError: NSError?
                    var jsonDictionary: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
                    
                    if let rootDictionary = jsonDictionary as? [String: AnyObject] {
                        
                        
                        //return (true, rootDictionary)
                        
                        if let resultString:NSString = rootDictionary["result"] as? NSString {
                            
                            println(resultString)
                            
                            if(resultString.isEqualToString("Invalid Session")){
                                
                                let alertController = UIAlertController(title:"Executive Dashboard", message:resultString as String
                                    , preferredStyle: UIAlertControllerStyle.Alert)
                                
                                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                
                                viewController.presentViewController(alertController, animated: true, completion: nil)
                                
                            }else{
                                
                                GlobalSettings.updateSignedInDefaultValue(false)
                                GlobalSettings.updateRemeberMeDefaultValue(false)
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let viewController:UIViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! UIViewController
                                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                appDelegate.window?.rootViewController = viewController

                                                            
                            }
                            
                        }
                    }
                    
                }else{
                    
                    
                }
                
            })
        }else{
            
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please check the internet connection."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    // MARK: Forgot Password
    class func forgotPasswordDataServiceCall(apiMethod:NSString, bodyData:NSString, viewController:UIViewController) {
        
        let reachability = Reachability.reachabilityForInternetConnection()
        
        //Check for internet connection
        if(Reachability.isReachable(reachability)() == true){
            
            //Show the progress bard
            let progressHUD = MBProgressHUD.showHUDAddedTo(viewController.view, animated: true)
            progressHUD.labelText = "Loading..."
            
            
            NSURLConnection.sendAsynchronousRequest(NetworkManager.getRequestObject(apiMethod, bodyData:bodyData ), queue: NSOperationQueue.mainQueue(), completionHandler:{
                ( response:NSURLResponse!,  data:NSData!, error:NSError!) -> Void in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                println(resstr)
                
                if((resstr) != nil){
                    
                    var localError: NSError?
                    var jsonDictionary: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
                    
                    if let rootDictionary = jsonDictionary as? [String: AnyObject] {
                        
                        
                        //return (true, rootDictionary)
                        
                        if let resultString:NSString = rootDictionary["result"] as? NSString {
                            
                            println(resultString)
                            
                            if(resultString.isEqualToString("Invalid Password") || resultString.isEqualToString("Invalid Session")){
                                
                                let alertController = UIAlertController(title:"Executive Dashboard", message:resultString as String
                                    , preferredStyle: UIAlertControllerStyle.Alert)
                                
                                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                
                                viewController.presentViewController(alertController, animated: true, completion: nil)
                                
                            }else{
                                
                                
                                //Save session id to user defaults
                                if let messsage:NSString = rootDictionary["result"] as? NSString{
                                    
                                    let alertController = UIAlertController(title:"Executive Dashboard", message:messsage as String
                                        , preferredStyle: UIAlertControllerStyle.Alert)
                                    
                                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                    
                                    viewController.presentViewController(alertController, animated: true, completion: nil)
                                    
                                    viewController.dismissViewControllerAnimated(true, completion: nil)
                                    
                                }else{
                                    
                                    let alertController = UIAlertController(title:"Executive Dashboard", message:"Session id not recieved."
                                        , preferredStyle: UIAlertControllerStyle.Alert)
                                    
                                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                    
                                    viewController.presentViewController(alertController, animated: true, completion: nil)
                                }
                                
                                
                            }
                            
                        }else{
                            
                            let alertController = UIAlertController(title:"Executive Dashboard", message:"Invalid response."
                                , preferredStyle: UIAlertControllerStyle.Alert)
                            
                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                            
                            viewController.presentViewController(alertController, animated: true, completion: nil)
                        }
                    }
                    
                }else{
                    
                    
                }
                
            })
        }else{
            
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please check the internet connection."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    
    // MARK: Register device
    class func registerDeviceServiceCall(apiMethod:NSString, bodyData:NSString, viewController:UIViewController) {
        
        let reachability = Reachability.reachabilityForInternetConnection()
        
        //Check for internet connection
        if(Reachability.isReachable(reachability)() == true){
            
            //Show the progress bard
            let progressHUD = MBProgressHUD.showHUDAddedTo(viewController.view, animated: true)
            progressHUD.labelText = "Loading..."
            
            
            NSURLConnection.sendAsynchronousRequest(NetworkManager.getRequestObject(apiMethod, bodyData:bodyData ), queue: NSOperationQueue.mainQueue(), completionHandler:{
                ( response:NSURLResponse!,  data:NSData!, error:NSError!) -> Void in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                println(resstr)
                
                if((resstr) != nil){
                    
                    var localError: NSError?
                    var jsonDictionary: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &localError)
                    
                    if let rootDictionary = jsonDictionary as? [String: AnyObject] {
                        
                        
                        //return (true, rootDictionary)
                        
                        if let resultString:NSString = rootDictionary["result"] as? NSString {
                            
                            println(resultString)
                            
                            if(resultString.isEqualToString("Invalid Password") || resultString.isEqualToString("Invalid Session")){
                                
                                let alertController = UIAlertController(title:"Executive Dashboard", message:resultString as String
                                    , preferredStyle: UIAlertControllerStyle.Alert)
                                
                                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                                
                                viewController.presentViewController(alertController, animated: true, completion: nil)
                                
                            }else{
                                
                                println("Device registered")

                                var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
                                let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
                                self.getProfileDataServiceCall(GlobalVariables.RequestAPIMethods.GetProfile.rawValue, bodyData: jsonString, viewController: viewController)

                                
                            }
                            
                        }else{
                            
                            let alertController = UIAlertController(title:"Executive Dashboard", message:"Invalid response."
                                , preferredStyle: UIAlertControllerStyle.Alert)
                            
                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                            
                            viewController.presentViewController(alertController, animated: true, completion: nil)
                        }
                    }
                    
                }else{
                    
                    
                }
                
            })
        }else{
            
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please check the internet connection."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }

}
