//
//  RecipeEditView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-16.
//

import SwiftUI

struct RecipeEditView: View {
    @State var recipeName: String
    @State var recipeMaterialList: [RecipeMaterial]
    let recipe: Recipe
    
    init(_ recipe: Recipe){
        self.recipe = recipe
        _recipeName = State(initialValue: recipe.name)
        _recipeMaterialList = State(initialValue: recipe.material)
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Name")){
                    TextField("name", text: $recipeName)
                }
                Section(header: Text("Material")){
                    List{
                        ForEach(recipe.material){ material in
                            HStack{
                                Text(material.name)
                                Spacer()
                                if material.qty > 0{
                                    Text(String(material.qty))
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Recipe")
            }.font(.system(size: 13))
        }
    }
}

struct RecipeEditView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditView(Recipe(id: "", name: "Fried Chicken", imageUrl: "w", material: [
        ]))
    }
}
