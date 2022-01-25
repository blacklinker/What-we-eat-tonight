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
            MaterialView()
        }.navigationTitle("Material")
    }
}

struct NewMaterial_Previews: PreviewProvider {
    static var previews: some View {
        NewMaterial()
    }
}
