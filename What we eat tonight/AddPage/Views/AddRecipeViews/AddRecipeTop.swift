//
//  AddRecipeTop.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-23.
//

import SwiftUI

struct AddRecipeTop: View {
    @State private var name = ""
    @EnvironmentObject var recipeVM: RecipeViewModel
    
    let selectedImage: UIImage?
    @Binding var ifAdd: Bool
    @Binding var selected: [Material]
    
    var body: some View {
        VStack{
            TextField("Name", text: $name)
                .font(.system(size: 15))
                .frame(height: 30)
                .padding(10)
                .background(.white)
                .cornerRadius(15)
            HStack(alignment: .bottom){
                Button(action: {
                    ifAdd.toggle()
                }){
                    ImageView(selectedImage: selectedImage)
                }
                Spacer()
                Button(action: {
                    Task{
                        await recipeVM.addRecipe(name: name, image: selectedImage!, material: selected)
                    }
                }){
                    Text("Save")
                }.buttonStyle(MyButtonStyle(validated: validated))
            }
        }
    }
    
    
    var validated: Bool {
        !name.isEmpty &&
        selectedImage != nil
    }
    
}
