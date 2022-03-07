//
//  TaskList.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/02/28.
//

import Foundation
import RealmSwift

class TaskList: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String
    @Persisted var colorName: String = DefaultData.defaultColor.name
    @Persisted var iconName: String = DefaultData.defaultIcon.name
    @Persisted var tasks: RealmSwift.List<Task>
    
    convenience init(title: String, colorName: String, iconName: String) {
        self.init()
        self.title = title
        self.colorName = colorName
        self.iconName = iconName
    }
    
    convenience init(id: String, title: String, colorName: String, iconName: String, tasks: RealmSwift.List<Task>) {
        self.init()
        self.id = id
        self.title = title
        self.colorName = colorName
        self.iconName = iconName
        self.tasks = tasks
    }
    
}
