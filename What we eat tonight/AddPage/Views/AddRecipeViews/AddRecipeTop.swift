//
//  AddRecipeTop.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-23.
//

import SwiftUI

struct AddRecipeTop: View {
    @EnvironmentObject var recipeVM: RecipeViewModel
    
    @Binding var name: String
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
                    withAnimation{
                        ifAdd.toggle()
                    }
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
                        .frame(height: 20)
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                        .padding(.top, 7)
                        .padding(.bottom, 7)
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(15)
                }.font(.system(size: 15))
            }
        }
    }
    
    
    var validated: Bool {
        !name.isEmpty &&
        selectedImage != nil
    }
    
}
