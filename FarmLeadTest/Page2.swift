//
//  Page2.swift
//  FarmLeadTest
//
//  Created by Kerry Toonen on 2016-08-13.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit

class Page2 : UIViewController {
    
    @IBOutlet weak var phraseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formattedString = NSMutableAttributedString()
        formattedString.bold("Negotiate").normal(" with verified buyers and sellers")
        
        phraseLabel.attributedText = formattedString
    }
    
    
}

