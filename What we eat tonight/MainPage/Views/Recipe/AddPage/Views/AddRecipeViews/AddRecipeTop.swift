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
                .padding(.leading, 10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 0.73, green: 0.73, blue: 0.73), lineWidth: 2))
            
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
        }.padding()
    }
}

struct AddRecipeTop_Preview: PreviewProvider{
    static var previews: some View{
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            AddRecipeTop(ifAdd: .constant(false)).environmentObject(AddRecipeViewModel())
                .colorScheme(scheme)
            //               .previewLayout(.sizeThatFits)
            //                .previewDevice("iPhone SE")
            //                .previewDevice("iPhone 11")
                .previewDevice("iPhone 12")
            //                .previewDevice("iPhone 13")
            //                .previewDevice("iPhone 13 Pro Max")
            //                .previewLayout(.fixed(width: 500, height: 800))
        }
    }
}
