//
//  CenterViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
    
    optional func toggleLeftPanel()
    optional func collapseSidePanels()
}

class DashboardMainViewController: BaseViewController {

    
    @IBOutlet weak private var summeryContainerView: UIView!
    @IBOutlet weak private var graphsContainerView: UIView!
    @IBOutlet weak private var statsContainerView: UIView!
    
    var delegate: CenterViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = false
        
        switchContainerViews(0)

    }
    
    // MARK: Button actions
    @IBAction func menuButtonClick(sender: AnyObject) {
        
        delegate?.toggleLeftPanel?()
    }
    @IBAction func segmentValueChanged(sender: AnyObject) {
        
        if let segmentControl:UISegmentedControl =  sender as? UISegmentedControl{
            
           switchContainerViews(segmentControl.selectedSegmentIndex)
        }

        
    }
    
    func switchContainerViews(selectedSegment:Int){
        
        
        if(selectedSegment == 0){
            
            summeryContainerView.hidden = false
            graphsContainerView.hidden = true
            statsContainerView.hidden = true

            
        }else if(selectedSegment == 1){
            summeryContainerView.hidden = true
            graphsContainerView.hidden = false
            statsContainerView.hidden = true

            
        }else{
            
            summeryContainerView.hidden = true
            graphsContainerView.hidden = true
            statsContainerView.hidden = false
        }
    }
    
}

