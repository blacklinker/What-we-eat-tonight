//
//  RecipeView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-26.
//

import SwiftUI

struct MainRecipeView: View {
    @StateObject var recipeVM: RecipeViewModel = RecipeViewModel()
    
    var body: some View {
        VStack{
            switch recipeVM.state{
            case .loading:
                ProgressView()
            case .success:
                List{
                    ForEach(recipeVM.recipesList){ recipe in
                        RecipeRow(name: recipe.name, imageUrl: recipe.imageUrl).swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive){
                                Task{
                                    await recipeVM.deleteRecipe(id: recipe.id ?? "")
                                    await recipeVM.deleteImage(imageUrl: recipe.imageUrl)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }.background(.white)
            default:
                Text("Something went wrong")
            }
        }.task {
            await recipeVM.getRecipes()
        }
    }
}

