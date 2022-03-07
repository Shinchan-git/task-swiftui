//
//  IconGrid.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/03/03.
//

import SwiftUI

struct IconGrid: View {
    var color: Color
    @Binding var selectedIconName: String
    
    private func onIconSelection(iconName: String) {
        self.selectedIconName = iconName
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 6)) {
            ForEach(DefaultData.listIcons) { icon in
                Button(action: { onIconSelection(iconName: icon.name) }) {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(icon.name == selectedIconName ? color : Color(white: 0.98))
                            .font(.system(size: 42))
                        Image(systemName: icon.name)
                            .foregroundColor(icon.name == selectedIconName ? .white : .gray)
                            .font(.title2)
                    }
                }
                .padding()
            }
        }
    }
}

struct IconGrid_Previews: PreviewProvider {
    static var previews: some View {
        IconGrid(color: DefaultData.defaultColor.color, selectedIconName: .constant(DefaultData.defaultIcon.name))
    }
}
