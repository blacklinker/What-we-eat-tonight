//
//  EatMainView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-02.
//

import SwiftUI

struct EatMainView: View {
    @EnvironmentObject var mainRecipeVM: MainRecipeViewModel
    
    var body: some View {
        GeometryReader{ bounds in
            VStack{
                List{
                    ForEach(mainRecipeVM.todayRecipes){ recipe in
                        RowView(recipe: recipe).swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive){
                                Task{
                                    await mainRecipeVM.removeEatToday(recipeId: recipe.id ?? "")
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }.environmentObject(mainRecipeVM)
            }
            .frame(width: bounds.size.width, height: bounds.size.height, alignment: .center)
        }
    }
}
