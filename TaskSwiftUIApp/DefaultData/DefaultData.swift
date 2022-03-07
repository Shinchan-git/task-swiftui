//
//  DefaultData.swift
//  TaskSwiftUIApp
//
//  Created by Owner on 2022/03/02.
//

import Foundation
import SwiftUI

struct ListColor: Identifiable {
    let id = UUID().uuidString
    var name: String
    var color: Color
}

struct ListIcon: Identifiable {
    let id = UUID().uuidString
    var name: String
}

class DefaultData {
    
    //Colors
    static let defaultColor = ListColor(name: "blue", color: .blue)
    
    static let listColors = [
        ListColor(name: "red", color: .red),
        ListColor(name: "orange", color: .orange),
        ListColor(name: "yellow", color: .yellow),
        ListColor(name: "green", color: .green),
        ListColor(name: "blue", color: .blue),
        ListColor(name: "purple", color: .purple),
        ListColor(name: "brown", color: .brown),
        ListColor(name: "black", color: .black),
    ]
    
    static func listColor(name: String) -> Color {
        guard let color = self.listColors.first(where: {
            $0.name == name
        }) else { return self.defaultColor.color }
        
        return color.color
    }
    
    //Icons
    static let defaultIcon = ListIcon(name: "list.bullet")
    
    static let listIcons = [
        ListIcon(name: "list.bullet"),
        ListIcon(name: "book.fill"),
        ListIcon(name: "graduationcap.fill"),
        ListIcon(name: "doc.fill"),
        ListIcon(name: "sun.max.fill"),
        ListIcon(name: "moon.fill"),
        ListIcon(name: "snow"),
        ListIcon(name: "flame.fill"),
        ListIcon(name: "drop.fill"),
        ListIcon(name: "gamecontroller.fill"),
        ListIcon(name: "gift.fill"),
        ListIcon(name: "tv"),
        ListIcon(name: "headphones"),
        ListIcon(name: "car.fill"),
        ListIcon(name: "tram.fill"),
        ListIcon(name: "figure.walk"),
        ListIcon(name: "leaf.fill"),
        ListIcon(name: "ladybug.fill"),
        ListIcon(name: "scissors"),
        ListIcon(name: "circle.fill"),
        ListIcon(name: "square.fill"),
        ListIcon(name: "triangle.fill"),
        ListIcon(name: "heart.fill"),
        ListIcon(name: "star.fill")
    ]
    
}
