//
//  TodayRecipe.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-02.
//

import Foundation
import FirebaseFirestoreSwift

struct TodayRecipe: Codable, Identifiable{
    @DocumentID var id: String?
    var recipeId: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case recipeId
    }
}
