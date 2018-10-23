//
//  ViewController.swift
//  Instagrid
//
//  Created by Thomas Bouges on 18-10-22.
//  Copyright © 2018 Thomas Bouges. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gridView: GridView!
    @IBOutlet var gridPatternButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridPatternButtons[0].isSelected = false
        gridPatternButtons[1].isSelected = true
        gridPatternButtons[2].isSelected = false
    }

    @IBAction func gridButton(_ sender: UIButton) {
        
        // for each to change button form
        gridPatternButtons.forEach { $0.isSelected = false }
        sender.isSelected = true
        
        
        
    }
    
}

