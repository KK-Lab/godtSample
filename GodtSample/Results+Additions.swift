//
//  Results+Additions.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 27.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import RealmSwift

extension Results {
    func loadToArray() -> [Element] {
        var array: [Element] = []
        
        for entity in self {
            array.append(entity)
        }
        
        return array
    }
}