//
//  NewObjectViewController.swift
//  ExecutiveDashboard
//
//  Created by maheshbabu.somineni on 7/29/15.
//
//

import UIKit
import MBProgressHUD
import AFNetworking

enum SelectionIndexEnums : Int{
    
    case PlatformsSelection = 0
    case WebsiteVisits = 1
    case Revenue = 2
    
}

enum ProjectProperties : Int{
    
    case ProjectName = 0
    case Department = 1
    case ClientName = 2
    case ClientLocation = 3
    case StartDate = 4
    case State = 5
    case Status = 6
    case ProgramManager = 7
    case ProjectManager = 8
    case DeliveryHead = 9
    
}
protocol NewObjectViewControllerDelegate {
    
    func refreshHomeTableViewWithServiceData()
    
}
class NewObjectViewController: UITableViewController {
    var taskIndex:Int = 0
    var selectionIndex:Int = 0
    var projectCount:Int = 1
    var platform:NSString = "value"
    var delegate: NewObjectViewControllerDelegate?
    var visitsMonth:NSString = "mm"
    var visitsYear:NSString = "yyyy"
    var revenueMonth:NSString = "mm"
    var revenueYear:NSString = "yyyy"

    var amount:Int = 0
    var count:Int = 0
    var datePicker: UIDatePicker!
    var pickerView: UIPickerView!

    //...teja
    var fromEdit: Bool = false
    var editSourceObj:NSManagedObject?
    
    var managersArray:NSArray?
    var umProject:UMProject?
    
    @IBOutlet weak var saveEditNavBtn: UIBarButtonItem!
   // var

