//
//  RecipeRow.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-31.
//

import SwiftUI

struct RecipeRow: View {
    @EnvironmentObject var mainRecipeVM: MainRecipeViewModel
    let recipe: Recipe
    
    init(recipe: Recipe){
        self.recipe = recipe
    }
    
    var body: some View {
        HStack(alignment: .center){
            AsyncImage(url: URL(string: recipe.imageUrl),
                       transaction: Transaction(animation: .easeInOut)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .transition(.scale(scale: 0.1, anchor: .center))
                case .failure:
                    Image(uiImage: UIImage(named: "CantFindImage.jpg")!)
                @unknown default:
                    EmptyView()
                }
            }.cornerRadius(10)
            .frame(width: 70, height: 70, alignment: .center).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
            Text(recipe.name)
            Spacer()
            
            if mainRecipeVM.eatTodayRecipeIds.contains(where: { $0.recipeId == recipe.id
            }){
                Button(action: {
                    Task {
                        await mainRecipeVM.removeEatToday(recipeId: recipe.id ?? "")
                    }
                }){
                    Text("Added").modifier(TextModifier(.blue))
                }
            }else{
                Button(action: {
                    Task {
                        await mainRecipeVM.addToEatToday(recipeId: recipe.id ?? "")
                    }
                }){
                    Text("Eat Today").modifier(TextModifier(.green))
                }
            }
        }.font(.system(size: 14))
            .padding(.leading)
            .padding(.trailing)
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe: Recipe(id: "", name: "", imageUrl: "", material: [])).environmentObject(MainRecipeViewModel())
    }
}
