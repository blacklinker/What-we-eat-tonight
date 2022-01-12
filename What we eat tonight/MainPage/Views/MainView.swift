//
//  File.swift
//  What we eat tonight#imageLiteral(resourceName: "CantFindImage.jpg")
//
//  Created by Cheng Peng on 2022-01-04.
//
import SwiftUI

struct MainView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            RowView()
            RowView()
            RowView()
        }.toolbar {
            ToolbarItem(placement: .navigation){
                TopNav()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
