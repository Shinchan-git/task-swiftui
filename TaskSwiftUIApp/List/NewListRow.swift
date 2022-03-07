//
//  NewListRow.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/02/28.
//

import SwiftUI

struct NewListRow: View {
    @State private var isShowingModal: Bool = false
    
    func onCreateTask() {
        isShowingModal.toggle()
    }
    
    var body: some View {
        Button(action: onCreateTask) {
            Label("リストを新規作成", systemImage: "folder.badge.plus")
        }
        .sheet(isPresented: $isShowingModal) {
            ListModal(listId: nil)
        }
    }
}

struct NewListRow_Previews: PreviewProvider {
    static var previews: some View {
        NewListRow()
            .previewLayout(.fixed(width: 375, height: 60))
    }
}
