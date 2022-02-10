//
//  RecipeView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-26.
//

import SwiftUI

struct MainRecipeView: View {
    @EnvironmentObject var mainRecipeVM: MainRecipeViewModel
    
    var body: some View {
        GeometryReader{ bounds in
            VStack{
                //                switch mainRecipeVM.state{
                //                case .loading:
                //                    ProgressView()
                //                case .success:
                List{
                    ForEach(mainRecipeVM.recipesList){ recipe in
                        RecipeRow(recipe: recipe).swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive){
                                Task{
                                    await mainRecipeVM.deleteRecipe(id: recipe.id ?? "", imageUrl: recipe.imageUrl)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }.buttonStyle(.borderless)
                    }
                }.background(.white)
                    .environmentObject(mainRecipeVM)
                //                default:
                //                    Text("Something went wrong")
                //                }
            }
            .frame(width: bounds.size.width, height: bounds.size.height, alignment: .center)
        }
    }
}
