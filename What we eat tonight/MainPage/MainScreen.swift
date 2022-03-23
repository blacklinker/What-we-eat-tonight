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
    @StateObject var mainRecipeVM: MainRecipeViewModel = MainRecipeViewModel()
    
    init(_ useremail: String, _ myView: Binding<MyViews>){
        self._loginVM = StateObject(wrappedValue: LoginViewModel(useremail))
        self._myView = myView
    }
    
    var body: some View {
        if !loginVM.ifAuth{
            LoginScreen().environmentObject(loginVM).task {
                await mainRecipeVM.getAllData()
            }
        } else{
            NavigationView{
                VStack{
                    switch myView{
                    case .main: MainView().environmentObject(mainRecipeVM).modifier(AppendNavBar(myView: $myView))
                    case .settings: SettingScreen()
                            .modifier(AppendNavBar(myView: $myView))
                            .environmentObject(loginVM)
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
