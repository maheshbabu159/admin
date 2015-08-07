//
//  GraphsContainerTableViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/17/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit
import PNChartSwift

class GraphsContainerTableViewController: BaseTableTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

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
        
        switch indexPath.section{
        case 0:
            
 
            var chartLabel:UILabel = UILabel(frame: CGRectMake(0, 10, self.tableView.bounds.size.width, 30))
            
            chartLabel.textColor = PNGreenColor
            chartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
            chartLabel.textAlignment = NSTextAlignment.Center
            
            
            //Add LineChart
            var lineChart:PNLineChart = PNLineChart(frame: CGRectMake(10, 50.0, 320, 200.0))
            lineChart.yLabelFormat = "%1.1f"
            lineChart.showLabel = true
            lineChart.backgroundColor = UIColor.clearColor()
            lineChart.showCoordinateAxis = true
            //lineChart.delegate = self
            
            // Line Chart Nr.1
            var valuesArray = [CGFloat]()
            var lablesArray = [NSString]()

            let array =  WebsiteVisitModel.getAllWebsiteVisitObjects()
            
            
            for var index = 0; index < array.count; ++index {

                if let object:WebsiteVisit = array[index] as? WebsiteVisit {
                    
                    var floatValue: CGFloat = CGFloat((object.count as NSString).floatValue)
                    
                    let month:Int? = object.month.toInt()     // firstText is UITextField
                    
                    let monthDescription = MonthsEnum(rawValue: month!)?.description

                    
                    valuesArray.append(floatValue)
                    lablesArray.append(monthDescription!)
                }
            
            }
            lineChart.xLabels = lablesArray

            
            
            var data01:PNLineChartData = PNLineChartData()
            data01.color = GlobalSettings.RGBColor(GlobalVariables.blue_color)
            data01.itemCount = valuesArray.count
            data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
           
            data01.getData = ({(index: Int) -> PNLineChartDataItem in
                var yValue:CGFloat = valuesArray[index]
                var item = PNLineChartDataItem(y: yValue)
                return item
            })
            
            lineChart.chartData = [data01]
            lineChart.strokeChart()
            
            //        lineChart.delegate = self
            
            cell.contentView.addSubview(lineChart)
            cell.contentView.addSubview(chartLabel)
            
        
            return cell;

        case 1:
        
            var chartLabel:UILabel = UILabel(frame: CGRectMake(0, 10, self.tableView.bounds.size.width, 30))
            
            chartLabel.textColor = PNGreenColor
            chartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
            chartLabel.textAlignment = NSTextAlignment.Center
            
            
            //Add LineChart
            var lineChart:PNLineChart = PNLineChart(frame: CGRectMake(10, 50.0, self.tableView.bounds.size.width-10, 200.0))
            lineChart.yLabelFormat = "%1.1f"
            lineChart.showLabel = true
            lineChart.backgroundColor = UIColor.clearColor()
            lineChart.showCoordinateAxis = true
            //lineChart.delegate = self
            
            // Line Chart Nr.1
            var valuesArray = [CGFloat]()
            var lablesArray = [NSString]()
            
            let array =  RevenueModel.getAllRevenueObjects()
            
            
            for var index = 0; index < array.count; ++index {
                
                if let object:Revenue = array[index] as? Revenue {
                    
                    var floatValue: CGFloat = CGFloat((object.amount as NSString).floatValue)
                    let month:Int? = object.month.toInt()     // firstText is UITextField
                    
                    let monthDescription = MonthsEnum(rawValue: month!)?.description
                    

                    valuesArray.append(floatValue)
                    lablesArray.append(monthDescription!)

                }
                
            }
            lineChart.xLabels = lablesArray

            
            
            var data01:PNLineChartData = PNLineChartData()
            data01.color = GlobalSettings.RGBColor(GlobalVariables.green_color)
            data01.itemCount = valuesArray.count
            data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
            
            data01.getData = ({(index: Int) -> PNLineChartDataItem in
                var yValue:CGFloat = valuesArray[index]
                var item = PNLineChartDataItem(y: yValue)
                return item
            })
            
            lineChart.chartData = [data01]
            lineChart.strokeChart()
            
            //        lineChart.delegate = self
            
            cell.contentView.addSubview(lineChart)
            cell.contentView.addSubview(chartLabel)
            
            
            return cell;
            
            
            
            
        default:

            var chartLabel:UILabel = UILabel(frame: CGRectMake(0, 10, self.tableView.bounds.size.width, 30))
            
            chartLabel.textColor = PNGreenColor
            chartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
            chartLabel.textAlignment = NSTextAlignment.Center
            
            var barChart = PNBarChart(frame: CGRectMake(10, 10.0, self.tableView.bounds.size.width-10, 200.0))
            barChart.backgroundColor = UIColor.clearColor()
            //            barChart.yLabelFormatter = ({(yValue: CGFloat) -> NSString in
            //                var yValueParsed:CGFloat = yValue
            //                var labelText:NSString = NSString(format:"%1.f",yValueParsed)
            //                return labelText;
            //            })
            
            
            // remove for default animation (all bars animate at once)
            barChart.animationType = .Waterfall
            
            
            // Line Chart Nr.1
            var valuesArray = [Int]()
            var lablesArray = [NSString]()
            
            let array =  ProjectModel.getAllProjectObjects()
            
            
            for var index = 0; index < array.count; ++index {
                
                if let object:Project = array[index] as? Project {
                    
                    /*var floatValue: Int = Int((object.projectCount as NSString).intValue)
                    
                    valuesArray.append(floatValue)
                    lablesArray.append(object.platform)*/

                }
                
            }
            
            barChart.labelMarginTop = 5.0
            barChart.xLabels = lablesArray
            barChart.yValues = valuesArray
            barChart.strokeColor = GlobalSettings.RGBColor(GlobalVariables.yellow_color)
            barChart.strokeChart()
            
            
            cell.contentView.addSubview(chartLabel)
            cell.contentView.addSubview(barChart)
            
        
            return cell;

        }
        
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
