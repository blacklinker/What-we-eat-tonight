//
//  AddMaterialRow.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-05.
//

import SwiftUI

struct AddMaterialRow: View {
    @EnvironmentObject var materialVM: MaterialViewModel
    let material: Material
    var body: some View {
        NavigationLink(destination: MaterialEditView(material).environmentObject(materialVM)){
            HStack{
                Text(material.name)
                Spacer()
                if material.qty <= 0 {
                    Text(String("Out of stock"))
                } else {
                    Text("In Stock: ")
                    Text(String(material.qty)).foregroundColor(.green)
                }
            }
        }
        
    }
}
