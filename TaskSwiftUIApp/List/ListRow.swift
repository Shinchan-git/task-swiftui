//
//  ListRow.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/02/28.
//

import SwiftUI

struct ListRow: View {
    var list: TaskList
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(DefaultData.listColor(name: list.colorName))
                    .font(.system(size: 30))
                Image(systemName: list.iconName == "" ? DefaultData.defaultIcon.name : list.iconName)
                    .foregroundColor(.white)
            }
            Text(list.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(String(list.tasks.count))
                .foregroundColor(.gray)
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(list: PreviewData.taskListPreviewData())
            .previewLayout(.fixed(width: 375, height: 60))
    }
}
