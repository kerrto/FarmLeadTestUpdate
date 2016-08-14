//
//  CommoditiesTableViewController.swift
//  
//
//  Created by Kerry Toonen on 2016-08-14.
//
//

import UIKit



class CommoditiesTableViewController : UITableViewController {
    var commodities : [CommodityUnit] = []
    
    var commodityCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseCache()
       
        
       
        
       // print(self.commodityCache.objectForKey("commodityUnits"))
        
        self.view.frame = CGRectMake(0, 0, 200, 200)
      
    }
    
    func parseCache() {
         let commodityUnitArray = NSCache.sharedInstance.objectForKey("commodityUnits") as! NSArray
        
        for commodity in commodityUnitArray  {
            let newCommodity = CommodityUnit(name: commodity.objectForKey("name") as! String, nameRaw: commodity.objectForKey("name_raw") as! String, defaultVal: commodity.objectForKey("default") as! Int, nameShort: commodity.objectForKey("name_short") as! String, order: commodity.objectForKey("order") as! Int)
            
            commodities.append(newCommodity)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commodities.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CommodityCell", forIndexPath: indexPath) as UITableViewCell
        
        let commodity = commodities[indexPath.row]
        
        cell.textLabel?.text = commodity.name
      
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
