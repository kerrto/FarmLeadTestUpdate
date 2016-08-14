//
//  SplashPageViewController.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-13.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class SplashPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(#selector(getCommodityUnits), withObject: nil, afterDelay: 3)

    }
    
  
    

    func getCurrentDateString() -> String {
    
    let currentDate = NSDate()

    let dateFormatter = NSDateFormatter()
        
        
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        
        return convertedDate
    
    }


    func getCommodityUnits() {
        
        let currentDate = getCurrentDateString()
        
        let url = "http://dualstack.FL2-Dev-api02-1164870265.us-east-1.elb.amazonaws.com/api/v2/data"
        
        let parameters: [String: AnyObject] = [
            "data": ["commodityUnit" : currentDate]
    ]
    
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON)
            .validate()
            .responseString { response in
                
                switch response.result {
                    
                    case .Success(let JSON):

                    print(JSON)
                    
                    self.performSegueWithIdentifier("ToOnboarding", sender: self)
                    
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    
                    let alertController = UIAlertController(title: "Network Problem", message: "There was a network error", preferredStyle: .Alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        // ...
                    }
                    alertController.addAction(OKAction)
                    
                    self.presentViewController(alertController, animated: true) {
                        // ...
                    }
                }


}
}
}