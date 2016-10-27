//
//  RealmDatabaseService.swift
//  GodtSample
//
//  Created by Krzysztof Kaczmarek on 26.10.2016.
//  Copyright © 2016 KK Laboratory. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmDatabaseService {
    private var realmDatabase: Realm?
    
    init() {
        self.realmDatabase = try? Realm()
    }
}

extension RealmDatabaseService {
    // MARK: Public API
    
    func addEntities(entities: [Object], update: Bool = true) {
        do {
            try self.realmDatabase?.write { [weak realmDatabase] in
                realmDatabase?.add(entities, update: update)
            }
        }
        catch {
            print("Fatal Database Error")
        }
    }
    
    func fetchEntities<T: Object>(type: T.Type) -> Results<T>? {
        let entities = self.realmDatabase?.objects(type)
        
        return entities
    }
}