//
//  TopNav.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI

struct TopNav: View {
    @Binding var subView: SubViews
    
    var body: some View {
        HStack(alignment: .center, spacing: 30){
            Button(action: { subView = .recipe }){
                Text("菜谱").modifier(subView == .recipe ? TopNavBarStyle(isSeleced: true) : TopNavBarStyle(isSeleced: false))
            }
            Button(action: { subView = .eat }){
            Text("吃什么").modifier(subView == .eat ? TopNavBarStyle(isSeleced: true) : TopNavBarStyle(isSeleced: false))
            }
            Button(action: { subView = .material }){
            Text("材料").modifier(subView == .material ? TopNavBarStyle(isSeleced: true) : TopNavBarStyle(isSeleced: false))
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .font(.system(size: 13))
    }
}

struct TopNav_Previews: PreviewProvider {
    static var previews: some View {
        TopNav(subView: .constant(.eat))
    }
}
