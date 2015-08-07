//
//  StatisticsContainerTableViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/17/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class StatisticsContainerTableViewController: BaseTableTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
      
        tableView.rowHeight = 44
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
        
        switch section {
            
        case 0:
            
            return WebsiteVisitModel.getWebsiteVisitsArrayCount()
            
        case 1:
            
            return RevenueModel.getRevenueArrayCount()

        default:
            
            return ProjectModel.getProjectsArrayCount()

        }
        
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    
        var titleLable : UILabel = cell.contentView.viewWithTag(1000) as! UILabel
        var descriptionLable : UILabel = cell.contentView.viewWithTag(1001) as! UILabel
        
        switch indexPath.section {
            
        case 0:
            
            let array =  WebsiteVisitModel.getAllWebsiteVisitObjects()
            
            if let object:WebsiteVisit = array[indexPath.row] as? WebsiteVisit {
                
                let month:Int? = object.month.toInt()     // firstText is UITextField
                
                titleLable.text = MonthsEnum(rawValue: month!)?.description
                descriptionLable.text = object.count

                
            }
              
        case 1:
            
            let array =  RevenueModel.getAllRevenueObjects()
            
            if let object:Revenue = array[indexPath.row] as? Revenue {
                
                let month:Int? = object.month.toInt()     // firstText is UITextField
                
                titleLable.text = MonthsEnum(rawValue: month!)?.description
                descriptionLable.text = object.amount
            }
            
            
        default:
            
            let array =  ProjectModel.getAllProjectObjects()
            
            if let object:Project = array[indexPath.row] as? Project {
                
                titleLable.text = object.name
                descriptionLable.text = object.department
                
            }
            
            
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
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
       
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.mainScreen().bounds.size.width, height: 44))

        switch section {
        case 0:
            
            let headerView:StatisticsHeaderView = StatisticsHeaderView(frame: rect, headerTitle:  "Website Visits", nameTitle: "Month", valueTitle: "Visits" )
            headerView.backgroundColor = GlobalSettings.RGBColor(GlobalVariables.blue_color)
            
            return headerView
            
        case 1:
           
            let headerView:StatisticsHeaderView = StatisticsHeaderView(frame: rect, headerTitle:  "Revenue", nameTitle: "Month", valueTitle: "Revenue" )
            headerView.backgroundColor = GlobalSettings.RGBColor(GlobalVariables.green_color)
          
            return headerView

        default:
           
            let headerView:StatisticsHeaderView = StatisticsHeaderView(frame: rect, headerTitle:  "Projects", nameTitle: "Platform", valueTitle: "Projects" )
            headerView.backgroundColor = GlobalSettings.RGBColor(GlobalVariables.yellow_color)
            
            return headerView
        }

    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44
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
