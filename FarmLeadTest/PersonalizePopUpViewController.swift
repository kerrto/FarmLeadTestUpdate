//
//  PersonalizePopUpViewController.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-13.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit
import Alamofire

class PopUpViewController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, SendCityInfoToVC {
    
    var typedIntextFieldCount = 0
    
     var cityName:String?
    
    var cities : [City] = []
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var commoditiesLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        cityField.delegate = self
        
     
        
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        view.opaque = false
        
        self.popUpView.layer.cornerRadius = 5
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.commoditiesLabelTapped(_:)))
        commoditiesLabel.addGestureRecognizer(tapRecognizer)
        
      
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func commoditiesLabelTapped(gestureRecognizer : UITapGestureRecognizer) {
        performSegueWithIdentifier("goToCommodityUnits", sender: self)
    }
    
     func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("changed the textfield")
        
        cityField.textColor = UIColor.blackColor()
        
        typedIntextFieldCount += 1
        
        if cityField.text?.characters.count > 1 {
            searchCities(cityField.text!)
        }
        
        if typedIntextFieldCount > 1 {
            
        }
        
        return true
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCityTable" {
            

            
            
          
            
            let cityTableViewController = (segue.destinationViewController as! UINavigationController).topViewController as! CityTableViewController
            
            cityTableViewController.cityArray = cities
          // cityTableViewController.preferredContentSize = CGSizeMake(500,600)
            //cityTableViewController.popoverPresentationController!.delegate = self
           cityTableViewController.preferredContentSize = CGSize(width: 50, height: 100)
            
            cityTableViewController.view.frame = CGRectMake(100, 100, 100, 100)

            
            //let popController : UIPopoverPresentationController = cityTableViewController.popoverPresentationController!
            
            //popController.permittedArrowDirections = UIPopoverArrowDirection.Down
            
          //  popController.delegate = self


        }
 
            
        }
    


    func searchCities(shortCityString: String) {
        
        let url = "http://dualstack.FL2-Dev-api02-1164870265.us-east-1.elb.amazonaws.com/api/v2/data/search_region"
        
        let parameters : [String : String] = ["search": cityField.text!]
        
        print(parameters)
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                    
                case .Success(let JSON):
                    
                    let searchedCities = JSON as! NSDictionary
                    
                    
                    let regionsArray = searchedCities.objectForKey("regions") as! NSArray
                    
                    
                    for region in regionsArray {
                        
                        let cityId = region.objectForKey("city_id") as! Int
                        let cityName = region.objectForKey("city_name") as! String
                        let provinceId = region.objectForKey("province_id") as! Int
                        let provinceName = region.objectForKey("province_name") as! String
                        
                        let city = City(id: cityId, name: cityName, provinceId: provinceId, provinceName: provinceName)
                        
                        self.cities.append(city)
                    }
                    
                 
                    
                    self.performSegueWithIdentifier("showCityTable", sender: self)
                    
                                        
                    
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
    
    // MARK: MyProtocol functions
    func sendCityInfoBack(cityName: String) {
        self.cityName =  cityName

    }
}



