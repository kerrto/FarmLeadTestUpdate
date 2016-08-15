//
//  PersonalizePopUpViewController.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-13.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit
import Alamofire
import Popover


class PopUpViewController: UIViewController, UITextFieldDelegate {
    
    var popUpSender = "City"
    
    var typedIntextFieldCount = 0
    
     var cityName:String?
    var commodityId: Int = 0
    var cityId: Int = 0
    
    var cities : [City] = []
    
     var commodities : [CommodityUnit] = []
    
    
    private var popover: Popover!
    private var popoverOptions: [PopoverOption] = [
        .Type(.Down),
        //.BlackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var commoditiesLabel: UILabel!
    
    let prefs : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBAction func saveUserPrefs(sender: AnyObject) {
        let userDict : [String: AnyObject] = ["commodityId": commodityId, "cityId": cityId]
        self.prefs.setObject(userDict, forKey: "userPrefs")
        
        let alertController = UIAlertController(title: "User Info Saved", message: "CommodityId: \(commodityId) City Id: \(cityId)", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
        }
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         parseCache()
        
        cityField.delegate = self
        
        let notification = NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.textFieldDidChange), name: UITextFieldTextDidChangeNotification, object: self.cityField)
        
        
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
    
    
    
    func textFieldDidChange(notif: NSNotificationCenter) {
        
        if self.popover != nil {
       self.popover.dismiss()
        }
        
        if cityField.text?.characters.count >= 2 {
            searchCities(cityField.text!)
        }
        
    }

    
    func commoditiesLabelTapped(gestureRecognizer : UITapGestureRecognizer) {
       // performSegueWithIdentifier("goToCommodityUnits", sender: self)
        
        popUpSender = "Commodities"
        
        
        
        showPopOver(self.commoditiesLabel)
    
    }
    
    func showPopOver(anchorView: UIView) {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/2, height: 200))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = true
        self.popover = Popover(options: self.popoverOptions, showHandler: nil, dismissHandler: nil)
        self.popover.show(tableView, fromView: anchorView)
    }
    
     func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
       
        
        cityField.textColor = UIColor.blackColor()
        
        return true
    }
    
    func parseCache() {
        let commodityUnitArray = NSCache.sharedInstance.objectForKey("commodityUnits") as! NSArray
        
        for commodity in commodityUnitArray  {
            let newCommodity = CommodityUnit(name: commodity.objectForKey("name") as! String, nameRaw: commodity.objectForKey("name_raw") as! String, defaultVal: commodity.objectForKey("default") as! Int, nameShort: commodity.objectForKey("name_short") as! String, order: commodity.objectForKey("order") as! Int, id: commodity.objectForKey("id") as! Int)
            
            commodities.append(newCommodity)
        }
    }

    


    func searchCities(shortCityString: String) {
        
        let url = "http://dualstack.FL2-Dev-api02-1164870265.us-east-1.elb.amazonaws.com/api/v2/data/search_region"
        
        let parameters : [String : String] = ["search": cityField.text!]
        
      
        
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
                    
                    self.popUpSender = "City"
                    
                 self.showPopOver(self.cityField)
                    
                    
                    
                    
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
    //MARK: - TextField Delegate Methods
    
    func resign() {
        self.resignFirstResponder()
    }
    
    func endEditingNow(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {

        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        
        let item = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.endEditingNow) )
        let toolbarButtons = [item]

        keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
        textField.inputAccessoryView = keyboardDoneButtonView
        
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        
        resign()
    }
    
    
    // Clicking away from the keyboard will remove the keyboard.
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
 
        resign()
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true
    }
}

extension PopUpViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if popUpSender == "Commodities" {
            let commodity = commodities[indexPath.row]
            commoditiesLabel.text = commodity.name
            self.commodityId = commodity.id
        } else {
            
            let city = cities[indexPath.row]
            
            cityField.text = city.name
            
            cityId = city.id
            
        }
        self.popover.dismiss()
    }
}

extension PopUpViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if popUpSender == "Commodities" {
        return commodities.count
        } else {
        return
            cities.count
    }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if popUpSender == "Commodities" {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        let commodityUnit = self.commodities[indexPath.row]
        
        cell.textLabel?.text = commodityUnit.name
        return cell
        } else {
            let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
            let city = self.cities[indexPath.row]
            cell.textLabel?.text = city.name
            cell.detailTextLabel?.text = city.provinceName
            return cell
        }
    }
    
}





