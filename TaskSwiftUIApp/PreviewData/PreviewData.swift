//
//  PreviewData.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/03/02.
//

import Foundation
class PreviewData {
    
    static func taskListPreviewData() -> TaskList {
        return TaskList(title: "リスト名", colorName: DefaultData.defaultColor.name, iconName: DefaultData.defaultIcon.name)
    }
    
    static func taskPreviewData() -> Task {
        return Task(text: "タスク名")
    }
    
}
