//
//  RecipeView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-26.
//

import SwiftUI

struct MainRecipeView: View {
    @EnvironmentObject var recipeVM: RecipeViewModel
    
    var body: some View {
        VStack{
            switch recipeVM.state{
            case .loading:
                ProgressView()
            case .success:
                List{
                    ForEach(recipeVM.recipesList){ recipe in
                        RecipeRow(recipeId: recipe.id, name: recipe.name, imageUrl: recipe.imageUrl).swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive){
                                Task{
                                    await recipeVM.deleteRecipe(id: recipe.id ?? "")
                                    await recipeVM.deleteImage(imageUrl: recipe.imageUrl)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }.buttonStyle(.borderless)
                    }
                }.background(.white)
                    .environmentObject(recipeVM)
            default:
                Text("Something went wrong")
            }
        }
        .task {
            await recipeVM.getRecipes()
            await recipeVM.getEatToday()
        }
    }
}

struct MainRecipeViewPreview: PreviewProvider{
    static var previews: some View{
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            MainRecipeView().environmentObject(RecipeViewModel())
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

