//
//  CityTableViewController.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-14.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit

protocol SendCityInfoToVC {
    func sendCityInfoBack(cityName: String)

}

class CityTableViewController : UITableViewController  {
    var cityArray : [City] = []
    
   
    
    var delegate: SendCityInfoToVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.preferredContentSize = CGSizeMake(50, 50);
        
        self.view.bounds = CGRectMake(100, 100, 100, 100)
       
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath) as UITableViewCell
        let city = cityArray[indexPath.row]
        
        cell.textLabel?.text = city.name
        cell.detailTextLabel!.text = city.provinceName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let city = cityArray[indexPath.row]
        
        delegate?.sendCityInfoBack(city.name)
        dismissViewControllerAnimated(true, completion: nil)
    }
}

