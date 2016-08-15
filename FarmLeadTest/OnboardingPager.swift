//
//  OnboardingPager.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-13.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit

class OnboardingPager : UIPageViewController {
    
    func getFirstPage() -> Page1 {
        return storyboard!.instantiateViewControllerWithIdentifier("Page1") as! Page1
    }
    
    func getSecondPage() -> Page2 {
        return storyboard!.instantiateViewControllerWithIdentifier("Page2") as! Page2
    }
    
    func getThirdPage() -> Page3 {
        performSelector(#selector (self.callPersonalizePopup), withObject: nil, afterDelay: 3)
        return storyboard!.instantiateViewControllerWithIdentifier("Page3") as! Page3
    }
    
    override func viewDidLoad() {
        dataSource = self
        setViewControllers([getFirstPage()], direction: .Forward, animated: false, completion: nil)
        
        view.backgroundColor = UIColor(red: 63, green: 143, blue: 91)
        
    }
    
    
}


extension OnboardingPager: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) ->UIViewController? {
        
        if viewController .isKindOfClass(Page3) {
            
            return getSecondPage()
        }
            
        else if viewController .isKindOfClass(Page2) {
            
            return getFirstPage()
        }
            
        else {
            
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if viewController .isKindOfClass(Page1) {
            
            return getSecondPage()
        }
        
        else if viewController .isKindOfClass(Page2) {
            
            return getThirdPage()
        }
        
        else {
            
            return nil
        }
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return 0
    }
    
    func callPersonalizePopup() {
        performSegueWithIdentifier("ToPopUp", sender: self)
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
}
