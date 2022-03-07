//
//  TaskCRUD.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/03/02.
//

import Foundation
import RealmSwift

class TaskCRUD {
    
    private var realm = try! Realm()
    
    func update(_ action: () -> Void) {
        try! realm.write {
            action()
        }
    }
    
    func delete(task: Task) {
        try! realm.write {
            realm.delete(task)
        }
    }
    
}
