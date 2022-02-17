//
//  AddRecipeTop.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-23.
//

import SwiftUI

struct AddRecipeTop: View {
    @EnvironmentObject var addRecipeVM: AddRecipeViewModel
    @Binding var ifAdd: Bool
    
    var body: some View {
        VStack{
            TextField("Name", text: $addRecipeVM.recipe.name)
                .font(.system(size: 15))
                .frame(height: 30)
                .padding(10)
                .background(.white)
                .cornerRadius(15)
            HStack(alignment: .bottom){
                Button(action: {
                    withAnimation{
                        hideKeyboard()
                        ifAdd.toggle()
                    }
                }){
                    ImageView(selectedImage: addRecipeVM.image, imageUrl: addRecipeVM.recipe.imageUrl)
                }
                Spacer()
                Button(action: {
                    Task{
                        await addRecipeVM.addOrUpdateRecipe()
                    }
                }){
                    Text("Save").modifier(TextModifier(.green))
                }.font(.system(size: 15))
            }
        }
    }
}
