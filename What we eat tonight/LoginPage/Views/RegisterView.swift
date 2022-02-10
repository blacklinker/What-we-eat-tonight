//
//  RegisterView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import SwiftUI

struct RegisterView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var registerResult: Bool = false
    
    @EnvironmentObject var loginVM: LoginViewModel
    
    @Binding var ifRegister: Bool
    
    var body: some View {
        VStack{
            Text("Register").font(.title)
            Section{
                TextField("Email" , text: $username)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.gray.brightness(0.4))
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                SecureField("password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.brightness(0.4))
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                SecureField("confirm password", text: $confirmPassword)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.brightness(0.4))
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                
                if registerResult{
                    Text(loginVM.error?.errorDescription ?? "Succeeded")
                        .foregroundColor(.green)
                        .animation(.easeInOut, value: 4)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation{
                                    registerResult.toggle()
                                }
                            }
                        }
                }
            }
                
            HStack{
                Spacer()
                Button(action: { loginVM.register(email: username, password: password) { result in
                    if result{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation{
                                ifRegister = false
                            }
                        }
                        registerResult = true
                    }else{
                        registerResult = true
                    }
                }}){
                    HStack(alignment: .center){
                        if loginVM.showProgressView {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        }else{
                            Text("Register")
                        }
                    }.font(.headline)
                }.font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(btnColor)
                    .cornerRadius(15)
                    .disabled(!validation)
                Spacer()
            }
            Spacer()
        }.padding()
    }
    
    var validation: Bool {
        !password.isEmpty &&
        password == confirmPassword &&
        !username.isEmpty
    }
    
    var btnColor: Color{
        return validation ? .green : .gray
    }

}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(ifRegister: .constant(false))
    }
}
