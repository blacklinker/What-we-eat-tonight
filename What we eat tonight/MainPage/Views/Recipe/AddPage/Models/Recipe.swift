//
//  RecipeModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-23.
//

import Foundation
import FirebaseFirestoreSwift

struct Recipe: Codable, Identifiable{
    @DocumentID var id: String?
    var name: String
    var imageUrl: String
    var material: [RecipeMaterial]
    
    enum RecipeError: Error, LocalizedError, Identifiable{
        case emptyName
        case unknown
        
        var id: String{
            self.localizedDescription
        }
        
        var errorDescription: String?{
            switch self{
            case .emptyName:
                return NSLocalizedString("Name can't be empty", comment: "")
            case .unknown:
                return NSLocalizedString("Unknown error happened", comment: "")
            }
        }
    }
    
}

struct RecipeMaterial: Codable, Identifiable{
    var id: String
    var name: String
    var qty: Int = 0
}
