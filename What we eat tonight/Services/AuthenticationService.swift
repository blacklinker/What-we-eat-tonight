//
//  LoginService.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-05.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage

class AuthenticationService{
    static let shared = AuthenticationService()
    
    func login(credentials: Credentials,
               completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) {authResult, error in
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
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) {authResult, error in
                if authResult != nil, error == nil {
                    self.addUserToDB(authResult?.user) { result in
                        switch result{
                        case .failure:
                            completion(.failure(.invalidUserCreation))
                        case .success:
                            completion(.success(true))
                        }
                    }
                } else {
                    completion(.failure(.invalidUserCreation))
                }
            }
        }
    }
    
    func addUserToDB(_ user: User?, completion: @escaping (Result<Bool, Error>) -> Void){
        guard user != nil else {
            return
        }
        Firestore.firestore().collection("Users")
            .addDocument(data: ["userId": user?.uid ?? "", "email": user?.email! ?? ""]) { err in
                if let err = err {
                    completion(.failure(err))
                }else{
                    completion(.success(true))
                }
            }
    }
    
    
    func logOut(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            try? Auth.auth().signOut()
        }
    }
}
