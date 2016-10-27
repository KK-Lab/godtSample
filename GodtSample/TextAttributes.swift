//
//  TextAttributes.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 27.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation
import UIKit

enum TextAttributes {
    case Title
    case Description
    case Ingredients
    
    var attributesValue: [String: AnyObject] {
        let color: UIColor
        let font: UIFont
        
        switch self {
        case .Title:
            color = Color.Orange.colorValue
            font = UIFont.systemFontOfSize(18, weight: UIFontWeightBold)
        case .Description:
            color = Color.Gray.colorValue
            font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
        case .Ingredients:
            color = Color.Gray.colorValue
            font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
        }
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        style.lineBreakMode = .ByTruncatingTail
        
        return [
            NSForegroundColorAttributeName: color,
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: style
        ]
    }
}