//
//  HomeTableViewController.swift
//  ExecutiveDashboard
//
//  Created by maheshbabu.somineni on 7/29/15.
//
//

import UIKit
import MBProgressHUD
import AFNetworking

enum TaskIndex : Int{
    
    case Projects = 0
    case Users = 1
    case WebsiteVisits = 2

}
extension TaskIndex : Printable {
    
    var description: String {
        
        switch (self) {
        case Projects:
            return "Projects"
        case Users:
            return "Users"
        case WebsiteVisits:
            return "WebsiteVisits"
        }
    }
}
class HomeTableViewController: UITableViewController {

    var delegate: CenterViewControllerDelegate?
    var taskIndex:Int = 0
    var objectsArray : NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = TaskIndex(rawValue: taskIndex)?.description

        callServiceForGettingData()
        
        if(!GlobalSettings.isAdmin()){
           
            self.navigationItem.rightBarButtonItem = nil;
        }
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view.
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return objectsArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        switch taskIndex {
            
        case TaskIndex.Projects.rawValue:
            
            if let object:NSManagedObject = objectsArray[indexPath.row] as? NSManagedObject {
                
                if let value =  object.valueForKey("name") as? String{
                    //name projectCount platform

                    cell.textLabel?.text = value

                }
                if let value =  object.valueForKey("status") as? String{
                    cell.detailTextLabel?.text = value
                    
                }
            }
            
        case TaskIndex.Users.rawValue:
            
            
            if let object:NSManagedObject = objectsArray[indexPath.row] as? NSManagedObject {
                
                if let value =  object.valueForKey("username") as? String{
                    
                    cell.textLabel?.text = value
                    
                }
                if let value =  object.valueForKey("roleName") as? String{
                    
                    cell.detailTextLabel?.text = value
                    
                }
            }
            
        default:
            
            
            if let object:NSManagedObject = objectsArray[indexPath.row] as? NSManagedObject {
                
                if let value =  object.valueForKey("month") as? String{
                    
                    cell.textLabel?.text = MonthsEnum(rawValue:value.toInt()!)?.description
                    
                }
                if let value =  object.valueForKey("count") as? String{
                    
                    cell.detailTextLabel?.text = value
                }
            }
            
        }

        return cell
    }
    
