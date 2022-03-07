//
//  NewTaskRow.swift.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/03/02.
//

import SwiftUI

struct NewTaskRow: View {
    var listId: String
    @State private var text: String = ""
    private let taskListCRUD = TaskListCRUD()
    
    private func didEndEditing(text: String) {
        if text == "" { return }
        let allLists = taskListCRUD.readAll()
        guard let listToUpdate = allLists.first(where: { list in
            list.id == listId
        }) else { return }
        //Update
        let newTask = Task(text: text)
        taskListCRUD.update {
            listToUpdate.tasks.append(newTask)
        }
        //Clear current TextField
        self.text = ""
    }
    
    var body: some View {
        HStack {
            TextField("タスクを新規作成", text: $text)
                .onSubmit { didEndEditing(text: text) }
                .submitLabel(.done)
        }
    }
}

struct NewTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskRow(listId: PreviewData.taskListPreviewData().id)
            .previewLayout(.fixed(width: 375, height: 60))
    }
}
