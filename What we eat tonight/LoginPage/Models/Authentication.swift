//
//  Authentication.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-07.
//

import Foundation
import SwiftUI

class Authentication: ObservableObject{
    @Published var isValidated = false
    
    enum AuthenticationError: Error, LocalizedError, Identifiable{
        case invalidCredentials
        case invalidUserCreation
        case emptyEmail
        case emptyPassword
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String?{
            switch self{
            case .invalidCredentials:
                return NSLocalizedString("Either your email or password is incorrect. Please try again", comment: "")
            case .invalidUserCreation :
                return NSLocalizedString("Can't create user, please try again", comment: "")
            case .emptyEmail:
                return NSLocalizedString("Email can't be empty", comment: "")
            case .emptyPassword:
                return NSLocalizedString("Password can't be empty", comment: "")
            }
            }
    }
    
    func updateValidation(success: Bool){
        withAnimation{
            isValidated = success
        }
    }
    
}
