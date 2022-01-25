//
//  LoginViewModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import Foundation
import SwiftUI
import FirebaseAuth

@MainActor
class LoginViewModel : ObservableObject {
    @Published var credentials: Credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    @Published var ifAuth = false
    
    init(_ email: String = ""){
        credentials.email = email
    }
    
    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(){
        showProgressView = true
        AuthenticationService.shared.login(credentials: credentials){ [unowned self] (result: Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result{
            case .success:
                ifAuth = true
            case .failure(let err):
                self.credentials.password = ""
                withAnimation{
                    error = err
                }
            }
        }
    }
    
    func autoLogin(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            guard Auth.auth().currentUser != nil else{
                return
            }
            self.ifAuth = true
        })
    }
    
    func register(email: String, password: String, completion: @escaping (Bool) -> Void){
        showProgressView = true
        self.credentials.email = email
        self.credentials.password = password
        AuthenticationService.shared.Register(credentials: credentials){ [unowned self] (result: Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result{
            case .success:
                completion(true)
                self.credentials.password = ""
            case .failure(let result):
                self.credentials = Credentials()
                error = result
                completion(false)
            }
        }
    }
    
    func logOut(){
        showProgressView = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            AuthenticationService.shared.logOut()
            self.ifAuth = false
            self.credentials.password = ""
            self.showProgressView = false
        }
    }
    
    deinit{
        print("MaterialViewModel is destoryed")
    }
    
}
