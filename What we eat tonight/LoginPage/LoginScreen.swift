//
//  LoginView.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var loginVM: LoginViewModel
    
    @State var ifRegister = false
    
    var body: some View {
        VStack{
            if loginVM.showProgressView{
                ProgressView()
            }else{
                VStack{
                    WelcomeText()
                    UserImage()
                    InputView().environmentObject(loginVM)
                    if loginVM.error != nil {
                        Text(loginVM.error!.localizedDescription)
                            .animation(.easeInOut, value: 4)
                            .offset(y: -10)
                            .foregroundColor(.red)
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation{
                                        loginVM.error = nil
                                    }
                                }
                            }
                    }
                    Button(action: {
                        loginVM.login()
                    }) {
                        HStack(alignment: .center){
                            Text("LOGIN")
                        }.font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.green)
                            .cornerRadius(15)
                    }
                    Button(action: {ifRegister.toggle()}){
                        Text("Register")
                    }
                }
            }
        }
        .padding()
        .disabled(loginVM.showProgressView)
        .sheet(isPresented: $ifRegister){
            NavigationView{
                RegisterView(ifRegister: $ifRegister).environmentObject(loginVM)
                    .navigationBarTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { self.ifRegister = false }
                        }
                    })
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().environmentObject(LoginViewModel())
    }
}
