//
//  Config.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/03/02.
//

import Foundation
import RealmSwift

class Config {
    
    static func config(v SCHEMA_VERSION: UInt64) -> Realm.Configuration {
        let config = Realm.Configuration(
            schemaVersion: SCHEMA_VERSION,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 4 {
                    migration.enumerateObjects(ofType: Task.className()) { oldObject, newObject in
                        //Do nothing
                    }
                    migration.enumerateObjects(ofType: TaskList.className()) { oldObject, newObject in
                        //Do nothing
                    }
                }
            },
            deleteRealmIfMigrationNeeded: false
        )
        
        return config
    }
    
}
