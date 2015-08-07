//
//  ValueSelectionViewController.swift
//  ExecutiveDashboard
//
//  Created by maheshbabu.somineni on 7/29/15.
//
//

import UIKit
import MBProgressHUD
import AFNetworking

protocol ValueSelectionViewControllerDelegate {

    func sendSelectedValue(value:NSString)

}
class ValueSelectionViewController: UITableViewController {

    var selectionIndex:Int = 0
    var objectsArray : NSArray = NSArray()
    var delegate: ValueSelectionViewControllerDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.callServiceForValues();
        
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
        switch selectionIndex {
            
        case SelectionIndexEnums.PlatformsSelection.rawValue:
                        
            if let object:NSManagedObject = objectsArray[indexPath.row] as? NSManagedObject {
         
                if let value =  object.valueForKey("descr") as? String{
                
                    cell.textLabel?.text = value
               
                }
            }
            
        case TaskIndex.Users.rawValue:
            
            objectsArray = WebsiteVisitModel.getAllWebsiteVisitObjects() as! NSMutableArray
            
        default:
            
            objectsArray = RevenueModel.getAllRevenueObjects() as! NSMutableArray
            
        }
        
        return cell
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func callServiceForValues(){
    
        
        switch selectionIndex {
            
        case SelectionIndexEnums.PlatformsSelection.rawValue:
            
            self.getAllPlatforms()
            
        default:
            
            self.getAllPlatforms()

        }
        
    }
    
    func getAllPlatforms(){
        
        
        let manager = NetworkManager.initAFNetworkManager()
        
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        manager.GET(GlobalVariables.rest_api_url + (GlobalVariables.RequestAPIMethods.Platform.rawValue as String),parameters: nil,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                //return (true, rootDictionary)
                
                
                //Remove existing profile
                TechnologiesModel.deleteAllObjects()
                
                //Save the latest profile dictionary to local database
                TechnologiesModel.initWithDictionary(jsonDictionary as NSDictionary)
                
                
                self.refreshTableView()
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                
                
                /*//Hide progress bar
                progressHUD.hide(true)
                
                let alertController = UIAlertController(title:"Executive Dashboard", message:error.description
                , preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)*/
                
                
                //Navigate to slider view of dashboard
                let containerViewController = ContainerViewController()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.rootViewController = containerViewController
            }
        )

    }
    func refreshTableView(){
        
        switch selectionIndex {
            
        case SelectionIndexEnums.PlatformsSelection.rawValue:
            
            objectsArray = TechnologiesModel.getAllObjects() as NSArray
            
        case TaskIndex.WebsiteVisits.rawValue:
            
            objectsArray = WebsiteVisitModel.getAllWebsiteVisitObjects() as! NSMutableArray
            
        default:
            
            objectsArray = RevenueModel.getAllRevenueObjects() as! NSMutableArray
            
        }
        
        self.tableView.reloadData()
        
    }

}
// Mark: Table View Delegate

extension ValueSelectionViewController: UITableViewDelegate {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch selectionIndex {
            
        case SelectionIndexEnums.PlatformsSelection.rawValue:
            
            if let object:NSManagedObject = objectsArray[indexPath.row] as? NSManagedObject {
                
                if let value =  object.valueForKey("descr") as? String{
                    
                    delegate?.sendSelectedValue(value)
                    self.navigationController?.popViewControllerAnimated(true)
                    
                }
            }
            
            
        case TaskIndex.WebsiteVisits.rawValue:
            
            objectsArray = WebsiteVisitModel.getAllWebsiteVisitObjects() as! NSMutableArray
            
        default:
            
            objectsArray = RevenueModel.getAllRevenueObjects() as! NSMutableArray
            
        }
        
    }
    
}