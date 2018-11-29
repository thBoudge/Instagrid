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
        // We transform image in BitMap format
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0) //start context 
        drawHierarchy(in: bounds, afterScreenUpdates: true) // we build image
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil} //we take Image
        UIGraphicsEndImageContext() // We close Contaxt all the time we do need to stop context after have taken image
        return image
        
    }
    
}
