//
//  File.swift
//  What we eat tonight#imageLiteral(resourceName: "CantFindImage.jpg")
//
//  Created by Cheng Peng on 2022-01-04.
//
import SwiftUI

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

struct MainView: View {
    @State var activeView: SubViews = .recipe
    @State var viewState = CGSize.zero
    @EnvironmentObject var mainRecipeVM: MainRecipeViewModel
    
    var body: some View {
        VStack{
            switch mainRecipeVM.state{
            case .failure:
                Text("Something went wrong")
            case .success:
                ZStack{
                    EatMainView()
                        .animation(.easeInOut, value: 1)
                        .environmentObject(mainRecipeVM)
                    MainRecipeView()
                        .offset(x: self.activeView == SubViews.recipe ? 0 : -screenWidth)
                        .offset(x: activeView != .material ? viewState.width : 0)
                        .animation(.easeInOut, value: 1)
                        .environmentObject(mainRecipeVM)
                    MaterialsView()
                        .offset(x: self.activeView == SubViews.material ? 0 : screenWidth)
                        .offset(x: activeView != .recipe ? viewState.width : 0)
                        .animation(.easeInOut, value: 1)
                        .environmentObject(mainRecipeVM)
                }
                .modifier(swipeActionModifier(activeView: $activeView, viewState: $viewState))
                .toolbar {
                    ToolbarItem(placement: .navigation){
                        TopNav(subView: $activeView)
                    }
                }
            default:
                ProgressView()
            }
        } .task {
            await mainRecipeVM.getAllData()
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
