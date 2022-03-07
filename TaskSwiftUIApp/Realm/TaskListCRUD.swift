//
//  TaskListCRUD.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/03/01.
//

import Foundation
import RealmSwift

class TaskListCRUD {
    
    private var realm = try! Realm()
    
    func create(list: TaskList) {
        try! realm.write {
            realm.add(list)
        }
    }
    
    func readAll() -> [TaskList] {
        let results = realm.objects(TaskList.self)
        var lists: [TaskList] = []
        for result in results {
            lists.append(result)
        }
        
        return lists
    }
    
    func readById(id: String) -> TaskList? {
        let results = realm.objects(TaskList.self)
        guard let result = results.first(where: {
            $0.id == id
        }) else { return nil }
        let list = TaskList(id: result.id, title: result.title, colorName: result.colorName, iconName: result.iconName, tasks: result.tasks)
        
        return list
    }
    
    func update(_ action: () -> Void) {
        try! realm.write {
            action()
        }
    }
    
    func delete(list: TaskList) {
        try! realm.write {
            realm.delete(list)
        }
    }

}
