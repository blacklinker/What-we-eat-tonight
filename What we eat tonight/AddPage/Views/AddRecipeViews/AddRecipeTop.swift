//
//  AddRecipeTop.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-23.
//

import SwiftUI

struct AddRecipeTop: View {
    @EnvironmentObject var addRecipeVM: AddRecipeViewModel
    @Binding var name: String
    let selectedImage: UIImage?
    @Binding var ifAdd: Bool
    
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
                        await addRecipeVM.addRecipe(name: name, image: selectedImage)
                    }
                }){
                    Text("Save").modifier(TextModifier(.green))
                }.font(.system(size: 15))
            }
        }
    }
    
    
    var validated: Bool {
        !name.isEmpty &&
        selectedImage != nil
    }
    
}
