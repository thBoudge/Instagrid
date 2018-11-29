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
    @IBOutlet private var botRightView: UIView!
    @IBOutlet private var botLeftView: UIView!
   
    // lazy variable initiate only when var is called
    lazy var views = [topLeftView,topRightView,botRightView,botLeftView]
    
    var grid: Grid! {
        didSet {
            setStyle()
        }
    }
    
    private func setStyle() {
        for i in 0..<views.count{
            let value = grid.display[i]
            views[i]?.isHidden = value
        }
    }
    
    func isAvailableToShare () ->Bool {
        for i in 0..<views.count {
            
            guard let containtView = views[i] else {return false}
            let imageView = containtView.subviews[0] as? UIImageView  // subviews : hierarchy view here View->UiImageView(0)->button(1)
            if !containtView.isHidden, imageView?.image == nil {
                return false
            }
        }
        return true
    }
}


