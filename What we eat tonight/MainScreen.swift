//
//  NavigateView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI
import nanopb

struct MainScreen: View {
    
    //@State var hideBotNav: Bool = false
    @Binding var myView: MyViews
    
    @StateObject var loginVM = LoginViewModel()
    
    var body: some View {
        
//        if !loginVM.ifAuth{
//            LoginScreen().environmentObject(loginVM)
//        } else{
            NavigationView{
                VStack{
                    switch myView{
                    case .main: MainView().modifier(AppendNavBar(myView: $myView))
                    case .add: AddScreen(myView: $myView)
                    case .settings: MainView().modifier(AppendNavBar(myView: $myView))
                    case .search: MainView().modifier(AppendNavBar(myView: $myView))
                    }
                }
            }
        //}
        
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(myView: .constant(.main))
    }
}
