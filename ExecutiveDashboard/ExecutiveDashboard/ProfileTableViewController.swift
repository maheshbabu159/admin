
//
//  ProfileTableViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/22/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit



enum ProfileSectionEnums: Int {
    
    // enumeration definition goes here
    case kPersionalInformationSection = 0
    case kEmployeeInformationSection = 1
}
enum ProfilePersonalInformationEnums : Int {
   
    case kName = 0
    case kBloodGroup = 1
    case kPhone = 2
    case kEmail = 3
    case kAddress = 4
    case kMaritalStatus = 5
   
    
    static var count: Int {
        
        var count = 0
        
        while let _ = self(rawValue: ++count) { }
        
        return count
    }
}


extension ProfilePersonalInformationEnums : Printable {
    
    var description: String {
        
        switch (self) {
        case kName:
            return "Name"
        case kBloodGroup:
            return "Blood Group"
        case kPhone:
            return "Phone"
        case kEmail:
            return "Email"
        case kAddress:
            return "Address"
        case kMaritalStatus:
            return "Marital Status"
    
        }
    }
    
}
enum ProfileEmployeeInformationEnums : Int {
   
    // enumeration definition goes here
    case kAssociateId = 0
    case kGrade = 1
    case kDateofJoin = 2
    case kDepartment = 3
    case kDesignation = 4
    case kReportingTo = 5

    
    
    static var count: Int {
        
        var count = 0
        
        while let _ = self(rawValue: ++count) { }
        
        return count
    }
}


extension ProfileEmployeeInformationEnums : Printable {
    
    var description: String {
        
        switch (self) {
        case kAssociateId:
            return "Associate Id"
        case kGrade:
            return "Grade"
        case kDateofJoin:
            return "Date of Join"
        case kDepartment:
            return "Department"
        case kDesignation:
            return "Designation"
        case kReportingTo:
            return "Reporting To"
            
        }
    }
    
}

class ProfileTableViewController: UITableViewController {
    var delegate: CenterViewControllerDelegate?

 
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationController?.navigationBarHidden = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 6
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        
        let profilesArray:NSArray = ProfileModel.getAllProfileObjects()
        
        if let profile:Profile = profilesArray[0] as? Profile{
            
            var imageView : UIImageView = cell.contentView.viewWithTag(1000) as! UIImageView
            var titleLable : UILabel = cell.contentView.viewWithTag(1001) as! UILabel
            var valueLable : UILabel = cell.contentView.viewWithTag(1002) as! UILabel
  
            switch indexPath.section {
                
            case ProfileSectionEnums.kPersionalInformationSection.rawValue:
                
                switch indexPath.row {
                    
                case ProfilePersonalInformationEnums.kName.rawValue:
                    
                    titleLable.text = ProfilePersonalInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.username
                    
                case ProfilePersonalInformationEnums.kBloodGroup.rawValue:
                    
                    titleLable.text = ProfilePersonalInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.bloodGroup

                case ProfilePersonalInformationEnums.kPhone.rawValue:
                    
                    titleLable.text = ProfilePersonalInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.phone

                case ProfilePersonalInformationEnums.kEmail.rawValue:
                    
                    titleLable.text = ProfilePersonalInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.email

                case ProfilePersonalInformationEnums.kAddress.rawValue:
                    
                    titleLable.text = ProfilePersonalInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.address

                default:
                    
                    titleLable.text = ProfilePersonalInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.maritalStatus

                }
                
                
            default:
                
                
                switch indexPath.row {
                    
                    
                case ProfileEmployeeInformationEnums.kAssociateId.rawValue:
                    
                    titleLable.text = ProfileEmployeeInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.associateId

                case ProfileEmployeeInformationEnums.kGrade.rawValue:
                    
                    titleLable.text = ProfileEmployeeInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.grade

                case ProfileEmployeeInformationEnums.kDateofJoin.rawValue:
                    
                    titleLable.text = ProfileEmployeeInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.joinDate_iso

                case ProfileEmployeeInformationEnums.kDepartment.rawValue:
                    
                    titleLable.text = ProfileEmployeeInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.department

                case ProfileEmployeeInformationEnums.kDesignation.rawValue:
                    
                    titleLable.text = ProfileEmployeeInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.designation

                default:
                    
                    titleLable.text = ProfileEmployeeInformationEnums(rawValue: indexPath.row)?.description
                    valueLable.text = profile.reportingTo

                }
            }
            
            
            
            return cell;
        }
    
        return cell
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        switch section {
        case 0:
            return "Personal Information"
        
        default:
            return "Employee Information"
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        return 44
        
        
    }
    // MARK: Button actions
    @IBAction func menuButtonClick(sender: AnyObject) {
        
        delegate?.toggleLeftPanel?()
    }
    
   }
