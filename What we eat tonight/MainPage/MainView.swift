//
//  File.swift
//  What we eat tonight#imageLiteral(resourceName: "CantFindImage.jpg")
//
//  Created by Cheng Peng on 2022-01-04.
//
import SwiftUI

struct MainView: View {
    @State var subView: SubViews = .eat
    
    var body: some View {
        VStack{
            switch subView {
            case .recipe: MainRecipeView()
            case .eat : RowView()
            case .material : MaterialsView()
            }
        }.toolbar {
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
