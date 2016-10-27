//
//  Color.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 27.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import UIKit

enum Color {
    case Gray
    case Orange
    case LightGray
    
    var colorValue: UIColor {
        let color: UIColor
        switch self {
        case .Gray:
            color = UIColor(red: 56/256, green: 56/256, blue: 56/256, alpha: 1)
        case .Orange:
            color = UIColor(red: 205/256, green: 68/256, blue: 49/256, alpha: 1)
        case .LightGray:
            color = UIColor(red: 227/256, green: 229/256, blue: 226/256, alpha: 1)
        }
        
        return color
    }
}