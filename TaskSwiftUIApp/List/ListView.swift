//
//  ListView.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/02/28.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    @ObservedResults(TaskList.self) private var taskLists
    @Environment(\.editMode) private var editMode
    private let taskListCRUD = TaskListCRUD()
    
    private func toggleEditMode() {
        withAnimation() {
            if editMode?.wrappedValue.isEditing == true {
                editMode?.wrappedValue = .inactive
            } else {
                editMode?.wrappedValue = .active
            }
        }
    }
    
    private func onDeleteRow(at indexSet: IndexSet) {
        let listIds = indexSet.map({
            taskLists[$0].id
        })
        let listsToDelete = listsToModify(ids: listIds)
        for list in listsToDelete {
            taskListCRUD.delete(list: list)
        }
    }
    
    private func listsToModify(ids: [String]) -> [TaskList] {
        let allLists = taskListCRUD.readAll()
        let listsToModify = allLists.filter({
            ids.contains($0.id)
        })
        
        return listsToModify
    }
    
    //Body
    var body: some View {
        NavigationView {
            SwiftUI.List {
                ForEach(taskLists) { list in
                    NavigationLink {
                        TaskView(list: list)
                    } label: {
                        ListRow(list: list)
                    }
                }
                .onDelete(perform: { indexSet in  onDeleteRow(at: indexSet)})
                if editMode?.wrappedValue.isEditing == false {
                    NewListRow()
                }
            }
            .navigationTitle("リスト")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: toggleEditMode) {
                        Text(editMode?.wrappedValue.isEditing == true ? "完了" : "編集")
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
