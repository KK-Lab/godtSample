//
//  RecipeEntity.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 26.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import UIKit
import RealmSwift

class RealmString: Object {
    dynamic var stringValue: String = ""
    
    override static func primaryKey() -> String? {
        return "stringValue"
    }
}

class RecipeEntity: Object {
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var fullDescription: String = ""
    dynamic var imageURL: String = ""
    let _ingredients = List<RealmString>()
    
    var ingredients: [String] {
        set {
            self._ingredients.removeAll()
            self._ingredients.appendContentsOf(newValue.map { RealmString(value: [$0]) })
        }
        get {
            return self._ingredients.map { $0.stringValue }
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["ingredients"]
    }
}