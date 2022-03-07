//
//  Task.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/03/02.
//

import Foundation
import RealmSwift

class Task: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var text: String
    @Persisted var isDone: Bool = false
    @Persisted(originProperty: "tasks") var assignee: LinkingObjects<TaskList>
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    convenience init(id: String, text: String, isDone: Bool) {
        self.init()
        self.id = id
        self.text = text
        self.isDone = isDone
    }
    
}
