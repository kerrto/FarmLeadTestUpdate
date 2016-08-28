//
//  AttributedString.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-28.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func bold(text:String) -> NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "HelveticaNeue-Bold", size: 20)!]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.appendAttributedString(boldString)
        return self
    }
    
    func normal(text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.appendAttributedString(normal)
        return self
    }
}