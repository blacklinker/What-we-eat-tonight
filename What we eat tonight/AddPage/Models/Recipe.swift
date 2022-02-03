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
}

struct RecipeMaterial: Codable, Identifiable{
    var id: String
    var name: String
}
