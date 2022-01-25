//
//  AccountScreen.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-18.
//

import SwiftUI

struct SettingScreen: View {
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        Button(action: {
            loginVM.logOut()
        }) {
            HStack(alignment: .center){
                if loginVM.showProgressView {
                    ProgressView()
                }else{
                    Text("Sign out")
                }
            }.font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.green)
                .cornerRadius(15)
        }
    }
}


struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
