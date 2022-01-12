//
//  BottomNav.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI

struct BottomNav: View {
    
    @Binding var myView: MyViews

    var body: some View {
        HStack(alignment: .center, spacing: 50){
            Button(action: { myView = .main }){
                VStack(alignment: .center, spacing: 10){
                    Image(systemName: "house")
                    Text("主页")
                }.foregroundColor(myView == .main ? .black : .gray)
            }
            Button(action: { myView = .add }){
                VStack(alignment: .center, spacing: 10){
                    Image(systemName: "plus.app")
                    Text("添加")
                }.foregroundColor(myView == .add ? .black : .gray)
            }
            Button(action: { myView = .search }){
                VStack(alignment: .center, spacing: 10){
                    Image(systemName: "magnifyingglass")
                    Text("搜索")
                }.foregroundColor(myView == .search ? .black : .gray)
            }
            Button(action: { myView = .settings }){
                VStack(alignment: .center, spacing: 10){
                    Image(systemName: "person.crop.circle")
                    Text("账号")
                }.foregroundColor(.blue)
            }
        }.font(.system(size: 13))
    }
}

struct BottomNav_Previews: PreviewProvider {
    static var previews: some View {
        BottomNav(myView: .constant(.main))
    }
}
