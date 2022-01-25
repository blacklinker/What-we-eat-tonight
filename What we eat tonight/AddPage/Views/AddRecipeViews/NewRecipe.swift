//
//  NewRecipe.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct NewRecipe: View {
    @StateObject var recipeVM: RecipeViewModel = RecipeViewModel()
    @State private var selectedImage: UIImage?
    @State var ifAdd: Bool = false
    @State var selection = [Material]()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                AddRecipeTop(selectedImage: selectedImage, ifAdd: $ifAdd, selected: $selection).environmentObject(recipeVM)
                    .padding()
                NavigationView{
                    MaterialSelectionList(material: recipeVM.materialList, selected: $selection, rawContent: { material in
                        HStack {
                            Text(material.name)
                            Spacer()
                        }
                    })
                }.navigationBarTitle("Material", displayMode: .inline)
            }
            .background(Color(.sRGB, red: 0.73, green: 0.73, blue: 0.73).opacity(0.5))
            
            if(ifAdd){
                AddNewToolbar(selectedImage: $selectedImage, ifAdd: $ifAdd).transition(.move(edge: .bottom))
            }
        }.navigationTitle("Recipe")
            .task {
                await recipeVM.getMaterial()
            }
    }
}

struct NewRecipe_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            NewRecipe()
                .colorScheme(scheme)
            //               .previewLayout(.sizeThatFits)
            //                .previewDevice("iPhone SE")
            //                .previewDevice("iPhone 11")
            //                .previewDevice("iPhone 12")
                .previewDevice("iPhone 13")
            //                .previewDevice("iPhone 13 Pro Max")
            //                .previewLayout(.fixed(width: 500, height: 800))
        }
    }
}
