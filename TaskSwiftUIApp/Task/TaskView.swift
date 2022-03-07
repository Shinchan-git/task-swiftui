//
//  TaskView.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/02/28.
//

import SwiftUI

struct TaskView: View {
    var list: TaskList
    @State private var isShowingDone: Bool = true
    @State private var isShowingModal: Bool = false
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.editMode) private var editMode
    private let taskListCRUD = TaskListCRUD()
    private let taskCRUD = TaskCRUD()
    
    private func toggleIsShowingDone() {
        isShowingDone.toggle()
    }
    
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
        let taskIds = indexSet.map({
            list.tasks[$0].id
        })
        guard let tasksToDelete = tasksToModify(ids: taskIds) else { return }
        for task in tasksToDelete {
            taskCRUD.delete(task: task)
        }
    }
    
    private func tasksToModify(ids: [String]) -> [Task]? {
        let allLists = taskListCRUD.readAll()
        guard let listToModify = allLists.first(where: {
            $0.id == list.id
        }) else { return nil }
        let tasksToModify = listToModify.tasks.filter({
            ids.contains($0.id)
        }) as [Task]
        
        return tasksToModify
    }
    
    private func editList() {
        isShowingModal.toggle()
    }
    
    private func removeList() {
        guard let listToRemove = listToModify(id: list.id) else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            taskListCRUD.delete(list: listToRemove)
        }
        presentationMode.wrappedValue.dismiss()
    }
    
    private func listToModify(id: String) -> TaskList? {
        let allLists = taskListCRUD.readAll()
        let listToModify = allLists.first(where: {
            $0.id == id
        })
        
        return listToModify
    }
    
    
    //Body
    var body: some View {
        SwiftUI.List {
            if isShowingDone {
                ForEach(list.tasks) { task in
                    TaskRow(task: task, list: list)
                }
                .onDelete(perform: { indexSet in  onDeleteRow(at: indexSet)})
            } else {
                ForEach(list.tasks) { task in
                    if !task.isDone {
                        TaskRow(task: task, list: list)
                    }
                }
                .onDelete(perform: { indexSet in  onDeleteRow(at: indexSet)})
            }
            if editMode?.wrappedValue.isEditing == false {
                NewTaskRow(listId: list.id)
            }
        }
        .listStyle(.plain)
        .buttonStyle(.plain) //Removes highlight color on tap
        .navigationTitle(list.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if editMode?.wrappedValue.isEditing == true {
                    Button(action: toggleEditMode) {
                        Text("完了")
                    }
                } else {
                    Menu {
                        Button(action: toggleIsShowingDone) {
                            Text(isShowingDone ? "実行済みを非表示" : "実行済みを表示")
                        }
                        Button(action: toggleEditMode) {
                            Text("タスクを編集")
                        }
                        Button(action: editList) {
                            Text("リスト情報を編集")
                        }
                        Button(role: .destructive, action: removeList) {
                            Text("リストを削除")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingModal) {
            ListModal(listId: list.id, title: list.title, isDoneEnabled: true, selectedColorName: list.colorName, selectedIconName: list.iconName)
        }
    }
}

struct TaskView_swift_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(list: PreviewData.taskListPreviewData())
    }
}
