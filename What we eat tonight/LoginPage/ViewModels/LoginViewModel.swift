//
//  LoginViewModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-06.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel : ObservableObject {
    @Published var credentials: Credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    @Published var ifAuth = false

    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(completion: @escaping (Bool) -> Void){
        showProgressView = true
        AuthenticationService.shared.login(credentials: credentials){ [unowned self] (result: Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result{
            case .success:
                completion(true)
                ifAuth = true
            case .failure(let auth):
                self.credentials.password = ""
                withAnimation{
                    error = auth
                }
                completion(false)
            }
        }
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
        AuthenticationService.shared.logOut()
        showProgressView = false
        self.ifAuth = false
        self.credentials.password = ""
    }
}
