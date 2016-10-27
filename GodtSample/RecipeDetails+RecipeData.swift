//
//  Details+ViewData.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 25.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation

extension RecipeDetails {
    
    struct RecipeData {
        let title: String
        let fullDescription: String
        let imageURL: NSURL
        let ingredients: [String]
    }
}