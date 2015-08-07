//
//  DefaultContainerTableViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/17/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class DefaultContainerTableViewController: BaseTableTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.rowHeight = 136.0
        
        
        
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        var titleLable : UILabel = cell.contentView.viewWithTag(1000) as! UILabel
        var imageView : UIImageView = cell.contentView.viewWithTag(1001) as! UIImageView

        switch indexPath.section {
           
           
        case 0:
           
            let count:Int = WebsiteVisitModel.getWebsiteVisitsTotal()
            
            titleLable.text = "\(count)"
            imageView.image = UIImage(named: "globe.png")
            cell.contentView.backgroundColor = GlobalSettings.RGBColor(GlobalVariables.blue_color)
            
        case 1:
           
            let count:Int = RevenueModel.getRevenueTotal()

            titleLable.text = "$" + "\(count)"
            imageView.image = UIImage(named: "dollar.png")
            cell.contentView.backgroundColor = GlobalSettings.RGBColor(GlobalVariables.green_color)

        default:
            
            let count:Int = ProjectModel.getProjectsTotal()

            titleLable.text = "\(count)"
            imageView.image = UIImage(named: "projects.png")
            cell.contentView.backgroundColor = GlobalSettings.RGBColor(GlobalVariables.yellow_color)

        }
        return cell;
      
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     
        
        switch section {
        case 0:
            return "Website Visits"
        case 1:
            return "Finance"
        default:
            return "Projects"
        }
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

    
    // MARK: - Button Clicks
    func refresh(sender:AnyObject){
    
        var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
        let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
        
        
        //Initiate profile service call
        NetworkManager.getProfileDataServiceCall("GetProfile", bodyData: jsonString, viewController: self)
        
    }
}
