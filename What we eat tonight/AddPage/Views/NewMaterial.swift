//
//  NewMaterial.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct NewMaterial: View {
    var body: some View {
        VStack{
            Text("Materials").font(.title)
            Divider()
            MaterialView()
        }.padding().background(Color(.sRGB, red: 0.73, green: 0.73, blue: 0.73).opacity(0.5))
        
    }
}

struct NewMaterial_Previews: PreviewProvider {
    static var previews: some View {
        NewMaterial()
    }
}
