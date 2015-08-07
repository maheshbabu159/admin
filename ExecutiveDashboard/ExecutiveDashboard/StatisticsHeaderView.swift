//
//  StatisticsHeaderView.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 7/2/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class StatisticsHeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    init(frame: CGRect,headerTitle:NSString, nameTitle:NSString,valueTitle:NSString){
      
        super.init(frame:frame)
            
        var headerTitleLabel = UILabel()
        headerTitleLabel.text = headerTitle as String
        headerTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        headerTitleLabel.textAlignment = NSTextAlignment.Center
        headerTitleLabel.textColor = UIColor.whiteColor()
        headerTitleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        
        var namelabel = UILabel()
        namelabel.text = nameTitle as String
        namelabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        //namelabel.backgroundColor = UIColor.greenColor()
        namelabel.textAlignment = NSTextAlignment.Center
        namelabel.textColor = UIColor.whiteColor()
        
        var valueLable = UILabel()
        valueLable.text = valueTitle as String
        valueLable.setTranslatesAutoresizingMaskIntoConstraints(false)
        //valueLable.backgroundColor = UIColor.redColor()
        valueLable.textAlignment = NSTextAlignment.Center
        valueLable.textColor = UIColor.whiteColor()

        self.addSubview(headerTitleLabel)
        self.addSubview(namelabel)
        self.addSubview(valueLable)
        
        //Views to add constraints to
        let views = Dictionary(dictionaryLiteral: ("HeaderLable",headerTitleLabel),("NameLable",namelabel),("ValueLable",valueLable))
        
        let horizontalConstraintsGreen = NSLayoutConstraint.constraintsWithVisualFormat("H:|[HeaderLable]|", options: nil, metrics: nil, views: views)
        self.addConstraints(horizontalConstraintsGreen)
        
        //Horizontal constraints
        let horizontalConstraintsRedBlue = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[NameLable(>=100,<=300@20)]-0-[ValueLable(==NameLable)]-0-|", options: nil, metrics: nil, views: views)
        self.addConstraints(horizontalConstraintsRedBlue)
        
        //Vertical constraints
        let verticalConstraintsRed = NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[HeaderLable]-5-[NameLable]|", options: nil, metrics: nil, views: views)
        self.addConstraints(verticalConstraintsRed)
        
        let verticalConstraintsBlue = NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[HeaderLable]-5-[ValueLable]|", options: nil, metrics: nil, views: views)
        self.addConstraints(verticalConstraintsBlue)
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
