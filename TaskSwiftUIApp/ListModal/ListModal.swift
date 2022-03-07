//
//  ListModal.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/02/28.
//

import SwiftUI

struct ListModal: View {
    var listId: String?
    @State var title: String = ""
    @State var isDoneEnabled: Bool = false
    @State var selectedColorName: String = DefaultData.defaultColor.name
    @State var selectedIconName: String = DefaultData.defaultIcon.name
    @Environment(\.presentationMode) private var presentationMode
    private let taskListCRUD = TaskListCRUD()
    
    private func onTitleChange(title: String) {
        if title == "" {
            isDoneEnabled = false
        } else {
            isDoneEnabled = true
        }
    }
    
    private func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func done() {
        if title == "" { return }
        if let listId = listId {
            guard let listToUpdate = listToModify(id: listId) else { return }
            taskListCRUD.update {
                listToUpdate.title = title
                listToUpdate.colorName = selectedColorName
                listToUpdate.iconName = selectedIconName
            }
        } else {
            let newList = TaskList(title: title, colorName: selectedColorName, iconName: selectedIconName)
            taskListCRUD.create(list: newList)
        }
        presentationMode.wrappedValue.dismiss()
    }
    
    private func listToModify(id: String) -> TaskList? {
        let allLists = taskListCRUD.readAll()
        let listToModify = allLists.first(where: {
            $0.id == listId
        })
        
        return listToModify
    }
    
    //Body
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .center) {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(DefaultData.listColor(name: selectedColorName))
                                .font(.system(size: 62))
                            Image(systemName: selectedIconName)
                                .foregroundColor(.white)
                                .font(.largeTitle)
                        }
                        TextField("リスト名を入力", text: $title)
                            .onChange(of: title) { newTitle in
                                onTitleChange(title: newTitle)
                            }
                            .submitLabel(.done)
                            .padding(EdgeInsets(top: 10, leading: 6, bottom: 10, trailing: 6))
                            .background(Color(white: 0.96))
                            .cornerRadius(8, antialiased: true)
                            .border(.background, width: 0)
                            .foregroundColor(DefaultData.listColor(name: selectedColorName))
                            .font(.headline)
                    }
                }
                Section {
                    ColorGrid(selectedColorName: $selectedColorName)
                }
                .buttonStyle(.plain) //Removes highlight color on tap
                Section {
                    IconGrid(color: DefaultData.listColor(name: selectedColorName), selectedIconName: $selectedIconName)
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("新規リスト")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel, action: cancel) {
                        Text("キャンセル")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: done) {
                        Text("完了")
                    }
                    .disabled(!isDoneEnabled)
                }
            }
        }
    }
}

struct ListModal_Previews: PreviewProvider {
    static var previews: some View {
        ListModal()
    }
}