    override func viewDidLoad() {
        super.viewDidLoad()

        managersArray = NSArray()
        umProject = UMProject()
        self.pickerView = UIPickerView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        
        pickerView.delegate = self
        pickerView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        if fromEdit{
            
            switch taskIndex {
                
            case TaskIndex.Projects.rawValue:
                
                if let value =  editSourceObj!.valueForKey("projectCount") as? String{
                    
                    projectCount = value.toInt()!
                }
                if let value =  editSourceObj!.valueForKey("platform") as? String{
                    
                    platform = value
                }
            case TaskIndex.Users.rawValue:
                
                if let value =  editSourceObj!.valueForKey("amount") as? String{
                    
                    amount = value.toInt()!
                }
                if let value =  editSourceObj!.valueForKey("month") as? String{
                    
                    revenueMonth = "\(value)"
                }
                if let value =  editSourceObj!.valueForKey("year") as? String{
                    
                    revenueYear =  "\(value)"
                }
                
            case TaskIndex.WebsiteVisits.rawValue:
                
                if let value =  editSourceObj!.valueForKey("count") as? String{
                    
                    count = value.toInt()!
                }
                if let value =  editSourceObj!.valueForKey("month") as? String{
                    
                    visitsMonth = value
                }
                if let value =  editSourceObj!.valueForKey("year") as? String{
                    
                    visitsYear = value
                }
            default:
                println("")
                
            }//switch
        }
        self.tableView.reloadData()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view.

        self.tableView.reloadData()
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
        switch taskIndex {
            
        case TaskIndex.Projects.rawValue:
            
            return 10
            //objectsArray = ProjectModel.getAllProjectObjects() as! NSMutableArray
            
        case TaskIndex.Users.rawValue:
            
            return 2
            
        default:
            
            return 2
            
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        switch taskIndex {
            
        case TaskIndex.Projects.rawValue:
            
            switch indexPath.row  {
             
            case ProjectProperties.ProjectName.rawValue:
                
                cell.textLabel?.text = "Project Name"
                
                if let value:String = umProject?.name{
                    
                    cell.detailTextLabel?.text = value
                }
            case ProjectProperties.Department.rawValue:
                
                cell.textLabel?.text = "Department"
                if let value:String = umProject?.department{
                    
                    cell.detailTextLabel?.text = value
                }
            case ProjectProperties.ClientName.rawValue:
                
                cell.textLabel?.text = "Client Name"
                if let value:String = umProject?.clientName{
                    
                    cell.detailTextLabel?.text = value
                }
            case ProjectProperties.ClientLocation.rawValue:
                
                cell.textLabel?.text = "Client Location"
                if let value:String = umProject?.clientLocation{
                    
                    cell.detailTextLabel?.text = value
                }
            case ProjectProperties.StartDate.rawValue:
                
                cell.textLabel?.text = "Start Date"
                if let value:String = umProject?.startDate{
                    
                    cell.detailTextLabel?.text = value
                }
            case ProjectProperties.State.rawValue:
                
                cell.textLabel?.text = "State"
                if let value:String = umProject?.state{
                    
                    cell.detailTextLabel?.text = value
                }
            case ProjectProperties.Status.rawValue:
                
                cell.textLabel?.text = "Status"
                if let value:String = umProject?.status{
                    
                    cell.detailTextLabel?.text = value
                }
            case ProjectProperties.ProgramManager.rawValue:
                
                cell.textLabel?.text = "Program Manager"
                /*if let value:String = umProject?.programManagerDictionary[]{
                    
                    cell.detailTextLabel?.text = value
                }*/
            case ProjectProperties.ProjectManager.rawValue:
                
                cell.textLabel?.text = "Project Manager"
                
                if let dictionary:NSDictionary = self.umProject?.programManagerDictionary{
                    
                    if let value:String = dictionary["username"] as? String{
                        
                        cell.detailTextLabel?.text = value
                    }
                }
            default:
                
                cell.textLabel?.text = "Delivery Head"
                if let value:String = umProject?.name{
                    
                    cell.detailTextLabel?.text = value
                }
            }
        case TaskIndex.Users.rawValue:
            
            if(indexPath.row == 0){
                cell.textLabel?.text = "Amount"
                cell.detailTextLabel?.text = "\(amount)"

            }else{
                
                cell.textLabel?.text = "Date"
                cell.detailTextLabel?.text = "\(revenueMonth)" +  "/" + "\(revenueYear)"
            }

        default:
            
            if(indexPath.row == 0){
                
                cell.textLabel?.text = "Count"
                cell.detailTextLabel?.text = "\(count)"

            }else{
                
                cell.textLabel?.text = "Date"
                cell.detailTextLabel?.text =  "\(visitsMonth)" + "/" + "\(visitsYear)"
            }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "NewObjectToValuesSelectionViewSegue") {
            
            // pass data to next view
            let destinationViewController:ValueSelectionViewController = segue.destinationViewController as! ValueSelectionViewController
            destinationViewController.selectionIndex = selectionIndex
            destinationViewController.delegate = self
        }
    }

}
// Mark: Table View Delegate

extension NewObjectViewController: UITableViewDelegate {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Configure the cell...
        switch taskIndex {
            
        case TaskIndex.Projects.rawValue:
            
            switch indexPath.row  {
                
            case ProjectProperties.ProjectName.rawValue:
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: GlobalVariables.applicationName, message: "Please enter project name.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    
                    self.projectCount = textField.text.toInt()!
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
                
            case ProjectProperties.Department.rawValue:
               
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: GlobalVariables.applicationName, message: "Please enter project name.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    
                    self.projectCount = textField.text.toInt()!
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
               
            case ProjectProperties.ClientName.rawValue:
                
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: GlobalVariables.applicationName, message: "Please enter project name.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    
                    self.projectCount = textField.text.toInt()!
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
            case ProjectProperties.ClientLocation.rawValue:
                
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: GlobalVariables.applicationName, message: "Please enter project name.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    
                    self.projectCount = textField.text.toInt()!
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
            case ProjectProperties.StartDate.rawValue:
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: GlobalVariables.applicationName, message: "Please enter project name.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    
                    self.projectCount = textField.text.toInt()!
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
                
            case ProjectProperties.State.rawValue:
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: GlobalVariables.applicationName, message: "Please enter project name.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    
                    self.projectCount = textField.text.toInt()!
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
                
            case ProjectProperties.Status.rawValue:
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: GlobalVariables.applicationName, message: "Please enter project name.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    
                    self.projectCount = textField.text.toInt()!
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
                
            case ProjectProperties.ProgramManager.rawValue:
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: GlobalVariables.applicationName, message: "Please enter project name.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    
                    self.projectCount = textField.text.toInt()!
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
                
            case ProjectProperties.ProjectManager.rawValue:
                
                getAllProjectManagersServiceCall(GlobalVariables.RequestAPIMethods.GetAllProjectManagers.rawValue);
                
            default:
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: GlobalVariables.applicationName, message: "Please enter project name.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    
                    self.projectCount = textField.text.toInt()!
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        
        case TaskIndex.Users.rawValue:
            
            if(indexPath.row == 0){
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: "Executive Dashboard", message: "Please enter projects count.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    
                    self.amount = textField.text.toInt()!
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
                
            }else{
                
                self.showDatePickerInAlert(0, title: "From Date")

            }
            
        default:
            
            if(indexPath.row == 0){
                
                //1. Create the alert controller.
                var alert = UIAlertController(title: "Executive Dashboard", message: "Please enter projects count.", preferredStyle: .Alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                    
                    textField.text = ""
                    
                })
                
                //3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    
                    if let value = textField.text.toInt() {
                        
                        self.count = value

                    }
                    
                    self.tableView.reloadData()
                }))
                
