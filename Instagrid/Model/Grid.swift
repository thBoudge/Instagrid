//
//  Grid.swift
//  Instagrid
//
//  Created by Thomas Bouges on 18-10-22.
//  Copyright © 2018 Thomas Bouges. All rights reserved.
//

import Foundation

// enum for each three possible grid 
enum Grid {
    case oneTwo, twoOne, four
    var display: [Bool] {
        switch self {
        case .oneTwo:
            return [false, true, false, false]
        case .twoOne:
            return [false, false, false, true]
        case .four:
            return [false, false, false, false]
        // perso: break default is not an obligation if we are doing an enum
        }
    }
    
}



