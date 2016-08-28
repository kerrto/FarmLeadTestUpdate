//
//  Page1.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-13.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit

class Page1 : UIViewController {
    
    @IBOutlet weak var phraseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formattedString = NSMutableAttributedString()
        formattedString.bold("Post").normal(" an offer to buy or sell grain, or ").bold("search ").normal("the marketplace")
        phraseLabel.attributedText = formattedString
    }
    
    
}

