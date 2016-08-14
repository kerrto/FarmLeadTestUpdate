//
//  PopOverBackgroundView.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-13.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit

class CustomPopoverBackgroundView: UIPopoverBackgroundView {
    
    override var arrowOffset: CGFloat {
        
        get{
            return self.arrowOffset
        }
        
        set{
        }
    }
    
    override var arrowDirection: UIPopoverArrowDirection {
        
        get {
            return UIPopoverArrowDirection.Up
        }
        
        set {
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 1.0)
        
        var arrowView = UIImageView(image: UIImage(named: "12_24_pop_black"))
        arrowView.frame = CGRect(x: 17.0, y: -11.0, width: 24.0, height: 12.0)
        self.addSubview(arrowView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func wantsDefaultContentAppearance() -> Bool {
        return false
    }
    
    override class func contentViewInsets() -> UIEdgeInsets{
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    override class func arrowHeight() -> CGFloat {
        return 0.0
    }
    
    override class func arrowBase() -> CGFloat{
        return 24.0
    }
}
