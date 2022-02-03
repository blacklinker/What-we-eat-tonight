//
//  EatMainView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-02.
//

import SwiftUI

struct EatMainView: View {
    @EnvironmentObject var recipeVM: RecipeViewModel
 
    var body: some View {
        VStack{
            switch recipeVM.state{
            case .loading:
                ProgressView()
            case .success:
                List{
                    ForEach(recipeVM.todayRecipes){ recipe in
                        RowView(recipe: recipe)
                            .buttonStyle(.borderless)
                    }
                }.environmentObject(recipeVM)
            default:
                Text("Something went wrong")
            }
        }.task {
            await recipeVM.getTodayRecipe()
        }
    }
}

struct EatMainView_Previews: PreviewProvider {
    static var previews: some View {
        EatMainView()
    }
}
