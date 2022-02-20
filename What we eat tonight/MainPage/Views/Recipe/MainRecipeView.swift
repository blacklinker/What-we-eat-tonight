//
//  RecipeView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-26.
//

import SwiftUI

struct MainRecipeView: View {
    @EnvironmentObject var mainRecipeVM: MainRecipeViewModel
    @State var addRecipe = false
    
    var body: some View {
        ZStack{
            VStack{
                List{
                    ForEach(mainRecipeVM.recipesList){ recipe in
                        NavigationLink(destination: NewRecipe(recipe: recipe).toolbar {
                            Button(action: {
                                Task {
                                    await mainRecipeVM.deleteRecipe(id: recipe.id ?? "", imageUrl: recipe.imageUrl)
                                }
                            }){
                                Text("Delete")
                            }
                        }){
                            RecipeRow(recipe: recipe).buttonStyle(.borderless)
                        }
                    }
                }.background(.white)
                    .environmentObject(mainRecipeVM)
            }.zIndex(1)
            AddButtonView(toggleVar: $addRecipe)
        }
        .sheet(isPresented: $addRecipe, onDismiss: { self.mainRecipeVM.getRecipes() }){
            NavigationView{
                NewRecipe()
                    .navigationBarTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { self.addRecipe = false }
                        }
                    })
            }
        }
    }
}

struct MainRecipe_Previews: PreviewProvider {
    static var previews: some View{
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            MainRecipeView()
                .environmentObject(MainRecipeViewModel())
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
