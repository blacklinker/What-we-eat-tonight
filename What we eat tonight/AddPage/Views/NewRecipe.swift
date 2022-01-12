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
    
    @State var  ifAdd: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                TextField("菜名", text: $name)
                    .font(.system(size: 15))
                    .frame(height: 30)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(15)
                HStack(alignment: .bottom){
                    Button(action: {
                        ifAdd.toggle()
                    }){
                        if(selectedImage == nil){
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30, alignment: .center)
                                .padding(10)
                                .background(.white)
                                .cornerRadius(15)
                        }
                        else{
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150, alignment: .center)
                                .background(.white)
                                .cornerRadius(15)
                        }
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
            .toolbar{
                ToolbarItem(placement: .bottomBar ){
                    if(ifAdd){
                        AddNewToolbar(selectedImage: $selectedImage, ifAdd: $ifAdd).zIndex(2)
                    }
                }
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
