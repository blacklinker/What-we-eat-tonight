//
//  MaterialSelectionList.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-24.
//

import SwiftUI

struct MaterialSelectionList<Item: Identifiable, Content: View>: View {
    var material : [Item]
    @Binding var selected: [Item]
    var rawContent: (Item) -> Content
    
    var body: some View {
        List(material) { item in
            rawContent(item)
                .modifier(CheckmarkModifier(checked: self.selected.contains{ $0.id == item.id }))
                .contentShape(Rectangle())
                .onTapGesture {
                    if selected.contains(where: { $0.id == item.id }){
                        selected.removeAll(where: { $0.id == item.id })
                    }
                    else{
                        selected.append(item)
                    }
                }
        }
    }
}

struct CheckmarkModifier: ViewModifier {
    var checked: Bool = false
    func body(content: Content) -> some View {
        Group {
            if checked {
                ZStack(alignment: .trailing) {
                    content
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.green)
                        .shadow(radius: 1)
                }
            } else {
                content
            }
        }
    }
}
