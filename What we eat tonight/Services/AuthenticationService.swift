//
//  LoginService.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import Foundation
import FirebaseAuth

class AuthenticationService{
    static let shared = AuthenticationService()
    
    func login(credentials: Credentials,
               completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { [weak self] authResult, error in
                if authResult != nil, error == nil {
                    completion(.success(true))
                } else {
                    completion(.failure(.invalidCredentials))
                }
            }
        }
    }
    
    func Register(credentials: Credentials,
                  completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { [weak self] authResult, error in
                if authResult != nil, error == nil {
                    completion(.success(true))
                } else {
                    completion(.failure(.invalidUserCreation))
                }
            }
        }
    }
    
    
    func logOut(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
           try? Auth.auth().signOut()
        }
    }
}
