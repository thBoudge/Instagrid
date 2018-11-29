//
//  UIImagePickerController.swift
//  Instagrid
//
//  Created by Thomas Bouges on 18-10-25.
//  Copyright © 2018 Thomas Bouges. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    
    // We force true in order to have rotation
    open override var shouldAutorotate: Bool { return true }
    
    //We allow rotation in all "Interfaces"
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {return .all}
    
    
}
