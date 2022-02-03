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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
