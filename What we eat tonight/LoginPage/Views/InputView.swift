//
//  InputView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI

struct InputView: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        VStack{
            TextField("Username/Email" , text: $loginVM.credentials.email)
                .modifier(LoginTextFieldModifier())
                .keyboardType(.emailAddress)
            SecureField("Password", text: $loginVM.credentials.password)
                .modifier(LoginTextFieldModifier())
        }
    }
    
    struct InputView_Previews: PreviewProvider{
        static var previews: some View {
            InputView()
        }
    }
    
}
