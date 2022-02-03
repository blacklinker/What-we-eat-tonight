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
                    Text("Main")
                }.foregroundColor(myView == .main ? .black : .white)
            }
            Button(action: { myView = .add }){
                VStack(alignment: .center, spacing: 10){
                    Image(systemName: "plus.app")
                    Text("Add")
                }.foregroundColor(myView == .add ? .black : .white)
            }
            Button(action: { myView = .search }){
                VStack(alignment: .center, spacing: 10){
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.foregroundColor(myView == .search ? .black : .white)
            }
            Button(action: { myView = .settings }){
                VStack(alignment: .center, spacing: 10){
                    Image(systemName: "gearshape")
                    Text("Settings")
                }.foregroundColor(myView == .search ? .black : .white)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Circle()
                        .fill(Color.blue)
                        .frame(width: UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.width * 3)
                        .offset(y: (UIScreen.main.bounds.width) * 1.3)
        )
        .font(.system(size: 13))
    }
}

struct BottomNav_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([
            ColorScheme.light,
            ColorScheme.dark
        ], id :\.self) { scheme in
            BottomNav(myView: .constant(.main))
                .colorScheme(scheme)
            //               .previewLayout(.sizeThatFits)
            //                .previewDevice("iPhone SE")
            //                .previewDevice("iPhone 11")
                            .previewDevice("iPhone 12")
            //                .previewDevice("iPhone 13")
            //                .previewDevice("iPhone 13 Pro Max")
            //                .previewLayout(.fixed(width: 500, height: 800))
        }
    }
}
