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
   
    
    
    var grid: Grid! {
        didSet {
            setStyle()
        }
    }
    
    private func setStyle() {
        
        let views = [topLeftView,topRightView,botRightView,botLeftView]
        for i in 0..<views.count{
            let value = grid.display[i]
            views[i]?.isHidden = value
        }
    }
    
    func isAvailableToShare () ->Bool {
        
       let containtViews = [topLeftView,topRightView,botRightView,botLeftView] // voir pour ne pas répéter
        
        for i in 0..<containtViews.count {
            
            guard let containtView = containtViews[i] else {return false}
            // subview on decend hierarchiquement dans view et objet dedans
            let imageView = containtView.subviews[0] as? UIImageView
            if !containtView.isHidden, imageView?.image == nil {
                
                return false
            }
            
        }
        return true
    }
}
