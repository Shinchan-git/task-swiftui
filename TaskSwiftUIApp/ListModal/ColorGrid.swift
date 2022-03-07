//
//  ColorGrid.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/03/03.
//

import SwiftUI

struct ColorGrid: View {
    @Binding var selectedColorName: String

    private func onColorSelection(colorName: String) {
        self.selectedColorName = colorName
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 6)) {
            ForEach(DefaultData.listColors) { color in
                Button(action: { onColorSelection(colorName: color.name) }) {
                    if color.name == selectedColorName {
                        Image(systemName: "largecircle.fill.circle")
                            .foregroundColor(color.color)
                            .font(.largeTitle)
                    } else {
                        Image(systemName: "circle.fill")
                            .foregroundColor(color.color)
                            .font(.largeTitle)
                    }
                }
                .padding()
            }
        }
    }
}

struct ColorGrid_Previews: PreviewProvider {
    static var previews: some View {
        ColorGrid(selectedColorName: .constant(DefaultData.defaultColor.name))
    }
}
