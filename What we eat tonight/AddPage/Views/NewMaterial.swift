//
//  NewMaterial.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct NewMaterial: View {
    
    @State private var material = ""
    @State private var materials = [String]()
    
    var body: some View {
        VStack{
            Text("材料").font(.title)
            MaterialView(materials: $materials, material: $material)
        }.padding().background(Color(.sRGB, red: 0.73, green: 0.73, blue: 0.73).opacity(0.5))
        
    }
}

struct NewMaterial_Previews: PreviewProvider {
    static var previews: some View {
        NewMaterial()
    }
}
