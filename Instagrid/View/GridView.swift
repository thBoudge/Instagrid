//
//  GridView.swift
//  Instagrid
//
//  Created by Thomas Bouges on 18-10-22.
//  Copyright © 2018 Thomas Bouges. All rights reserved.
//

import UIKit

class GridView: UIView {

    @IBOutlet private var topLeftView: UIView!
    @IBOutlet private var topRightView: UIView!
    @IBOutlet private var BotRightView: UIView!
    @IBOutlet private var BotLeftView: UIView!
   
    var grid: Grid! {
        didSet {
            setStyle()
        }
    }
    
    
    
    private func setStyle() {
        
        let views = [topLeftView,topRightView,BotRightView,BotLeftView]
        for i in 0..<views.count{
            let value = grid.display[i]
            views[i]?.isHidden = value
        }
    }
    
    
}
