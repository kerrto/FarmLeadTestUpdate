//
//  NSCacheExtension.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-28.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import Foundation


extension NSCache {
    class var sharedInstance : NSCache {
        struct Static {
            static let instance : NSCache = NSCache()
        }
        return Static.instance
    }
}