                // 4. Present the alert.
                self.presentViewController(alert, animated: true, completion: nil)
                
            }else{
                
                self.showDatePickerInAlert(0, title: "From Date")

            }
            
        }
        

    }
    
    func showDatePickerInAlert(tag:Int, title:NSString){
        
        //Creating view to add datepicker
        var viewDatePicker: UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        viewDatePicker.backgroundColor = UIColor.clearColor()
        
        
        //Initializing date picker
        self.datePicker = UIDatePicker(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        self.datePicker.datePickerMode = UIDatePickerMode.Date
        self.datePicker.addTarget(self, action: nil, forControlEvents: UIControlEvents.ValueChanged)
        
        
        viewDatePicker.addSubview(self.datePicker)
        
        let alertController = UIAlertController(title: title as String, message:"\n\n\n\n\n\n\n\n\n", preferredStyle: .ActionSheet)
        alertController.view.addSubview(viewDatePicker)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
            self.dateSelected(0)

        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            
            // ...
        }
        
    }

    @IBAction func saveButtonClick(sender:UIButton){
        
       
           // Configure the cell...
          switch taskIndex {
            
          case TaskIndex.Projects.rawValue:
            
            addProjectsService()
            
          case TaskIndex.Users.rawValue:
            
            addRevenueService()

          default:
            
            addWebsiteVisitsService()
            
           }
        
    }
    func addProjectsService(){
        
         var paramsDictionary = ["platform":"\(platform)", "projectCount":projectCount]
        
        //...teja start
        var objId:String = String()
        if(fromEdit)
        {
            if let value =  editSourceObj!.valueForKey("objectId") as? String
            {
                objId = value
            }
        }
        else{
            
          objId = ""
        }
        //...teja end
        
        let manager = NetworkManager.initAFNetworkManager()
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        if(fromEdit)
        {
            manager.PUT(GlobalVariables.rest_api_url + (GlobalVariables.RequestAPIMethods.ActiveProject.rawValue as String)+"/"+objId,parameters: paramsDictionary,
                
                success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                    
                    self.delegate?.refreshHomeTableViewWithServiceData()
                    self.navigationController?.popViewControllerAnimated(true)
                },
                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                    
                    
                    //Navigate to slider view of dashboard
                    let containerViewController = ContainerViewController()
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController = containerViewController
                }
            )

        }
        else
        {
            manager.POST(GlobalVariables.rest_api_url + (GlobalVariables.RequestAPIMethods.ActiveProject.rawValue as String),parameters: paramsDictionary,
                
                success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                    
                    self.delegate?.refreshHomeTableViewWithServiceData()
                    self.navigationController?.popViewControllerAnimated(true)
                },
                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                    
                    
                    //Navigate to slider view of dashboard
                    let containerViewController = ContainerViewController()
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController = containerViewController
                }
            )
       }
    }
    func dateSelected(tag:Int)
    {
        var selectedDate:NSString =  self.dateformatterDateTime(datePicker.date)
        
        println(selectedDate)
        
        let range = NSRange(location:0, length:2)
        
        var month:NSString = selectedDate.substringWithRange(NSRange(location:0, length:2))
        
        var year:NSString = selectedDate.substringWithRange(NSRange(location:4, length:4))
        
        
        // Configure the cell...
        switch taskIndex {
            
        case TaskIndex.Users.rawValue:
            
            revenueMonth = month
            revenueYear = year
            
        default:
            
            visitsYear = year
            visitsMonth = month
        }

        self.tableView.reloadData()
    }
    func dateformatterDateTime(date: NSDate) -> NSString
    {
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        return dateFormatter.stringFromDate(date)
        
        
        
    }
    func datePickerSelected(sender: UIDatePicker) {
        
        
        
    }
    func addRevenueService(){
        
        //...teja start
        var objId:String = String()
        if(fromEdit)
        {
            if let value =  editSourceObj!.valueForKey("objectId") as? String
            {
                objId = value
            }
        }
        else
        {
            objId = ""
        }
        //...teja end
        
        
        var year:Int = 0
        var month:Int = 0
        var amunt:Int = 0

        if let revenuYear = revenueYear as? String {
            
            year = revenuYear.toInt()!

        }
        if let revenuMonth = revenueMonth as? String {
            
            month = revenuMonth.toInt()!
            
        }
        
        var paramsDictionary = ["year":year, "month":month,"amount":amount]
        
        let manager = NetworkManager.initAFNetworkManager()
        
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        if(fromEdit)
        {
            manager.PUT(GlobalVariables.rest_api_url + (GlobalVariables.RequestAPIMethods.Revenue.rawValue as String)+"/"+objId,parameters: paramsDictionary,
                
                success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                    
                    self.delegate?.refreshHomeTableViewWithServiceData()
                    self.navigationController?.popViewControllerAnimated(true)
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
        else
        {
        manager.POST(GlobalVariables.rest_api_url + (GlobalVariables.RequestAPIMethods.Revenue.rawValue as String),parameters: paramsDictionary,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                self.delegate?.refreshHomeTableViewWithServiceData()
                self.navigationController?.popViewControllerAnimated(true)
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
        
    }
    func addWebsiteVisitsService(){
        
        
        //...teja start
        var objId:String = String()
        if(fromEdit)
        {
            if let value =  editSourceObj!.valueForKey("objectId") as? String
            {
                objId = value
            }
        }
        else
        {
            objId = ""
        }
        //...teja end
        
        var year:Int = 0
        var month:Int = 0
        var amunt:Int = 0
        
        if let revenuYear = visitsYear as? String {
            
            year = revenuYear.toInt()!
            
        }
        if let revenuMonth = visitsMonth as? String {
            
            month = revenuMonth.toInt()!
            
        }
        
        var paramsDictionary = ["year":year, "month":month,"count":count]
        
        
        let manager = NetworkManager.initAFNetworkManager()
        
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        if(fromEdit)
        {
            manager.PUT(GlobalVariables.rest_api_url + (GlobalVariables.RequestAPIMethods.WebsiteVisit.rawValue as String)+"/"+objId,parameters: paramsDictionary,
                
                success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                    
                    self.delegate?.refreshHomeTableViewWithServiceData()
                    self.navigationController?.popViewControllerAnimated(true)
                },
                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                    
                    let containerViewController = ContainerViewController()
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController = containerViewController
                }
            )

        }
        else
        {
        manager.POST(GlobalVariables.rest_api_url + (GlobalVariables.RequestAPIMethods.WebsiteVisit.rawValue as String),parameters: paramsDictionary,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                self.delegate?.refreshHomeTableViewWithServiceData()
                self.navigationController?.popViewControllerAnimated(true)
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
    }
    func getAllProjectManagersServiceCall(flag:NSString){
        
        let manager = NetworkManager.initAFNetworkManager()
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        manager.POST(GlobalVariables.request_url + (flag as String) ,parameters: nil,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                
                //Convert dictionary values to managed data object.
                if let resultArray = jsonDictionary["result"] as? NSArray{
                    
                    self.managersArray = resultArray
                    
                }
                
                self.showPickerView(flag)
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
    func showPickerView(flag:NSString){
        
        //Creating view to add datepicker
        var viewDatePicker: UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        viewDatePicker.backgroundColor = UIColor.clearColor()

        viewDatePicker.addSubview(self.pickerView)
        
        let alertController = UIAlertController(title: GlobalVariables.applicationName as String, message:"\n\n\n\n\n\n\n\n\n", preferredStyle: .ActionSheet)
        alertController.view.addSubview(viewDatePicker)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
            
            // ...
        }

    }
}

extension NewObjectViewController: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(colorPicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.managersArray!.count
    }
}

extension NewObjectViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        
        if let dictioary:NSDictionary = self.managersArray?.objectAtIndex(row) as? NSDictionary{
            
            if let value:String = dictioary["username"] as? String{
                
                return value
                
            }else{
                
                return "No Value"
            }
        }else{
            
            return "No Value"
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
      
        if let dictioary:NSDictionary = self.managersArray?.objectAtIndex(row) as? NSDictionary{
            
            umProject?.programManagerDictionary = dictioary as? Dictionary<String, AnyObject>
        }
        
        self.tableView.reloadData()
    }
}
extension NewObjectViewController: ValueSelectionViewControllerDelegate {
    
    func sendSelectedValue(value:NSString){
        
        self.platform = value
        
        self.tableView.reloadData()
    }
    
    
}

