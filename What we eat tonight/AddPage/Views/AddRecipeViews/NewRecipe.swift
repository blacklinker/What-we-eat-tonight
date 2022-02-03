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
    @State var name = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                AddRecipeTop(name: $name, selectedImage: selectedImage, ifAdd: $ifAdd, selected: $selection).environmentObject(recipeVM)
                    .padding()
                NavigationView{
                    MaterialSelectionList(material: recipeVM.materialList, selected: $selection, rawContent: { material in
                        HStack {
                            Text(material.name)
                            Spacer()
                        }
                    })
                }
            }
            .zIndex(1)
            .background(Color(.sRGB, red: 0.73, green: 0.73, blue: 0.73).opacity(0.5))
            .disabled(recipeVM.state == .loading)
            
            if recipeVM.state == .loading{
                ProgressView().zIndex(3)
            }
            if recipeVM.state == .saved{
                Text("Saved!").foregroundColor(.green)
                    .zIndex(3)
                    .transition(.move(edge: .top))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            withAnimation{
                                recipeVM.state = .na
                                self.selectedImage = nil
                                self.selection = [Material]()
                                self.name = ""
                            }
                        }
                    }
            }
            if ifAdd {
                AddNewToolbar(selectedImage: $selectedImage, ifAdd: $ifAdd)
                    .zIndex(2)
                    .transition(.move(edge: .bottom))
            }
        }
        .navigationTitle("Recipe")
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
