//
//  UIView.swift
//  Instagrid
//
//  Created by Thomas Bouges on 18-10-25.
//  Copyright © 2018 Thomas Bouges. All rights reserved.
//

import UIKit

extension UIView {
    
    func convertToImage () -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil}
        UIGraphicsEndImageContext()
        return image
        
    }
    
}
