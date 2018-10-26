//
//  UIImagePickerController.swift
//  Instagrid
//
//  Created by Thomas Bouges on 18-10-25.
//  Copyright © 2018 Thomas Bouges. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    
    // on impose true permet la rotation
    open override var shouldAutorotate: Bool { return true }
    
    //On autorise a tourner dans toute les interfaces
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {return .all}
    
}
