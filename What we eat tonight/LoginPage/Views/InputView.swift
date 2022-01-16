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
            TextField("Username" , text: $loginVM.credentials.email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color.gray.brightness(0.4))
                .cornerRadius(5)
                .padding(.bottom, 20)
            SecureField("Password", text: $loginVM.credentials.password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.brightness(0.4))
                .cornerRadius(5)
                .padding(.bottom, 20)
        }
    }
    
    struct InputView_Previews: PreviewProvider{
        static var previews: some View {
            InputView()
        }
    }
    
}
