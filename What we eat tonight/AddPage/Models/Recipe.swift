//
//  RecipeModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-23.
//

import Foundation

struct Recipe: Codable, Identifiable{
    var id: String
    var name: String
    var imageUrl: String
    var material: [Material]
}
