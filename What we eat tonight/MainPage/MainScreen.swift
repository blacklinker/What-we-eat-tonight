//
//  NavigateView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI
import nanopb

struct MainScreen: View {
    @Binding var myView: MyViews
    @StateObject var loginVM : LoginViewModel
    
    init(_ useremail: String, _ myView: Binding<MyViews>){
        self._loginVM = StateObject(wrappedValue: LoginViewModel(useremail))
        self._myView = myView
    }
    
    var body: some View {
        if !loginVM.ifAuth{
            LoginScreen().environmentObject(loginVM)
                .onAppear{
                    loginVM.autoLogin()
                }
        } else{
            NavigationView{
                VStack{
                    switch myView{
                    case .main: MainView().modifier(AppendNavBar(myView: $myView))
                    case .add: AddScreen().modifier(AppendNavBar(myView: $myView))
                    case .settings: SettingScreen()
                            .modifier(AppendNavBar(myView: $myView))
                            .environmentObject(loginVM)
                    case .search: MainView().modifier(AppendNavBar(myView: $myView))
                    }
                }
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen( "", .constant(.main))
    }
}
