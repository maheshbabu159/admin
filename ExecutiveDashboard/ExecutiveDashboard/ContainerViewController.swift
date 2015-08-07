//
//  ContainerViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    
    case BothCollapsed
    case LeftPanelExpanded
    case RightPanelExpanded
}

enum DetailsViewController {
    
    case DashboardViewController
    case RevenueViewController
    case WebsiteVisitsViewController
    case ProfileViewController
    case SettingsViewController
}




class ContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    
    var currentState: SlideOutState = .BothCollapsed {
        
        didSet {
           
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    var menuSliderViewController: SidePanelViewController?
    
    let centerPanelExpandedOffset: CGFloat = 60
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDetailsViewContoller(DetailsViewController.DashboardViewController)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = false
    }
    
    
    func addDetailsViewContoller(viewControllerEnumValue:DetailsViewController){
        
        switch(viewControllerEnumValue){
            
        case .DashboardViewController:
            
            var detailsViewController:HomeTableViewController = UIStoryboard.homeTableViewController()!
            detailsViewController.delegate = self
            detailsViewController.taskIndex = 0
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: detailsViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            centerNavigationController.didMoveToParentViewController(self)
            
           // let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
           // centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        case .RevenueViewController:
            
            var detailsViewController:HomeTableViewController = UIStoryboard.homeTableViewController()!
            detailsViewController.delegate = self
            detailsViewController.taskIndex = 1
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: detailsViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            centerNavigationController.didMoveToParentViewController(self)
            
           // let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
           // centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
            
        case .WebsiteVisitsViewController:
            
            var detailsViewController:HomeTableViewController = UIStoryboard.homeTableViewController()!
            detailsViewController.delegate = self
            detailsViewController.taskIndex = 2
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: detailsViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            centerNavigationController.didMoveToParentViewController(self)
            
          //  let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
          //  centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
            
        case .ProfileViewController:
            
            var detailsViewController:ProfileTableViewController = UIStoryboard.profileTableViewController()!
            detailsViewController.delegate = self
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: detailsViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            
            centerNavigationController.didMoveToParentViewController(self)
            
           // let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
          //  centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    
        case .SettingsViewController:
            
            var detailsViewController:ChangePasswordViewController = UIStoryboard.settingsTableViewController()!
            detailsViewController.delegate = self
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: detailsViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            centerNavigationController.didMoveToParentViewController(self)
            
           // let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
           // centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)

        default:
            break
        }
      
    }
    
}


// MARK: CenterViewController delegate
extension ContainerViewController: CenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
          
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseSidePanels() {
       
        switch (currentState) {
            
        case .LeftPanelExpanded:
          
            toggleLeftPanel()
        
        default:
            break
        }
    }
    
    func addLeftPanelViewController() {
        
        if (menuSliderViewController == nil) {
            
            menuSliderViewController = UIStoryboard.menuSliderViewController()
            
            if(GlobalSettings.isAdmin()){
                
                menuSliderViewController!.animals = MenuItem.getAdminMenuItems()

            }else{
                
                menuSliderViewController!.animals = MenuItem.getExecutiveMenuItems()

            }
            
            addChildSidePanelController(menuSliderViewController!)
            
            
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
       
        
        sidePanelController.containerViewDelegate = self
        
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        
        sidePanelController.didMoveToParentViewController(self)
    }
    
    
    func animateLeftPanel(#shouldExpand: Bool) {
       
        if (shouldExpand) {
            
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
            
        } else {
            
            animateCenterPanelXPosition(targetPosition: 0) {finished in
                
                self.currentState = .BothCollapsed
                self.menuSliderViewController!.view.removeFromSuperview()
                self.menuSliderViewController = nil;
            }
        }
    }
    
    func animateCenterPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
 
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        
        if (shouldShowShadow) {
            
            centerNavigationController.view.layer.shadowOpacity = 0.8
            
        } else {
            
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
}

extension ContainerViewController: UIGestureRecognizerDelegate {
    // MARK: Gesture recognizer
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
            
        case .Began:
            
            if (currentState == .BothCollapsed) {
                
                if (gestureIsDraggingFromLeftToRight) {
                    
                    addLeftPanelViewController()
                }
                
                showShadowForCenterViewController(true)
            }
        case .Changed:
            
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
            
        case .Ended:
            if (menuSliderViewController != nil) {
                
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
}
 extension ContainerViewController: ContainerViewControllerDelegate {
    
    func replaceDetailsViewController(row:NSInteger){
    
        self.currentState = .BothCollapsed
        
        centerNavigationController.removeFromParentViewController()
        
        if(GlobalSettings.isAdmin()){
            
            if(row == 0){
                
                addDetailsViewContoller(DetailsViewController.DashboardViewController)
                
            }else if(row == 1){
                
                addDetailsViewContoller(DetailsViewController.RevenueViewController)
                
            }else{
                
                addDetailsViewContoller(DetailsViewController.SettingsViewController)
                
            }
        }else{
            
            if(row == 0){
                
                addDetailsViewContoller(DetailsViewController.DashboardViewController)
                
            }else{
                
                addDetailsViewContoller(DetailsViewController.SettingsViewController)
                
            }
 
        }
        
        
        
    }
    
}
private extension UIStoryboard
{
    class func mainStoryboard() -> UIStoryboard {
    
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }
    
    class func menuSliderViewController() -> SidePanelViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("SidePanelViewController") as? SidePanelViewController
        
    }
    
    class func homeTableViewController() -> HomeTableViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("HomeTableViewController") as? HomeTableViewController
        
    }
    class func settingsTableViewController() -> ChangePasswordViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("ChangePasswordViewController") as? ChangePasswordViewController
        
    }
    class func profileTableViewController() -> ProfileTableViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("ProfileTableViewController") as? ProfileTableViewController
        
    }
    
}