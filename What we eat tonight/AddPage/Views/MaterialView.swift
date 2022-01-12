//
//  MaterialView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct MaterialView: View {
    
    @Binding var materials: [String]
    @Binding var material: String
    
    var body: some View {
        ScrollView(.vertical ,showsIndicators: true){
            VStack(alignment: .leading){
                ForEach(materials, id: \.self){ material in
                    Text(material)
                        .padding(10)
                        .background(.white)
                        .cornerRadius(15)
                }
                
                TextField("材料", text: $material)
                    .font(.system(size: 15))
                    .frame(height: 30)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(15)
                
                    Button(action: {
                        materials.append(material)
                        self.material = ""
                    }){
                        Text("添加材料")
                    }.font(.system(size: 12))
                        .frame(height: 20)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(15)
            }
        }
    }
}

struct MaterialView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialView(materials: .constant([]), material: .constant(""))
    }
}
