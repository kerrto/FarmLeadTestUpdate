//
//  CityTableViewController.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-14.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit

class CityTableViewController : UITableViewController {
    var cityArray : [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = CGRectMake(0, 0, 200, 200)
        print(cityArray)
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
}

