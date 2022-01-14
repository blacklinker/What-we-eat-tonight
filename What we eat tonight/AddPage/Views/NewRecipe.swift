//
//  NewRecipe.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct NewRecipe: View {
    
    @State private var selectedImage: UIImage?
    
    @State private var name = ""
    @State private var material = ""
    @State private var materials = [String]()
    
    @State var ifAdd: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                TextField("菜名", text: $name)
                    .font(.system(size: 15))
                    .frame(height: 30)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(15)
                HStack(alignment: .bottom){
                    Button(action: {
                        withAnimation{
                            ifAdd.toggle()
                        }
                    }){
                       ImageView(selectedImage: selectedImage)
                    }
                    Spacer()
                    Button(action: {
                    }){
                        Text("保存")
                    }.buttonStyle(MyButtonStyle(validated: validated))
                }
                Divider()
                Text("材料").font(.title)
                MaterialView(materials: $materials, material: $material)
                Spacer()
            }
            .padding().background(Color(.sRGB, red: 0.73, green: 0.73, blue: 0.73).opacity(0.5))
            
            if(ifAdd){
                AddNewToolbar(selectedImage: $selectedImage, ifAdd: $ifAdd).transition(.move(edge: .bottom))
            }
            
            
        }
    }
    
    var validated: Bool {
        !name.isEmpty &&
        selectedImage != nil
    }
    
    
}

struct NewRecipe_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipe()
    }
}
