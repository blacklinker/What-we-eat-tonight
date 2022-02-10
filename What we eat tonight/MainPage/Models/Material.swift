//
//  Material.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-12.
//

import Foundation
import FirebaseFirestoreSwift

struct Material: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var qty: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case qty
    }
    
    enum MaterialError: Error, LocalizedError, Identifiable{
        case emptyName
        case negativeQty
        case unknown
        
        var id: String{
            self.localizedDescription
        }
        
        var errorDescription: String?{
            switch self{
            case .emptyName:
                return NSLocalizedString("Name can't be empty", comment: "")
            case .negativeQty:
                return NSLocalizedString("Quantity is incorrect", comment: "")
            case .unknown:
                return NSLocalizedString("Unknown error happened", comment: "")
            }
        }
    }
}

