//
//  Animal.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
class MenuItem {
  
  let title: String
  let creator: String
  let image: UIImage?
  
  init(title: String, creator: String, image: UIImage?) {
    self.title = title
    self.creator = creator
    self.image = image
  }
  
  class func getAdminMenuItems() -> Array<MenuItem> {
    return [ MenuItem(title: "Projects", creator: "papaija2008", image: UIImage(named: "dashboard.png")),
            MenuItem(title: "Users", creator: "aopsan", image: UIImage(named: "profile.png")),
          MenuItem(title: "Settings", creator: "aopsan", image: UIImage(named: "settings.png"))]
  }
    class func getExecutiveMenuItems() -> Array<MenuItem> {
        return [ MenuItem(title: "Projects", creator: "papaija2008", image: UIImage(named: "dashboard.png")),
             MenuItem(title: "Settings", creator: "aopsan", image: UIImage(named: "settings.png"))]
    }

}