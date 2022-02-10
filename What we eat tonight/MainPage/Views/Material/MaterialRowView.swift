//
//  MaterialRowView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-10.
//

import SwiftUI

struct MaterialRowView: View {
    let material: MainRecipeMaterial
    
    var body: some View {
        HStack{
            Text(material.name)
            Spacer()
            Text("In Stock:")
            if material.qty > 0 {
                if material.inStock >= material.qty {
                    Text(String(material.inStock)).foregroundColor(.green)
                    Text("(")
                    Text("-" + String(material.qty)).foregroundColor(.red)
                    Text(")")
                }else{
                    Text(String(material.inStock)).foregroundColor(.red)
                    Text("(")
                    Text("-" + String(material.qty)).foregroundColor(.red)
                    Text(")")
                }
            }else{
                Text(String(material.inStock)).foregroundColor(.green)
            }
        }.font(.system(size: 13))
    }
}
