//
//  File.swift
//  What we eat tonight#imageLiteral(resourceName: "CantFindImage.jpg")
//
//  Created by Cheng Peng on 2022-01-04.
//
import SwiftUI

struct MainView: View {
    @State var subView: SubViews = .recipe
    @StateObject var recipeVM: RecipeViewModel = RecipeViewModel()
    
    var body: some View {
        VStack{
            switch subView {
            case .recipe: MainRecipeView().environmentObject(recipeVM)
            case .eat : EatMainView().environmentObject(recipeVM)
            case .material : MaterialsView().environmentObject(recipeVM)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigation){
                TopNav(subView: $subView)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