//teja start
    
    //...swipe to delete or edit
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if(GlobalSettings.isAdmin()){
            
            return true
            
        }else{
            
            return false
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?
    {
        
        var editBtn = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "EDIT", handler: {(action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            self.editRecord(indexPath.row)
            
        })
        editBtn.backgroundColor = UIColor.blueColor()
        
        var deleteBtn = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "DELETE", handler: {(action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            self.deleteRecord(indexPath.row)

        })
        deleteBtn.backgroundColor = UIColor.redColor()
        
        
        return [editBtn, deleteBtn]
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
    }
    
    func editRecord(index: Int){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let destinationViewController: NewObjectViewController = storyboard.instantiateViewControllerWithIdentifier("NewObjectViewController") as! NewObjectViewController
        destinationViewController.taskIndex = taskIndex
        destinationViewController.fromEdit = true
        
        if let object:NSManagedObject = objectsArray[index] as? NSManagedObject{
         
            destinationViewController.editSourceObj = object
        }
        
        destinationViewController.delegate = self
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
    func deleteRecord(index: Int)
    {
        
        var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
        let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
        
        let manager = NetworkManager.initAFNetworkManager()
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        println("going to delete")
        
        var objId:String = String()
        if let object:NSManagedObject = objectsArray[index] as? NSManagedObject {
            
            if let value =  object.valueForKey("objectId") as? String{
                
                objId = value
            }
        }
        
        println(objId)
        var paramsDictionary = []
        
        println(GlobalVariables.rest_api_url + (GlobalVariables.RequestAPIMethods.ActiveProject.rawValue as String)+"/"+objId)

        var url1:String = String()
        switch taskIndex {
            
        case TaskIndex.Projects.rawValue:
            
            url1 = GlobalVariables.RequestAPIMethods.ActiveProject.rawValue as String
            
        case TaskIndex.Projects.rawValue:
            
            url1 = GlobalVariables.RequestAPIMethods.Revenue.rawValue as String
            
        case TaskIndex.WebsiteVisits.rawValue:
            
            url1 = GlobalVariables.RequestAPIMethods.WebsiteVisit.rawValue as String
            
        default:
            println("default")
            break
        }
        manager.DELETE(GlobalVariables.rest_api_url + url1+"/"+objId,parameters: paramsDictionary,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("success")
               
                progressHUD.hide(true)
                
                switch self.taskIndex{
                    
                case TaskIndex.Projects.rawValue:
                    
                    self.getAllProjectsServiceCall()
                    
                case TaskIndex.Users.rawValue:
                    
                    self.getAllUsersServiceCall()
                    
                case TaskIndex.WebsiteVisits.rawValue:
                    
                    self.getAllWebSitesServiceCall()
                    
                default:
                    println("")
                }
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                
                println("fail")

                //Hide progress bar
                progressHUD.hide(true)
                
                let alertController = UIAlertController(title:"Executive Dashboard", message:error.description
                    , preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        )
   
        // Configure the cell...
      /*  switch taskIndex {
            
        case TaskIndex.Projects.rawValue:
            
            if let object:NSManagedObject = objectsArray[index] as? NSManagedObject {
                
                   // cell.textLabel?.text = value
                    objectsArray.removeObjectAtIndex(index)
            }
            
            //objectsArray = ProjectModel.getAllProjectObjects() as! NSMutableArray
            
        case TaskIndex.Revenue.rawValue:
            
            
            if let object:NSManagedObject = objectsArray[index] as? NSManagedObject {
                
                objectsArray.removeObjectAtIndex(index)

            }
            
        default:
            
            
            if let object:NSManagedObject = objectsArray[index] as? NSManagedObject {
                
                objectsArray.removeObjectAtIndex(index)
            }
            
        }
*/
    }

    
    
    //teja end
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "ListToNewViewSegue") {
            // pass data to next view
            let destinationViewController:NewObjectViewController = segue.destinationViewController as! NewObjectViewController
            destinationViewController.taskIndex = taskIndex
            destinationViewController.delegate = self
        }
        
    }
    

    func callServiceForGettingData(){
        
        
        switch taskIndex {
            
        case TaskIndex.Projects.rawValue:
            
            getAllProjectsServiceCall()
            //objectsArray = ProjectModel.getAllProjectObjects() as! NSMutableArray
            
        case TaskIndex.Users.rawValue:
           
            getAllUsersServiceCall()

        default:
            
            getAllWebSitesServiceCall()

        }

    }
    
    func getAllProjectsServiceCall(){
        
        var userId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_user_id_key) as! NSString
        
        var paramsDictionary = ["userId":"\(userId)", "applicationName":"\(GlobalVariables.applicationName)"]
        
        let manager = NetworkManager.initAFNetworkManager()
        
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        manager.POST(GlobalVariables.request_url + (GlobalVariables.RequestAPIMethods.GetProjectsByUserId.rawValue as String),parameters: paramsDictionary,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                //return (true, rootDictionary)
                
                
                //Remove existing profile
                ProjectModel.deleteAllProjectObjects()
                
                //Save the latest profile dictionary to local database
                ProjectModel.initWithDictionary(jsonDictionary as NSDictionary)
                
    
                self.refreshTableView()
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let alertController = UIAlertController(title:"Executive Dashboard", message:error.description
                , preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
                
               
            }
        )
        
    }
    func getAllUsersServiceCall(){
        
        let manager = NetworkManager.initAFNetworkManager()
        
        var paramsDictionary = ["applicationName":"AdminDashboard"]

        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        manager.POST(GlobalVariables.request_url + (GlobalVariables.RequestAPIMethods.GetAllUsers.rawValue as String),parameters: paramsDictionary,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                //return (true, rootDictionary)
                
                
                //Remove existing profile
                UserModel.deleteAllObjects()
                
                //Save the latest profile dictionary to local database
                UserModel.initWithDictionary(jsonDictionary as NSDictionary)
                
                
                self.refreshTableView()
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let alertController = UIAlertController(title:"Executive Dashboard", message:error.description
                , preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        )
      
    }
    func getAllWebSitesServiceCall(){
        
        var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
        let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
        
        var fromMonth:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_from_month_key)
        var fromYear:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_from_year_key)
        var toMonth:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_to_month_key)
        var toYear:Int = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_to_year_key)
        
        
        var paramsDictionary = ["sessionId":"\(sessionId)", "fromYear":fromYear, "fromMonth":fromMonth, "toYear":toYear, "toMonth":toMonth]
        
        
        let manager = NetworkManager.initAFNetworkManager()
        
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        manager.POST(GlobalVariables.request_url + (GlobalVariables.RequestAPIMethods.GetWebsiteVisits.rawValue as String),parameters: paramsDictionary,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                //return (true, rootDictionary)
                
                
                //Remove existing profile
                WebsiteVisitModel.deleteAllWebsiteVisitObjects()
                
                //Save the latest profile dictionary to local database
                WebsiteVisitModel.initWithDictionary(jsonDictionary as NSDictionary)
                
                
                self.refreshTableView()
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let alertController = UIAlertController(title:"Executive Dashboard", message:error.description
                    , preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        )
      
    }
    func refreshTableView(){
        
        switch taskIndex {
            
        case TaskIndex.Projects.rawValue:
         
            objectsArray = ProjectModel.getAllProjectObjects() as! [Project]
            
        case TaskIndex.Users.rawValue:
            
            objectsArray = UserModel.getAllObjects() as! [User]

        default:
            
            objectsArray = WebsiteVisitModel.getAllWebsiteVisitObjects() as! [WebsiteVisit]
        }

        self.tableView.reloadData()

    }
    // MARK: Button actions
    @IBAction func menuButtonClick(sender: AnyObject) {
        
        delegate?.toggleLeftPanel?()
    }
}

// Mark: Table View Delegate

extension HomeTableViewController: UITableViewDelegate {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
}

extension HomeTableViewController: NewObjectViewControllerDelegate {
    
    func refreshHomeTableViewWithServiceData(){
        
        callServiceForGettingData()
    }
    
    
}
