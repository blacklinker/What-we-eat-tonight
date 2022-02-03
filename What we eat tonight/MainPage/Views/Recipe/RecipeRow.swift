//
//  RecipeRow.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-31.
//

import SwiftUI

struct RecipeRow: View {
    @EnvironmentObject var recipeVM: RecipeViewModel
    let recipeId: String
    let name: String
    let imageUrl : String
    
    init(recipeId: String? = "", name: String = "Can't find recipe", imageUrl: String = "wrong"){
        self.recipeId = recipeId ?? ""
        self.name = name
        self.imageUrl = imageUrl
    }
    
    var body: some View {
        HStack(alignment: .center){
            AsyncImage(url: URL(string: imageUrl),
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
            }.cornerRadius(20)
            .frame(width: 100, height: 100, alignment: .center).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
            Text(self.name).truncationMode(.tail)
            Spacer()
            
            if recipeVM.eatTodayRecipeIds.contains(where: { $0.recipeId == self.recipeId
            }){
                Button(action: {
                    Task {
                        await recipeVM.removeEatToday(recipeId: recipeId)
                    }
                }){
                    Text("Added").modifier(TextModifier(.blue))
                }
            }else{
                Button(action: {
                    Task {
                        await recipeVM.addToEatToday(recipeId: recipeId)
                    }
                }){
                    Text("Eat Today").modifier(TextModifier(.green))
                }
            }
            
 
        }.font(.system(size: 14))
        .padding()
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow().environmentObject(RecipeViewModel())
    }
}
