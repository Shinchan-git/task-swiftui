//
//  TaskRow.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/02/28.
//

import SwiftUI

struct TaskRow: View {
    var task: Task
    var list: TaskList
    @State private var text: String = ""
    private let taskListCRUD = TaskListCRUD()
    private let taskCRUD = TaskCRUD()
    
    private func didTextFieldAppear() {
        self.text = task.text
    }
    
    private func didEndEditing(text: String) {
        guard let taskToModify = taskToModify(listId: list.id, taskId: task.id) else { return }
        if text == "" {
            //Delete
            taskCRUD.delete(task: taskToModify)
        } else {
            //Update
            taskCRUD.update {
                taskToModify.text = text
            }
        }
    }
    
    private func toggleIsDone() {
        guard let taskToModify = taskToModify(listId: list.id, taskId: task.id) else { return }
        //Update
        taskCRUD.update {
            taskToModify.isDone.toggle()
        }
    }
    
    private func taskToModify(listId: String, taskId: String) -> Task? {
        let allLists = taskListCRUD.readAll()
        guard let listToModify = allLists.first(where: {
            $0.id == listId
        }) else { return nil }
        guard let taskToModify = listToModify.tasks.first(where: {
            $0.id == taskId
        }) else { return nil }
        
        return taskToModify
    }
    
    //Body
    var body: some View {
        HStack {
            Button(action: toggleIsDone) {
                if task.isDone {
                    Image(systemName: "largecircle.fill.circle")
                        .foregroundColor(DefaultData.listColor(name: list.colorName))
                        .font(.title2)
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
            }
            TextField("", text: $text)
                .onSubmit { didEndEditing(text: text) }
                .onAppear { didTextFieldAppear() }
                .submitLabel(.done)
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: PreviewData.taskPreviewData(), list: PreviewData.taskListPreviewData())
            .previewLayout(.fixed(width: 375, height: 60))
    }
}
